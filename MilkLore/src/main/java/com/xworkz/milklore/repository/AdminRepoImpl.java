package com.xworkz.milklore.repository;

import com.xworkz.milklore.entity.AdminEntity;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.PersistenceException;
import java.util.HashMap;
import java.util.Map;

@Repository
@Slf4j
public class AdminRepoImpl implements AdminRepo{

    @Autowired
    EntityManagerFactory emf;

    private final Map<String,Integer> map=new HashMap<>();


    @Override
    public boolean save(AdminEntity adminEntity) {
        log.info("Admin save method in repo");
        System.out.println(adminEntity);
        EntityManager em=null;
        try {
            em = emf.createEntityManager();
            em.getTransaction().begin();
            em.persist(adminEntity);
            em.getTransaction().commit();
            return true;
        }catch(Exception e) {
            log.error("Exception in Admin save method in repo:{}",e.getMessage());
        }finally {
            if(em!=null) {
                em.close();
            }
        }
        return false;
    }


    @Override
    public AdminEntity viewAdminByEmail(String email) {
        log.info("Admin viewAdminByEmail method in repo");
        EntityManager em=null;
        AdminEntity adminEntity=null;
        try {
            em = emf.createEntityManager();
            em.getTransaction().begin();
            adminEntity = em.createNamedQuery("viewAdminByEmail",AdminEntity.class).setParameter("email",email).getSingleResult();
            return adminEntity;
        }catch(Exception e) {
            log.error("Exception in Admin viewAdminByEmail method in repo:{}",e.getMessage());
        }finally {
            if(em!=null && em.isOpen())
            {
                em.close();
                log.info("EntityManager is closed");
            }
        }
        return adminEntity;
    }


    @Override
    public boolean updateAdminDetails(String email, String adminName, String mobileNumber, String profilePath) {
        log.info("Admin updateAdminDetails method in repo");
        EntityManager em = null;
        AdminEntity adminEntity=null;
        try {
            em = emf.createEntityManager();
            em.getTransaction().begin();
            adminEntity = em.createNamedQuery("viewAdminByEmail",AdminEntity.class).setParameter("email",email).getSingleResult();
            if (adminName==null){
                return false;
            }
            adminEntity.setAdminName(adminName);
            adminEntity.setMobileNumber(mobileNumber);
            if(profilePath!=null && !profilePath.isEmpty()){
                adminEntity.setProfilePath(profilePath);
            }
            em.merge(adminEntity);
            em.getTransaction().commit();
            return true;

        }catch(Exception e) {
            log.error("Exception in Admin updateAdminDetails method in repo:{}",e.getMessage());
            return false;
        }finally {
            if(em!=null) {
                em.close();
            }
        }
    }

    @Override
    public boolean loginAttemptBlockedEmail(String email, boolean isBlocked) {
        log.info("Admin loginAttemptBlockedEmail method in repo");
        EntityManager em=null;
        AdminEntity adminEntity=null;
        try {
            em = emf.createEntityManager();
            em.getTransaction().begin();
            adminEntity = em.createNamedQuery("viewAdminByEmail",AdminEntity.class).setParameter("email",email).getSingleResult();
            if(adminEntity==null)
                return false;
            adminEntity.setBlockedStatus(isBlocked);
            em.merge(adminEntity);
            em.getTransaction().commit();
            return true;
        }catch(PersistenceException e) {
            log.error("Exception in Admin loginAttemptBlockedEmail method in repo:{}",e.getMessage());
            if(em.getTransaction()!=null) {
                em.getTransaction().rollback();
                log.info("Transaction rolled back");
            }
        }finally {
            if(em!=null) {
                em.close();
            }
        }
        return false;
    }

    @Override
    public boolean setPasswordByEmail(String email, String password, String confirmPassword) {
        log.info("Admin setPasswordByEmail method in repo");
        EntityManager em=null;
        AdminEntity adminEntity=null;
        try {
            em = emf.createEntityManager();
            em.getTransaction().begin();
            adminEntity = em.createNamedQuery("viewAdminByEmail",AdminEntity.class).setParameter("email",email).getSingleResult();
            if(adminEntity==null)
                return false;
            adminEntity.setPassword(password);
            adminEntity.setConfirmPassword(confirmPassword);
            adminEntity.setBlockedStatus(false);
            em.merge(adminEntity);
            em.getTransaction().commit();
            return true;
        }catch (PersistenceException e){
            log.error("Exception in Admin setPasswordByEmail method in repo:{}",e.getMessage());
            if(em.getTransaction()!=null) {
                em.getTransaction().rollback();
                log.info("Transaction rolled back");
            }
        }finally {
            if(em!=null && em.isOpen()) {
                em.close();
                log.info("EntityManager closed");
            }
        }
        return false;
    }


}
