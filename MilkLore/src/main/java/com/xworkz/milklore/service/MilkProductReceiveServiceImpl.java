package com.xworkz.milklore.service;

import com.xworkz.milklore.dto.AdminDTO;
import com.xworkz.milklore.dto.MilkProductReceiveDTO;
import com.xworkz.milklore.dto.SupplierDTO;
import com.xworkz.milklore.entity.AdminEntity;
import com.xworkz.milklore.entity.MilkProductReceiveAuditEntity;
import com.xworkz.milklore.entity.MilkProductReceiveEntity;
import com.xworkz.milklore.repository.MilkProductReceiveRepo;
import com.xworkz.milklore.repository.SupplierRepo;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Slf4j
@Service
public class MilkProductReceiveServiceImpl implements MilkProductReceiveService {

    @Autowired
    private MilkProductReceiveRepo collectMilkRepository;

    @Autowired
    private AdminService adminService;

    @Autowired
    private SupplierRepo supplierRepo;

    public MilkProductReceiveServiceImpl() {
        log.info("CollectMilkServiceImpl constructor");
    }

    @Override
    public boolean save(MilkProductReceiveDTO milkProductReceiveDTO, String email) {
        log.info("save method in CollectMilkServiceImpl");
        AdminDTO adminDTO = adminService.viewAdminByEmail(email);

        log.info(">>> Inside MilkProductReceiveService.save() with: " + adminDTO);

        AdminEntity adminEntity = new AdminEntity();
        BeanUtils.copyProperties(adminDTO, adminEntity);
        System.out.println(adminEntity);

        MilkProductReceiveEntity collectMilkEntity = new MilkProductReceiveEntity();
        BeanUtils.copyProperties(milkProductReceiveDTO, collectMilkEntity);
        MilkProductReceiveAuditEntity milkProductReceiveAuditEntity = new MilkProductReceiveAuditEntity();
        milkProductReceiveAuditEntity.setCreatedAt(LocalDateTime.now());
        milkProductReceiveAuditEntity.setCreatedBy(adminDTO.getAdminName());
        milkProductReceiveAuditEntity.setMilkProductReceiveEntity(collectMilkEntity);

        collectMilkEntity.setMilkProductReceiveAuditEntity(milkProductReceiveAuditEntity);

        collectMilkEntity.setAdmin(adminEntity);
        collectMilkEntity.setSupplier(supplierRepo.getSupplierByPhone(milkProductReceiveDTO.getPhoneNumber()));
        return collectMilkRepository.save(collectMilkEntity);
    }

    @Override
    public List<MilkProductReceiveDTO> getAllDetailsByDate(LocalDate collectedDate) {
        log.info("getAllDetailsByDate method in CollectMilkServiceImpl");
        List<MilkProductReceiveEntity> collectMilkEntities = collectMilkRepository.getAllDetailsByDate(collectedDate);
        List<MilkProductReceiveDTO> collectMilkDTOS = new ArrayList<>();
        collectMilkEntities.forEach(collectMilkEntity -> {
            MilkProductReceiveDTO collectMilkDTO = new MilkProductReceiveDTO();
            BeanUtils.copyProperties(collectMilkEntity, collectMilkDTO);
            if (collectMilkEntity.getSupplier()!=null){
                SupplierDTO supplierDTO = new SupplierDTO();
                BeanUtils.copyProperties(collectMilkEntity.getSupplier(), supplierDTO);
                collectMilkDTO.setSupplier(supplierDTO);
            }
            collectMilkDTOS.add(collectMilkDTO);
        });
        return collectMilkDTOS;
    }
    @Override
    public List<MilkProductReceiveDTO> getAllDetailsBySupplierEmail(String email) {
        log.info("getAllDetailsBySupplierEmail method in CollectMilkServiceImpl");
        List<MilkProductReceiveEntity> collectMilkEntities = collectMilkRepository.getAllDetailsBySupplierEmail(email);

        List<MilkProductReceiveDTO> collectMilkDTOS = new ArrayList<>();
        for (MilkProductReceiveEntity entity : collectMilkEntities) {
            MilkProductReceiveDTO dto = new MilkProductReceiveDTO();
            BeanUtils.copyProperties(entity, dto);

            if (entity.getSupplier() != null) {
                SupplierDTO supplierDTO = new SupplierDTO();
                BeanUtils.copyProperties(entity.getSupplier(), supplierDTO);
                dto.setSupplier(supplierDTO);
            }

            collectMilkDTOS.add(dto);
        }
        return collectMilkDTOS;
    }

}
