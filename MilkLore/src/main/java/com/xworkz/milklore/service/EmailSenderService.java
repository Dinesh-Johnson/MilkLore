package com.xworkz.milklore.service;

public interface EmailSenderService {
    boolean mailSend(String email);
    boolean mailForSupplierRegisterSuccess(String email,String supplierName);
}
