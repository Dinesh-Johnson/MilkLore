package com.xworkz.milklore.repository;

import com.xworkz.milklore.entity.MilkProductReceiveEntity;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.EntityTransaction;
import javax.persistence.PersistenceException;
import java.time.LocalDate;
import java.util.Collections;
import java.util.List;

@Slf4j
@Repository
public class MilkProductReceiveRepoImpl implements MilkProductReceiveRepo{

    @Autowired
    private EntityManagerFactory entityManagerFactory;

    @Autowired
    private MilkProductReceiveRepo collectMilkRepository;

    public MilkProductReceiveRepoImpl()
    {
        log.info("CollectMilkRepository impl constructor");
    }

    @Override
    public boolean save(MilkProductReceiveEntity milkProductReceiveEntity) {
        log.info("save method in CollectMilkRepositoryImpl");
        System.out.println(milkProductReceiveEntity);
        EntityManager entityManager=null;
        EntityTransaction entityTransaction=null;
        try {
            entityManager=entityManagerFactory.createEntityManager();
            entityTransaction=entityManager.getTransaction();
            entityTransaction.begin();
            entityManager.persist(milkProductReceiveEntity);
            entityTransaction.commit();
            return true;
        }catch (PersistenceException e)
        {
            log.error(e.getMessage());
            if(entityTransaction!=null)
            {
                entityTransaction.rollback();
                log.error("Insert rollback");
            }
        }finally {
            if(entityManager!=null && entityManager.isOpen())
            {
                entityManager.close();
                log.info("EntityManager is closed");
            }
        }
        return false;
    }

    @Override
    public List<MilkProductReceiveEntity> getAllDetailsByDate(LocalDate collectedDate) {
        log.info("getAllDetailsByDate method in CollectMilkRepositoryImpl");
        EntityManager entityManager = null;
        EntityTransaction entityTransaction = null;
        try {
            entityManager = entityManagerFactory.createEntityManager();
            entityTransaction = entityManager.getTransaction();
            entityTransaction.begin();
            List<MilkProductReceiveEntity> milkProductReceiveEntityList = entityManager.createNamedQuery("getAllDetailsByDate", MilkProductReceiveEntity.class)
                    .setParameter("selectDate", collectedDate)
                    .getResultList();
            entityTransaction.commit();
            return milkProductReceiveEntityList;
        } catch (PersistenceException e) {
            log.error(e.getMessage());
            if (entityTransaction != null) {
                entityTransaction.rollback();
                log.error("Insert rollback");
            }
        } finally {
            if (entityManager != null && entityManager.isOpen()) {
                entityManager.close();
                log.info("EntityManager is closed");
            }
        }
        return null;
    }
    @Override
    public List<MilkProductReceiveEntity> getAllDetailsBySupplierEmail(String email) {
        log.info("getAllDetailsBySupplierEmail method in CollectMilkRepositoryImpl");
        EntityManager entityManager = null;
        try {
            entityManager = entityManagerFactory.createEntityManager();
            List<MilkProductReceiveEntity> milkProductReceiveEntityList = entityManager
                    .createNamedQuery("getAllDetailsBySupplierEmail", MilkProductReceiveEntity.class)
                    .setParameter("email", email)
                    .getResultList();
            log.info("Query returned {} records", milkProductReceiveEntityList.size());
            return milkProductReceiveEntityList;
        } catch (PersistenceException e) {
            log.error("Error fetching milk product details: " + e.getMessage(), e);
        } finally {
            if (entityManager != null && entityManager.isOpen()) {
                entityManager.close();
                log.info("EntityManager is closed");
            }
        }
        return Collections.emptyList();
    }
    @Override
    public int countSuppliersWithCollections(LocalDate startDate, LocalDate endDate) {
        log.info("countSuppliersWithCollections method in collect milk repository");
        EntityManager entityManager=null;
        try{
            entityManager=entityManagerFactory.createEntityManager();
            Long count = entityManager.createQuery(
                            "SELECT COUNT(DISTINCT c.supplier.supplierId) " +
                                    "FROM MilkProductReceiveEntity c " +
                                    "WHERE c.collectedDate BETWEEN :start AND :end",
                            Long.class
                    )
                    .setParameter("start", startDate)
                    .setParameter("end", endDate)
                    .getSingleResult();
            return (count == null) ? 0 : count.intValue();
        }catch (PersistenceException e)
        {
            log.error(e.getMessage());
        }finally {
            if(entityManager!=null && entityManager.isOpen())
            {
                entityManager.close();
                log.info("EntityManager is closed");
            }
        }
        return 0;
    }

    @Override
    public List<Object[]> getEntityForPaymentNotification(LocalDate startDate, LocalDate endDate) {
        log.info("getEntityForPaymentNotification method in collectMilk repo");
        EntityManager entityManager=null;
        List<Object[]> list=null;
        try{
            entityManager=entityManagerFactory.createEntityManager();
            list=entityManager.createQuery("select c.supplier, SUM(c.totalAmount) from MilkProductReceiveEntity c " +
                            "where c.collectedDate between :start and :end group by c.supplier", Object[].class)
                    .setParameter("start",startDate)
                    .setParameter("end",endDate).getResultList();
            return list;
        }catch (PersistenceException e)
        {
            log.error(e.getMessage());
        }finally {
            if(entityManager!=null && entityManager.isOpen())
            {
                entityManager.close();
                log.info("EntityManager is closed");
            }
        }
        return list;
    }

    @Override
    public List<MilkProductReceiveEntity> getCollectMilkDetailsForSupplierById(Integer supplierId, LocalDate start,LocalDate end) {
        log.info("getCollectMilkDetailsForSupplierById method in collect milk repo");
        EntityManager entityManager=null;
        List<MilkProductReceiveEntity> list=null;
        try{
            entityManager=entityManagerFactory.createEntityManager();
            list=entityManager.createQuery("select a from MilkProductReceiveEntity a where a.supplier.supplierId=:id and a.collectedDate between :start and :end order by a.milkProductReceiveId desc", MilkProductReceiveEntity.class)
                    .setParameter("id",supplierId)
                    .setParameter("end",end)
                    .setParameter("start",start)
                    .getResultList();
            return list;
        }catch (PersistenceException e)
        {
            log.error(e.getMessage());
        }finally {
            if(entityManager!=null && entityManager.isOpen())
            {
                entityManager.close();
                log.info("EntityManager is closed");
            }
        }
        return list;
    }

    @Override
    public Double getTotalLitre(Integer supplierId) {
        log.info("getCollectMilkDetailsForSupplierById method in collect milk repo");
        EntityManager entityManager=null;
        Double totalLitre=0.0d;
        try{
            entityManager=entityManagerFactory.createEntityManager();
            totalLitre=entityManager.createQuery("select SUM(c.quantity) FROM MilkProductReceiveEntity c WHERE c.supplier.supplierId = :id",Double.class)
                    .setParameter("id",supplierId).getSingleResult();

            return totalLitre;
        }catch (PersistenceException e)
        {
            log.error(e.getMessage());
        }finally {
            if(entityManager!=null && entityManager.isOpen())
            {
                entityManager.close();
                log.info("EntityManager is closed");
            }
        }
        return totalLitre;
    }
    @Override
    public Integer getCountOFMilkDetailsByEmail(String email) {
        log.info("getCountOFMilkDetailsByEmail method in milk collect repository");
        EntityManager entityManager=null;
        int count=0;
        try {
            entityManager=entityManagerFactory.createEntityManager();
            Long count1=(Long) entityManager.createNamedQuery("getMilkDetailsCountByEmail")
                    .setParameter("email",email)
                    .getSingleResult();
            count=count1.intValue();
        }catch (PersistenceException e)
        {
            log.error(e.getMessage());
        }finally {
            if(entityManager!=null && entityManager.isOpen())
            {
                entityManager.close();
                log.info("EntityManager is closed");
            }
        }
        return count;
    }

    @Override
    public LocalDate getLastCollectedDate(Integer supplierId) {
        log.info("getLastCollectedDate method in collect milk repo");
        EntityManager entityManager=null;
        LocalDate lastDate=null;
        try{
            entityManager=entityManagerFactory.createEntityManager();
            lastDate=entityManager.createQuery("select MAX(c.collectedDate) FROM MilkProductReceiveEntity c WHERE c.supplier.supplierId = :id",LocalDate.class)
                    .setParameter("id",supplierId).getSingleResult();

            return lastDate;
        }catch (PersistenceException e)
        {
            log.error(e.getMessage());
        }finally {
            if(entityManager!=null && entityManager.isOpen())
            {
                entityManager.close();
                log.info("EntityManager is closed");
            }
        }
        return lastDate;
    }
}