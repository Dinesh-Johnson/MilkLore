package com.xworkz.milklore.service;

import com.xworkz.milklore.configuration.EmailConfiguration;
import com.xworkz.milklore.dto.AdminDTO;
import com.xworkz.milklore.dto.SupplierBankDetailsDTO;
import com.xworkz.milklore.dto.SupplierDTO;
import com.xworkz.milklore.entity.SupplierAuditEntity;
import com.xworkz.milklore.entity.SupplierBankDetailsAuditEntity;
import com.xworkz.milklore.entity.SupplierBankDetailsEntity;
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
            if(supplierEntity.getSupplierBankDetails()!=null)
            {
                SupplierBankDetailsDTO supplierBankDetailsDTO=new SupplierBankDetailsDTO();
                BeanUtils.copyProperties(supplierEntity.getSupplierBankDetails(),supplierBankDetailsDTO);
                supplierDTO.setSupplierBankDetails(supplierBankDetailsDTO);
                System.out.println(supplierBankDetailsDTO);
            }
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
    public SupplierDTO getSupplierDetailsByEmail(String email) {
        log.info("Fetching supplier details by email: {}", email);

        SupplierEntity entity = supplierRepo.getSupplierByEmail(email);

        if (entity == null) {
            log.warn("No supplier found with email: {}", email);
            return null;
        }

        SupplierDTO dto = new SupplierDTO();
        BeanUtils.copyProperties(entity, dto);
        if(entity.getSupplierBankDetails()!=null)
        {
            SupplierBankDetailsDTO supplierBankDetailsDTO=new SupplierBankDetailsDTO();
            BeanUtils.copyProperties(entity.getSupplierBankDetails(),supplierBankDetailsDTO);
            dto.setSupplierBankDetails(supplierBankDetailsDTO);
        }

        log.info("Supplier details copied to DTO successfully");
        return dto;
    }


    @Override
    public boolean generateAndSendOtp(String email) {
        if (email == null || email.trim().isEmpty()) {
            log.warn("generateAndSendOtp: empty email");
            return false;
        }

        email = email.trim();
        SupplierEntity supplier = supplierRepo.getSupplierByEmail(email);
        if (supplier == null) {
            log.warn("generateAndSendOtp: supplier not found for email {}", email);
            return false;
        }

        // Generate 6-digit numeric OTP
        String otp = OTPUtill.generateNumericOtp(6);
        supplier.setOtp(otp);
        supplier.setOtpExpiryTime(LocalDateTime.now().plusMinutes(OTP_EXPIRY_MINUTES));

        // Persist changes
        boolean updated = supplierRepo.updateSupplierLogin(supplier); // should update existing entity
        if (!updated) {
            log.error("generateAndSendOtp: failed to update supplier OTP for email {}", email);
            return false;
        }

        // Send OTP email
        boolean emailSent = emailSender.supplierMailOtp(email, otp);
        if (!emailSent) {
            log.error("generateAndSendOtp: failed to send OTP email to {}", email);
            return false;
        }

        log.info("generateAndSendOtp: OTP {} sent successfully to {}", otp, email);
        return true;
    }

    @Override
    public boolean verifyOtp(String email, String otp) {
        if (email == null || email.trim().isEmpty() || otp == null || otp.trim().isEmpty()) {
            log.warn("verifyOtp: email or OTP is empty");
            return false;
        }

        email = email.trim();
        otp = otp.trim();
        SupplierEntity supplier = supplierRepo.getSupplierByEmail(email);
        if (supplier == null) {
            log.warn("verifyOtp: supplier not found for email {}", email);
            return false;
        }

        LocalDateTime now = LocalDateTime.now();
        if (supplier.getOtp() != null &&
                supplier.getOtp().equals(otp) &&
                supplier.getOtpExpiryTime() != null &&
                supplier.getOtpExpiryTime().isAfter(now)) {

            // OTP is valid -> clear it
            supplier.setOtp(null);
            supplier.setOtpExpiryTime(null);
            boolean updated = supplierRepo.updateSupplierLogin(supplier);
            if (!updated) {
                log.error("verifyOtp: failed to clear OTP for email {}", email);
                return false;
            }

            log.info("verifyOtp: OTP verified successfully for {}", email);
            return true;
        }

        log.warn("verifyOtp: invalid or expired OTP for {}", email);
        return false;
    }

    @Override
    public boolean updateSupplierDetailsBySupplier(SupplierDTO supplierDTO) {
        log.info("updateSupplierDetailsBySupplier method in supplier service");
        SupplierEntity existingEntity=supplierRepo.getSupplierByEmail(supplierDTO.getEmail());
        SupplierAuditEntity supplierAuditEntity;
        if(existingEntity==null)
        {
            log.error("Entity not found for update");
            return false;
        }
        supplierAuditEntity=existingEntity.getSupplierAuditEntity();
        if(supplierAuditEntity==null)
        {
            log.error("log not found");
            return false;
        }
        existingEntity.setFirstName(supplierDTO.getFirstName());
        existingEntity.setLastName(supplierDTO.getLastName());
        existingEntity.setAddress(supplierDTO.getAddress());
        if(supplierDTO.getProfilePath()!=null)
        {
            existingEntity.setProfilePath(supplierDTO.getProfilePath());
        }
        supplierAuditEntity.setUpdatedAt(LocalDateTime.now());
        supplierAuditEntity.setUpdatedBy(supplierDTO.getFirstName()+" "+supplierDTO.getLastName());
        existingEntity.setSupplierAuditEntity(supplierAuditEntity);
        supplierAuditEntity.setSupplierEntity(existingEntity);

        return supplierRepo.updateSupplierDetailsBySupplier(existingEntity);
    }

    @Override
    public boolean updateSupplierBankDetails(SupplierBankDetailsDTO supplierBankDetailsDTO, String email) {
        log.info("Entered updateSupplierBankDetails() in SupplierService with email: {}", email);
        log.info("Incoming SupplierBankDetailsDTO: {}", supplierBankDetailsDTO);

        SupplierEntity supplierEntity = supplierRepo.getSupplierByEmail(email);
        if (supplierEntity == null) {
            log.error("No SupplierEntity found for email: {}", email);
            return false;
        }

        log.info("Fetched SupplierEntity for email: {}", supplierEntity.getEmail());

        if (supplierEntity.getSupplierAuditEntity() == null) {
            log.error("SupplierAuditEntity is null for supplier with email: {}", email);
            return false;
        }

        SupplierAuditEntity supplierAuditEntity = supplierEntity.getSupplierAuditEntity();
        supplierAuditEntity.setUpdatedBy(supplierEntity.getFirstName() + " " + supplierEntity.getLastName());
        supplierAuditEntity.setUpdatedAt(LocalDateTime.now());
        log.info("Updated SupplierAuditEntity with updatedBy: {} and updatedAt: {}",
                supplierAuditEntity.getUpdatedBy(), supplierAuditEntity.getUpdatedAt());

        supplierEntity.setSupplierAuditEntity(supplierAuditEntity);
        supplierAuditEntity.setSupplierEntity(supplierEntity);

        SupplierBankDetailsEntity supplierBankDetailsEntity = supplierEntity.getSupplierBankDetails();
        SupplierBankDetailsAuditEntity supplierBankDetailsAuditEntity;

        if (supplierBankDetailsEntity == null) {
            log.info("No existing SupplierBankDetailsEntity found — creating new entity");
            supplierBankDetailsEntity = new SupplierBankDetailsEntity();
            BeanUtils.copyProperties(supplierBankDetailsDTO, supplierBankDetailsEntity);

            supplierBankDetailsAuditEntity = new SupplierBankDetailsAuditEntity();
            supplierBankDetailsAuditEntity.setCreatedAt(LocalDateTime.now());
            supplierBankDetailsAuditEntity.setCreatedBy(supplierEntity.getFirstName() + " " + supplierEntity.getLastName());
            log.info("Created new SupplierBankDetailsAuditEntity with createdBy: {} and createdAt: {}",
                    supplierBankDetailsAuditEntity.getCreatedBy(), supplierBankDetailsAuditEntity.getCreatedAt());
        } else {
            log.info("Existing SupplierBankDetailsEntity found — updating existing entity");
            BeanUtils.copyProperties(supplierBankDetailsDTO, supplierBankDetailsEntity);
            supplierBankDetailsAuditEntity = supplierBankDetailsEntity.getSupplierBankDetailsAuditEntity();
            log.info("Fetched existing SupplierBankDetailsAuditEntity for update");
        }

        supplierBankDetailsAuditEntity.setUpdatedBy(supplierEntity.getFirstName() + " " + supplierEntity.getLastName());
        supplierBankDetailsAuditEntity.setUpdatedAt(LocalDateTime.now());
        log.info("Set updatedBy: {} and updatedAt: {} in SupplierBankDetailsAuditEntity",
                supplierBankDetailsAuditEntity.getUpdatedBy(), supplierBankDetailsAuditEntity.getUpdatedAt());

        supplierEntity.setSupplierBankDetails(supplierBankDetailsEntity);
        supplierBankDetailsEntity.setSupplierEntity(supplierEntity);
        supplierBankDetailsEntity.setSupplierBankDetailsAuditEntity(supplierBankDetailsAuditEntity);
        supplierBankDetailsAuditEntity.setSupplierBankDetailsEntity(supplierBankDetailsEntity);

        boolean isUpdated = supplierRepo.updateSupplierDetailsBySupplier(supplierEntity);
        log.info("Supplier bank details update status for email {}: {}", email, isUpdated);

        log.info("Exiting updateSupplierBankDetails() in SupplierService");
        if(isUpdated)
        {
            return emailSender.mailForSupplierBankDetails(supplierEntity.getEmail(), supplierBankDetailsEntity);
        }
        return false;
    }

    @Override
    public boolean updateSupplierBankDetailsByAdmin(SupplierBankDetailsDTO supplierBankDetailsDTO, String email,String adminEmail) {
        log.info("updateSupplierBankDetailsByAdmin method in supplier service");
        SupplierEntity supplierEntity=supplierRepo.getSupplierByEmail(email);
        AdminDTO adminDTO=adminService.viewAdminByEmail(adminEmail);
        if(supplierEntity.getSupplierAuditEntity()==null)
        {
            log.error("Entity not found for supplier");
            return false;
        }
        SupplierAuditEntity supplierAuditEntity=supplierEntity.getSupplierAuditEntity();
        supplierAuditEntity.setUpdatedBy(adminDTO.getAdminName());
        supplierAuditEntity.setUpdatedAt(LocalDateTime.now());

        supplierEntity.setSupplierAuditEntity(supplierAuditEntity);
        supplierAuditEntity.setSupplierEntity(supplierEntity);

        SupplierBankDetailsEntity supplierBankDetailsEntity = supplierEntity.getSupplierBankDetails();
        SupplierBankDetailsAuditEntity supplierBankDetailsAuditEntity;

        BeanUtils.copyProperties(supplierBankDetailsDTO, supplierBankDetailsEntity);
        supplierBankDetailsAuditEntity = supplierBankDetailsEntity.getSupplierBankDetailsAuditEntity();

        supplierBankDetailsAuditEntity.setUpdatedBy(adminDTO.getAdminName());
        supplierBankDetailsAuditEntity.setUpdatedAt(LocalDateTime.now());

        supplierEntity.setSupplierBankDetails(supplierBankDetailsEntity);
        supplierBankDetailsEntity.setSupplierEntity(supplierEntity);
        supplierBankDetailsEntity.setSupplierBankDetailsAuditEntity(supplierBankDetailsAuditEntity);
        supplierBankDetailsAuditEntity.setSupplierBankDetailsEntity(supplierBankDetailsEntity);

        if(supplierRepo.updateSupplierDetailsBySupplier(supplierEntity))
        {
            return emailSender.mailForSupplierBankDetails(supplierEntity.getEmail(), supplierBankDetailsEntity);
        }
        return false;
    }


}
