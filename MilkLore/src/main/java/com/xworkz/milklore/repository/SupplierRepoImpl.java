package com.xworkz.milklore.repository;

import com.xworkz.milklore.entity.SupplierEntity;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import javax.persistence.*;
import java.util.List;

@Slf4j
@Repository
public class SupplierRepoImpl implements SupplierRepo {

    @Autowired
    EntityManagerFactory emf;


    @Override
    public boolean addSupplier(SupplierEntity supplierEntity) {
        log.info("Supplier addSupplier method in repo");
        EntityManager em = null;
        try {
            em = emf.createEntityManager();
            em.getTransaction().begin();
            em.persist(supplierEntity);
            em.getTransaction().commit();
            return true;
        } catch (PersistenceException e) {
            log.error("Exception in Supplier addSupplier method in repo:{}", e.getMessage());
            if (em.getTransaction() != null) {
                em.getTransaction().rollback();
                log.info("Transaction rolled back");
            }
        } finally {
            if (em != null) {
                em.close();
            }
        }
        return false;
    }

    @Override
    public List<SupplierEntity> getAllSuppliers(int pageNumber, int pageSize) {
        log.info("Supplier getAllSuppliers method in repo");
        EntityManager em = null;
        List<SupplierEntity> list = null;
        try {
            em = emf.createEntityManager();
            list = em.createNamedQuery("getAllSuppliers")
                    .setFirstResult((pageNumber - 1) * pageSize).setMaxResults(pageSize).getResultList();
        } catch (PersistenceException e) {
            log.error("Exception in Supplier getAllSuppliers method in repo:{}", e.getMessage());
        } finally {
            if (em != null) {
                em.close();
            }
        }
        return list;
    }

    @Override
    public boolean checkEmail(String email) {
        log.info("Supplier checkEmail method in repo");
        EntityManager em = null;
        try {
            em = emf.createEntityManager();
            SupplierEntity supplierEntity = em.createNamedQuery("checkEmail", SupplierEntity.class).setParameter("email", email).getSingleResult();
            if (supplierEntity == null)
                return false;
            return true;
        } catch (PersistenceException e) {
            log.error("Exception in Supplier checkEmail method in repo:{}", e.getMessage());
            return false;
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    @Override
    public boolean checkPhoneNumber(String phoneNumber) {
        log.info("Supplier checkPhoneNumber method in repo");
        EntityManager em = null;
        try {
            em = emf.createEntityManager();
            SupplierEntity supplierEntity = em.createNamedQuery("checkPhoneNumber", SupplierEntity.class).setParameter("phoneNumber", phoneNumber).getSingleResult();
            if (supplierEntity == null)
                return false;
            return true;
        } catch (PersistenceException e) {
            log.error("Exception in Supplier checkPhoneNumber method in repo:{}", e.getMessage());
            return false;
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    @Override
    public boolean updateSupplierDetails(SupplierEntity supplierEntity, Boolean isDelete) {
        log.info("Supplier updateSupplierDetails method in repo");
        EntityManager em = null;
        try {
            em = emf.createEntityManager();
            em.getTransaction().begin();
            SupplierEntity preEntity = em.createNamedQuery("checkEmail", SupplierEntity.class)
                    .setParameter("email", supplierEntity.getEmail()).getSingleResult();
            if (preEntity == null) {
                log.info("Supplier updateSupplierDetails method in repo: Supplier not found");
                return false;
            }
            if (isDelete) {
                log.info("Supplier updateSupplierDetails method in repo: Supplier deleted");
                preEntity.setIsActive(false);
                preEntity.setSupplierAuditEntity(supplierEntity.getSupplierAuditEntity());
            } else {
                log.info("Supplier updateSupplierDetails method in repo: Supplier updated");
                preEntity.setFirstName(supplierEntity.getFirstName());
                preEntity.setLastName(supplierEntity.getLastName());
                preEntity.setAddress(supplierEntity.getAddress());
                preEntity.setIsActive(true);
                preEntity.setSupplierAuditEntity(supplierEntity.getSupplierAuditEntity());
            }
            em.merge(preEntity);
            em.getTransaction().commit();
            log.info("Supplier updateSupplierDetails method in repo: Supplier updated");
            return true;
        } catch (PersistenceException e) {
            log.error("Exception in Supplier updateSupplierDetails method in repo:{}", e.getMessage());
            if (em.getTransaction() != null) {
                em.getTransaction().rollback();
                log.info("Transaction rolled back");
            }
        } finally {
            if (em != null) {
                em.close();
                log.info("EntityManager closed");
            }
        }
        return false;
    }

    @Override
    public boolean updateSupplierLogin(SupplierEntity supplierEntity) {
        log.info("updateSupplier method in repo");
        EntityManager em = null;
        try {
            em = emf.createEntityManager();
            em.getTransaction().begin();
            em.merge(supplierEntity); // merge instead of persist
            em.getTransaction().commit();
            return true;
        } catch (PersistenceException e) {
            log.error("Exception in updateSupplier: {}", e.getMessage());
            if (em != null && em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            return false;
        } finally {
            if (em != null && em.isOpen()) {
                em.close();
            }
        }
    }

    @Override
    public SupplierEntity getSupplierByEmail(String email) {
        log.info("getSupplierByEmail method in SupplierRepository");
        EntityManager entityManager = null;
        SupplierEntity supplierEntity = null;
        try {
            entityManager = emf.createEntityManager();
            supplierEntity = (SupplierEntity) entityManager.createNamedQuery("checkEmail").setParameter("email", email).getSingleResult();
        } catch (PersistenceException e) {
            log.error(e.getMessage());
        } finally {
            if (entityManager != null && entityManager.isOpen()) {
                entityManager.close();
                log.info("EntityManager is closed");
            }
        }
        return supplierEntity;
    }

    @Override
    public Integer getSuppliersCount() {
        log.info("getSuppliersCount method in supplier repository");
        EntityManager entityManager = null;
        int count = 0;
        try {
            entityManager = emf.createEntityManager();
            Long count1 = (Long) entityManager.createNamedQuery("getSuppliersCount").getSingleResult();
            count = count1.intValue();
        } catch (PersistenceException e) {
            log.error(e.getMessage());
        } finally {
            if (entityManager != null && entityManager.isOpen()) {
                entityManager.close();
                log.info("EntityManager is closed");
            }
        }
        return count;
    }

    @Override
    public List<SupplierEntity> getSearchSuppliers(String searchTerm) {
        log.info("getSearchSuppliers method in supplier repository");
        EntityManager entityManager = null;
        List<SupplierEntity> list = null;
        try {
            entityManager = emf.createEntityManager();
            list = entityManager.createNamedQuery("searchSupplierEmailNameMobile").setParameter("searchTerm", searchTerm).getResultList();
        } catch (PersistenceException e) {
            log.error(e.getMessage());
        } finally {
            if (entityManager != null && entityManager.isOpen()) {
                entityManager.close();
                log.info("EntityManager is closed");
            }
        }
        return list;
    }

    @Override
    public SupplierEntity getSupplierByPhone(String phone) {
        log.info("getSupplierByPhone method in SupplierRepository");
        EntityManager entityManager = null;
        SupplierEntity supplierEntity = null;
        try {
            entityManager = emf.createEntityManager();
            supplierEntity = (SupplierEntity) entityManager.createNamedQuery("checkPhoneNumber").setParameter("phoneNumber", phone).getSingleResult();
            return supplierEntity;
        } catch (PersistenceException e) {
            log.error(e.getMessage());
        } finally {
            if (entityManager != null && entityManager.isOpen()) {
                entityManager.close();
                log.info("EntityManager is closed");
            }
        }
        return supplierEntity;
    }

    @Override
    public boolean loginWithOtp(String email, String otp) {
        log.info("loginWithOtp() in SupplierRepoImpl");
        EntityManager em = null;

        try {
            em = emf.createEntityManager();
            em.getTransaction().begin();

            SupplierEntity supplierEntity = (SupplierEntity) em
                    .createNamedQuery("checkEmail")
                    .setParameter("email", email)
                    .getSingleResult();

            if (supplierEntity != null) {
                // check if otp matches and not expired
                if (supplierEntity.getOtp() != null
                        && supplierEntity.getOtp().equals(otp)
                        && supplierEntity.getOtpExpiryTime() != null
                        && supplierEntity.getOtpExpiryTime().isAfter(java.time.LocalDateTime.now())) {

                    log.info("✅ OTP verified successfully for email: {}", email);
                    supplierEntity.setOtpVerified(true);
                    supplierEntity.setOtp(null); // clear OTP
                    supplierEntity.setOtpExpiryTime(null);

                    em.merge(supplierEntity);
                    em.getTransaction().commit();
                    return true;
                } else {
                    log.warn("❌ Invalid or expired OTP for email: {}", email);
                    return false;
                }
            }
        } catch (PersistenceException e) {
            log.error("Exception in loginWithOtp: {}", e.getMessage());
            if (em != null && em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
        } finally {
            if (em != null && em.isOpen()) {
                em.close();
            }
        }
        return false;
    }

    @Override
    public boolean updateSupplierDetailsBySupplier(SupplierEntity supplierEntity) {
        log.info("updateSupplierDetailsBySupplier bySupplier method in supplier repository");
        EntityManager entityManager=null;
        EntityTransaction entityTransaction=null;

        try {
            entityManager=emf.createEntityManager();
            entityTransaction=entityManager.getTransaction();
            entityTransaction.begin();
            entityManager.merge(supplierEntity);
            entityTransaction.commit();
            return true;
        }catch (PersistenceException e)
        {
            log.error(e.getMessage());
            if(entityTransaction!=null)
            {
                entityTransaction.rollback();
                log.error("merge roll back");
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
    public List<SupplierEntity> getAllActiveSupplierEntities() {
        log.info("getAllActiveSupplierEntities method in supplier repository");
        EntityManager entityManager = null;
        List<SupplierEntity> list = null;
        try {
            entityManager = emf.createEntityManager();
            list = entityManager.createNamedQuery("getAllActiveSupplierEntities").getResultList();
        } catch (PersistenceException e) {
            log.error(e.getMessage());
        } finally {
            if (entityManager != null && entityManager.isOpen()) {
                entityManager.close();
                log.info("EntityManager is closed");
            }
        }
        return list;
    }
}
