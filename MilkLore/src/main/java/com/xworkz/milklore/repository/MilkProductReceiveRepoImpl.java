package com.xworkz.milklore.repository;

import com.xworkz.milklore.entity.MilkProductReceiveEntity;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.EntityTransaction;
import javax.persistence.PersistenceException;

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
}
