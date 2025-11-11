package com.xworkz.milklore.service;

public interface QrGeneratorService {
    String generateSupplierQR(Integer supplierId, String email, String phoneNumber);
}
