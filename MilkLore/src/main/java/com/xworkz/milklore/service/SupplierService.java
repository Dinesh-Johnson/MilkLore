package com.xworkz.milklore.service;

import com.xworkz.milklore.dto.SupplierBankDetailsDTO;
import com.xworkz.milklore.dto.SupplierDTO;
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

    SupplierDTO getSupplierDetailsByEmail(String email);
    boolean generateAndSendOtp(String email);
    boolean verifyOtp(String email, String otp);

    boolean updateSupplierDetailsBySupplier(SupplierDTO supplierDTO);

    boolean updateSupplierBankDetails(SupplierBankDetailsDTO supplierBankDetailsDTO, String email);
}
