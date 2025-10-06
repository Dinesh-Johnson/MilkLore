package com.xworkz.milklore.service;

import com.xworkz.milklore.dto.AdminDTO;
import com.xworkz.milklore.dto.MilkProductReceiveDTO;
import com.xworkz.milklore.entity.AdminEntity;
import com.xworkz.milklore.entity.MilkProductReceiveAuditEntity;
import com.xworkz.milklore.entity.MilkProductReceiveEntity;
import com.xworkz.milklore.repository.MilkProductReceiveRepo;
import com.xworkz.milklore.repository.SupplierRepo;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;

import java.time.LocalDateTime;

@Slf4j
public class MilkProductReceiveServiceImpl implements MilkProductReceiveService{

    @Autowired
    private MilkProductReceiveRepo collectMilkRepository;

    @Autowired
    private AdminService adminService;

    @Autowired
    private SupplierRepo supplierRepo;

    public MilkProductReceiveServiceImpl()
    {
        log.info("CollectMilkServiceImpl constructor");
    }

    @Override
    public boolean save(MilkProductReceiveDTO milkProductReceiveDTO, String email) {
        log.info("save method in CollectMilkServiceImpl");
        AdminDTO adminDTO=adminService.viewAdminByEmail(email);

        AdminEntity adminEntity=new AdminEntity();
        BeanUtils.copyProperties(adminDTO,adminEntity);

        MilkProductReceiveEntity collectMilkEntity=new MilkProductReceiveEntity();
        BeanUtils.copyProperties(milkProductReceiveDTO,collectMilkEntity);
        MilkProductReceiveAuditEntity milkProductReceiveAuditEntity=new MilkProductReceiveAuditEntity();
        milkProductReceiveAuditEntity.setCreatedAt(LocalDateTime.now());
        milkProductReceiveAuditEntity.setCreatedBy(adminDTO.getAdminName());
        milkProductReceiveAuditEntity.setMilkProductReceiveEntity(collectMilkEntity);

        collectMilkEntity.setMilkProductReceiveAuditEntity(milkProductReceiveAuditEntity);

        collectMilkEntity.setAdmin(adminEntity);
        collectMilkEntity.setSupplier(supplierRepo.getSupplierByPhone(milkProductReceiveDTO.getPhoneNumber()));
        return collectMilkRepository.save(collectMilkEntity);
    }

}
