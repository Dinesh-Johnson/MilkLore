package com.xworkz.milklore.service;

import com.xworkz.milklore.dto.PaymentDetailsDTO;
import com.xworkz.milklore.entity.PaymentDetailsEntity;
import com.xworkz.milklore.entity.SupplierBankDetailsEntity;
import com.xworkz.milklore.entity.SupplierEntity;

import java.util.List;

public interface EmailSenderService {
    boolean mailSend(String email);
    void mailForSupplierRegisterSuccess(String email,String supplierName,String qrCodePath);
    boolean supplierMailOtp(String email,String otp);
    void mailForSupplierBankDetails(String email, SupplierBankDetailsEntity bankDetails);
    void mailForSupplierPayment(SupplierEntity supplier, PaymentDetailsEntity paymentDetails);
    void mailForBankDetailsRequest(SupplierEntity supplier);
    void mailForAdminPaymentSummary(List<PaymentDetailsDTO> payments);

}
