package com.xworkz.milklore.service;

import com.xworkz.milklore.dto.PaymentDetailsDTO;
import com.xworkz.milklore.entity.PaymentDetailsEntity;
import com.xworkz.milklore.entity.SupplierBankDetailsEntity;
import com.xworkz.milklore.entity.SupplierEntity;

import java.util.List;

public interface EmailSenderService {
    boolean mailSend(String email);
    boolean mailForSupplierRegisterSuccess(String email,String supplierName,String qrCodePath);
    boolean supplierMailOtp(String email,String otp);
    boolean mailForSupplierBankDetails(String email, SupplierBankDetailsEntity bankDetails);
    boolean mailForSupplierPayment(SupplierEntity supplier, PaymentDetailsEntity paymentDetails);
    boolean mailForBankDetailsRequest(SupplierEntity supplier);
    boolean mailForAdminPaymentSummary(List<PaymentDetailsDTO> payments);

}
