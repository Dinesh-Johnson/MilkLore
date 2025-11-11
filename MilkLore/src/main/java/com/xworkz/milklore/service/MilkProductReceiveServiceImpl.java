package com.xworkz.milklore.service;

import com.xworkz.milklore.dto.AdminDTO;
import com.xworkz.milklore.dto.MilkProductReceiveDTO;
import com.xworkz.milklore.dto.SupplierDTO;
import com.xworkz.milklore.entity.*;
import com.xworkz.milklore.repository.MilkProductReceiveRepo;
import com.xworkz.milklore.repository.NotificationRepo;
import com.xworkz.milklore.repository.SupplierRepo;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

@Slf4j
@Service
public class MilkProductReceiveServiceImpl implements MilkProductReceiveService {

    @Autowired
    private MilkProductReceiveRepo collectMilkRepository;

    @Autowired
    private AdminService adminService;

    @Autowired
    private SupplierRepo supplierRepo;

    @Autowired
    private NotificationRepo notificationRepo;

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

    @Override
    public Integer getCountOFMilkDetailsByEmail(String email) {
        log.info("getCountOFMilkDetailsByEmail method in collectMilk service");
        return collectMilkRepository.getCountOFMilkDetailsByEmail(email);
    }

    @Override
    public List<MilkProductReceiveDTO> getAllDetailsBySupplier(Long notificationId) {
        log.info("getAllDetailsBySupplier method in collect milk service");
        NotificationEntity notification=notificationRepo.getNotificationById(notificationId);
        SupplierEntity supplier=notification.getSupplier();

        String message=notification.getMessage();
        Pattern pattern = Pattern.compile("\\((\\d{4}-\\d{2}-\\d{2})\\s+to\\s+(\\d{4}-\\d{2}-\\d{2})\\)");
        Matcher matcher = pattern.matcher(message);
        LocalDate startDate =null;
        LocalDate endDate =null;
        if (matcher.find()) {
            String startDateStr = matcher.group(1);
            String endDateStr = matcher.group(2);

            startDate = LocalDate.parse(startDateStr);
            endDate = LocalDate.parse(endDateStr);
        }
        List<MilkProductReceiveEntity> list=collectMilkRepository.getCollectMilkDetailsForSupplierById(supplier.getSupplierId(),startDate,endDate);
        List<MilkProductReceiveDTO> collectMilkDTOS=new ArrayList<>();
        list.forEach(e->{
            MilkProductReceiveDTO collectMilkDTO=new MilkProductReceiveDTO();
            BeanUtils.copyProperties(e,collectMilkDTO);
            collectMilkDTOS.add(collectMilkDTO);
        });
        return collectMilkDTOS;
    }

    @Override
    public LocalDate getLastCollectedDate(Integer supplierId) {
        log.info("getLastCollectedDate method in collect milk service");
        return collectMilkRepository.getLastCollectedDate(supplierId);
    }

    @Override
    public Double getTotalLitre(Integer supplierId) {
        log.info("getTotalLitre method in collect milk service");
        return collectMilkRepository.getTotalLitre(supplierId);
    }


    @Override
    public void exportAllMilkCollectData(HttpServletResponse response) {
        log.info("exportAllMilkCollectData method in collect milk service");
        List<MilkProductReceiveEntity> collectMilk = collectMilkRepository.getAllEntityForExport();
        try {
            response.setContentType("text/csv");
            response.setHeader("Content-Disposition", "attachment; filename=collect_milk_data.csv");

            PrintWriter writer = response.getWriter();
            writer.println("CollectMilkId,SupplierName,CollectedBy,TypeOfMilk,Price,Quantity,TotalAmount,CollectedDate");

            for (MilkProductReceiveEntity milk : collectMilk) {
                writer.println(
                        milk.getMilkProductReceiveId() + "," +
                                milk.getSupplier().getFirstName() + " " + milk.getSupplier().getLastName() + "," +
                                milk.getAdmin().getAdminName() + "," +
                                milk.getTypeOfMilk() + "," +
                                milk.getPrice() + "," +
                                milk.getQuantity() + "," +
                                milk.getTotalAmount() + "," +
                                milk.getCollectedDate()
                );
            }

            writer.flush();
            writer.close();
            log.info("Export collect milk data list in csv is done");
        } catch (IOException e) {
            log.error(e.getMessage());
        }
    }
}
