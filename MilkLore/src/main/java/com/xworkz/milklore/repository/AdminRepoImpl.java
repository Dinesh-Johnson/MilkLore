package com.xworkz.milklore.repository;

import com.xworkz.milklore.entity.AdminEntity;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
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
    public String getPasswordByEmail(String email) {
        log.info("Admin getPasswordByEmail method in repo");
        EntityManager em=null;
        try {
            em = emf.createEntityManager();
            em.getTransaction().begin();
            String password = em.createNamedQuery("getPasswordByEmail",String.class).setParameter("email",email).getSingleResult();
            System.out.println("Password: "+password);
            em.getTransaction().commit();
        }catch(Exception e) {
            log.error("Exception in Admin getPasswordByEmail method in repo:{}",e.getMessage());
            return null;
        }finally {
            if(em!=null) {
                em.close();
            }
        }
        return email;
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
            System.out.println(adminEntity);
        }catch(Exception e) {
            log.error("Exception in Admin viewAdminByEmail method in repo:{}",e.getMessage());
            return null;
        }finally {
            if(em!=null) {
                em.close();
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



}
