package com.xworkz.milklore.repository;

import com.xworkz.milklore.entity.MilkProductReceiveEntity;

import java.time.LocalDate;
import java.util.List;

public interface MilkProductReceiveRepo {

    boolean save(MilkProductReceiveEntity milkProductReceiveEntity);
    List<MilkProductReceiveEntity> getAllDetailsByDate(LocalDate collectedDate);
    List<MilkProductReceiveEntity> getAllDetailsBySupplierEmail(String email);
    int countSuppliersWithCollections(LocalDate startDate, LocalDate endDate);
    List<Object[]> getEntityForPaymentNotification(LocalDate startDate,LocalDate endDate);
    List<MilkProductReceiveEntity> getCollectMilkDetailsForSupplierById(Integer supplierId,LocalDate start,LocalDate end);
    Integer getCountOFMilkDetailsByEmail(String email);
    LocalDate getLastCollectedDate(Integer supplierId);
    Double getTotalLitre(Integer supplierId);
    List<MilkProductReceiveEntity> getAllEntityForExport();
}
