package com.xworkz.milklore.service;

import com.xworkz.milklore.dto.SupplierDTO;
import com.xworkz.milklore.entity.SupplierEntity;

import java.util.List;

public interface SupplierService {

    boolean addSupplier(SupplierDTO supplierDTO,String adminEmail);

    List<SupplierDTO> getAllSuppliers(int pageNumber,int pageSize);

    boolean checkEmail(String email);

    boolean checkPhonNumber(String phoneNumber);

    boolean editSupplierDetails(SupplierDTO supplierDTO,String adminEmail);

    boolean deleteSupplierDetails(String email,String adminEmail);

    List<SupplierDTO> searchSuppliers(String keyword);

    SupplierDTO getSupplierDetails(String phone);

}
