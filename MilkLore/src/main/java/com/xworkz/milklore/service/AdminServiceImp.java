package com.xworkz.milklore.service;

import com.xworkz.milklore.dto.AdminDTO;
import com.xworkz.milklore.entity.AdminEntity;
import com.xworkz.milklore.entity.AdminAuditEntity;
import com.xworkz.milklore.repository.AdminAuditRepo;
import com.xworkz.milklore.repository.AdminRepo;
import com.xworkz.milklore.repository.SupplierRepo;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.Map;

@Service
@Slf4j
public class AdminServiceImp implements AdminService{

    @Autowired
    private AdminRepo repo;

    @Autowired
    private BCryptPasswordEncoder encoder;

    @Autowired
    private EmailSenderService emailService;

    @Autowired
    private AdminAuditRepo auditRepo;

    @Autowired
    private SupplierRepo supplierRepo;

    private final Map<String,Integer> attempts = new HashMap<>();

    @Override
    public boolean save(AdminDTO dto) {
        log.info("Admin save method in service");
        AdminEntity entity=new AdminEntity();
        BeanUtils.copyProperties(dto,entity);
        entity.setPassword(encoder.encode(entity.getPassword()));
        entity.setBlockedStatus(false);
        return repo.save(entity);
    }

    @Override
    public AdminDTO getPasswordByEmail(String email,String password) {
        System.out.println("Admin getPasswordByEmail method in service");
        AdminEntity entity = repo.viewAdminByEmail(email);
        System.out.println(entity);
        if (entity == null)
            return null;
        if (entity.getBlockedStatus()) {
            log.info("Blocked Status: " + entity.getBlockedStatus());
            throw new RuntimeException("Account is blocked have to reset password. Click forgot Password");
        }
        if (encoder.matches(password, entity.getPassword())) {
            attempts.remove(email);
            AdminAuditEntity audit = entity.getAudit();
            if (audit == null) {
                audit = new AdminAuditEntity();
                audit.setAdminEntity(entity);
            }
            audit.setLoggedInTime(LocalDateTime.now());
            audit.setAuditName(entity.getAdminName());
            if(auditRepo.save(audit))
                log.info("Admin audit details updated/created");
            else log.error("Admin audit details not updated/created");
            System.out.println("PASSWORD MATACHED");
            AdminDTO adminDTO = new AdminDTO();
            BeanUtils.copyProperties(entity, adminDTO);
            log.info("AdminDTO: " + adminDTO);

            return adminDTO;
        }else {
            System.out.println("PASSWORD NOT MATACHED");
            int count = attempts.getOrDefault(email, 0)+1;
            attempts.put(email,count);
            if (count >= 3) {
                if(repo.loginAttemptBlockedEmail(email,true)){
                    log.info("Blocked Status is True");

                }
                throw new RuntimeException("Account is blocked have to reset password. Click forgot Password");
            }else {
                log.warn("Attempts is not reached {} its limit {}",email,count);
                throw new RuntimeException("Password mismatch for "+email+" Attempt "+attempts+"/3");
            }
        }
    }

    @Override
    public AdminDTO viewAdminByEmail(String email) {
        System.out.println("View By email Service");
        AdminEntity entity = repo.viewAdminByEmail(email);

        if (entity == null) {
            System.out.println("No AdminEntity found for email: " + email);
            return null; // or throw a custom exception
        }

        AdminDTO dto = new AdminDTO();
        BeanUtils.copyProperties(entity, dto);
        return dto;
    }

    @Override
    public boolean updateAdminDetails(String email, String adminName, String mobileNumber,String profilePath) {
        log.info("Admin updateAdminDetails method in service");
        System.out.println(email+"-"+adminName+"-"+mobileNumber+"-"+profilePath);
        return repo.updateAdminDetails(email, adminName, mobileNumber,profilePath);
    }

    @Override
    public boolean checkEmailByEmail(String email) {
        log.info("Admin checkEmailByEmail method in service");
        AdminEntity entity = repo.viewAdminByEmail(email);
        return entity!=null;
    }

    @Override
    public boolean sendMailToSetPassword(String email) {
        log.info("Admin sendMailToSetPassword method in service");
        return emailService.mailSend(email);
    }

    @Override
    public boolean setPasswordByEmail(String email, String password, String confirmPassword) {
        if (!password.equals(confirmPassword)) {
            return false;
        }

        String pattern = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&]).{5,}$";
        if (!password.matches(pattern)) {
            return false;
        }

        String encodedPassword = encoder.encode(password);
        return repo.setPasswordByEmail(email, encodedPassword, confirmPassword);
    }

    @Override
    public int getSupplierCount() {
        log.info("getSupplierCount method in service");
        return supplierRepo.getSuppliersCount();
    }

}
