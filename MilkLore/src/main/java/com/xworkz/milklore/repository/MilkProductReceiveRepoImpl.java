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
                    .setParameter("collectedDate", collectedDate)
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

}
