package com.xworkz.milklore.service;

import com.xworkz.milklore.dto.SupplierDTO;

import java.util.List;

public interface SupplierService {

    boolean addSupplier(SupplierDTO supplierDTO,String adminEmail);

    List<SupplierDTO> getAllSuppliers();

    boolean checkEmail(String email);

    boolean checkPhonNumber(String phoneNumber);

    boolean editSupplierDetails(SupplierDTO supplierDTO,String adminEmail);

    boolean deleteSupplierDetails(String email,String adminEmail);

}
