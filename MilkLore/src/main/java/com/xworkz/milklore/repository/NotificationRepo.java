package com.xworkz.milklore.repository;

import com.xworkz.milklore.entity.NotificationEntity;
import com.xworkz.milklore.entity.SupplierEntity;

import java.time.LocalDate;
import java.util.List;

public interface NotificationRepo {
    boolean save(NotificationEntity entity);
    boolean existsAdvanceForPaymentDateByAdmin(Integer adminId, LocalDate paymentDate);
    List<NotificationEntity> findByAdminOrderByCreatedAtDesc(Integer adminId);
    boolean markAsRead(Long notificationId);
    SupplierEntity getSupplierEntityByNotificationId(Long id);
    NotificationEntity getNotificationById(Long id);
    boolean markAsReadForPayment(LocalDate paymentDate,Integer supplierId);

}
