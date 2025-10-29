package com.xworkz.milklore.service;

import com.xworkz.milklore.dto.PaymentDetailsDTO;
import com.xworkz.milklore.dto.SupplierDTO;
import com.xworkz.milklore.entity.NotificationEntity;

import java.util.List;

public interface NotificationService {
    void generateAdvanceNotifications();
    List<NotificationEntity> getNotificationsByAdminEmail(String email);
    boolean markAsRead(Long notificationId);
    void generatePaymentNotifications();
    Double getAmountById(Long notificationId);
    boolean markAsReadForPayment(Long notificationId,String supplierEmail,String adminEmail);
    Double getTotalAmountPaid(Integer supplierId);
    List<PaymentDetailsDTO> getPaymentDetailsForSupplier(SupplierDTO supplierDTO);
    boolean getPaymentDetailsForAdminEmailSummary();
    List<PaymentDetailsDTO> getAllPaymentDetailsForAdminHistory(int page,int size);
    Integer getTotalCount();

}
