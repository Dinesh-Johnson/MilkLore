package com.xworkz.milklore.service;

import com.xworkz.milklore.configuration.EmailConfiguration;
import com.xworkz.milklore.dto.AdminDTO;
import com.xworkz.milklore.dto.SupplierDTO;
import com.xworkz.milklore.entity.SupplierAuditEntity;
import com.xworkz.milklore.entity.SupplierEntity;
import com.xworkz.milklore.repository.SupplierRepo;
import com.xworkz.milklore.utill.OTPUtill;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Slf4j
@Service
public class SupplierServiceImpl implements SupplierService{

    @Autowired
    private SupplierRepo supplierRepo;

    @Autowired
    private AdminService adminService;

    @Autowired
    private EmailSenderService emailSender;

    @Autowired
    private EmailConfiguration emailConfig;

    private static final int OTP_EXPIRY_MINUTES = 5;

    public SupplierServiceImpl(){
        log.info("SupplierServiceImpl constructor");
    }

    @Override
    public boolean addSupplier(SupplierDTO supplierDTO, String adminEmail) {
        log.info("addSupplier method in SupplierServiceImpl");

        if (adminEmail == null || adminEmail.trim().isEmpty()) {
            log.error("Admin email is null or empty. Cannot add supplier.");
            return false;
        }

        AdminDTO adminDTO = adminService.viewAdminByEmail(adminEmail);
        if (adminDTO == null) {
            log.error("No admin found for email: {}", adminEmail);
            return false;
        }

        SupplierEntity supplierEntity = new SupplierEntity();
        BeanUtils.copyProperties(supplierDTO, supplierEntity);

        SupplierAuditEntity supplierAuditEntity = supplierEntity.getSupplierAuditEntity();
        if (supplierAuditEntity == null) {
            supplierAuditEntity = new SupplierAuditEntity();
            supplierAuditEntity.setName(supplierEntity.getFirstName() + " " + supplierEntity.getLastName());
            supplierAuditEntity.setCreatedBy(adminDTO.getAdminName());
            supplierAuditEntity.setCreatedAt(LocalDateTime.now());
            supplierAuditEntity.setSupplierEntity(supplierEntity);
        }

        supplierEntity.setSupplierAuditEntity(supplierAuditEntity);
        supplierEntity.setIsActive(true);

        if (supplierRepo.addSupplier(supplierEntity)) {
            log.info("supplier details saved");
            if (emailSender.mailForSupplierRegisterSuccess(
                    supplierEntity.getEmail(),
                    supplierEntity.getFirstName() + " " + supplierEntity.getLastName())) {
                log.info("Mail sent to supplier");
                return true;
            } else {
                log.error("Mail not sent");
            }
        } else {
            log.error("Supplier details not saved");
        }

        return false;
    }


    @Override
    public List<SupplierDTO> getAllSuppliers(int pageNumber,int pageSize) {
        log.info("getAllSuppliers method in supplier service");
        List<SupplierEntity> supplierEntities=supplierRepo.getAllSuppliers(pageNumber,pageSize);
        List<SupplierDTO> supplierDTOS=new ArrayList<>();
        supplierEntities.forEach(supplierEntity -> {
            SupplierDTO supplierDTO=new SupplierDTO();
            BeanUtils.copyProperties(supplierEntity,supplierDTO);
            supplierDTOS.add(supplierDTO);
        });
        return supplierDTOS;
    }

    @Override
    public boolean checkEmail(String email) {
        log.info("checkEmail method in Supplier service");
        return supplierRepo.checkEmail(email);
    }

    @Override
    public boolean checkPhonNumber(String phoneNumber) {
        log.info("checkPhonNumber method in Supplier service");
        return supplierRepo.checkPhoneNumber(phoneNumber);
    }

    @Override
    public boolean editSupplierDetails(SupplierDTO supplierDTO, String adminEmail) {
        log.info("editSupplierDetails method in supplier service");
        AdminDTO adminDTO = adminService.viewAdminByEmail(adminEmail);

        SupplierEntity supplierEntity=supplierRepo.getSupplierByEmail(supplierDTO.getEmail());

        SupplierEntity sendEntity=new SupplierEntity();
        BeanUtils.copyProperties(supplierDTO,sendEntity);

        sendEntity.setSupplierAuditEntity(supplierEntity.getSupplierAuditEntity());
        SupplierAuditEntity supplierAuditEntity=sendEntity.getSupplierAuditEntity();
        if(supplierAuditEntity==null){
            log.error("getSupplier not found");
            return false;
        }if (adminDTO==null){
            log.error("Admin DTO is Null");
            return false;
        }
        supplierAuditEntity.setUpdatedBy(adminDTO.getAdminName());
        supplierAuditEntity.setUpdatedAt(LocalDateTime.now());
        sendEntity.setSupplierAuditEntity(supplierAuditEntity);
        return supplierRepo.updateSupplierDetails(sendEntity, false);
    }

    @Override
    public boolean deleteSupplierDetails(String email, String adminEmail) {
        log.info("deleteSupplierDetails method in supplier service");
        SupplierEntity supplierEntity = supplierRepo.getSupplierByEmail(email);
        AdminDTO adminDTO = adminService.viewAdminByEmail(adminEmail);

        SupplierAuditEntity supplierAuditEntity=supplierEntity.getSupplierAuditEntity();
        if(supplierAuditEntity==null){
            log.error("getSupplier not found");
            return false;
        }
        supplierAuditEntity.setDeletedBy(adminDTO.getAdminName());
        supplierAuditEntity.setDeletedAt(LocalDateTime.now());
        supplierEntity.setSupplierAuditEntity(supplierAuditEntity);
        return supplierRepo.updateSupplierDetails(supplierEntity, true);
    }


    @Override
    public List<SupplierDTO> searchSuppliers(String keyword) {
        List<SupplierEntity> supplierEntities=supplierRepo.getSearchSuppliers(keyword);
        List<SupplierDTO> supplierDTOS=new ArrayList<>();
        supplierEntities.forEach(supplierEntity -> {
            SupplierDTO supplierDTO=new SupplierDTO();
            BeanUtils.copyProperties(supplierEntity,supplierDTO);
            supplierDTOS.add(supplierDTO);
        });
        return supplierDTOS;
    }

    @Override
    public SupplierDTO getSupplierDetails(String phone) {
        log.info("getSupplierDetails method in supplier service");
        SupplierEntity supplierEntity=supplierRepo.getSupplierByPhone(phone);
        SupplierDTO supplierDTO=new SupplierDTO();
        BeanUtils.copyProperties(supplierEntity,supplierDTO);
        return supplierDTO;
    }

    @Override
    public boolean generateAndSendOtp(String email) {
        SupplierEntity supplier = supplierRepo.getSupplierByEmail(email);
        if (supplier == null) return false;

        String otp = OTPUtill.generateNumericOtp(6);
        supplier.setOtp(otp);
        supplier.setOtpExpiryTime(LocalDateTime.now().plusMinutes(OTP_EXPIRY_MINUTES));

        boolean updated = supplierRepo.updateSupplierLogin(supplier); // make sure this updates existing entity
        if (updated) {
            return emailSender.supplierMailOtp(email, otp);
        }
        return false;
    }

    @Override
    public boolean verifyOtp(String email, String otp) {
        SupplierEntity supplier = supplierRepo.getSupplierByEmail(email);
        if (supplier == null) return false;

        if (supplier.getOtp() != null &&
                supplier.getOtp().equals(otp) &&
                supplier.getOtpExpiryTime() != null &&
                supplier.getOtpExpiryTime().isAfter(LocalDateTime.now())) {

            // OTP is valid
            supplier.setOtp(null);
            supplier.setOtpExpiryTime(null);
            supplierRepo.updateSupplierLogin(supplier); // update entity
            return true;
        }
        return false; // OTP invalid or expired
    }


}
