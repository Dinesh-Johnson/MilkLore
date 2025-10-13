package com.xworkz.milklore.service;

import com.xworkz.milklore.entity.SupplierBankDetailsEntity;

public interface EmailSenderService {
    boolean mailSend(String email);
    boolean mailForSupplierRegisterSuccess(String email,String supplierName);
    boolean supplierMailOtp(String email,String otp);
    boolean mailForSupplierBankDetails(String email, SupplierBankDetailsEntity bankDetails);
}
