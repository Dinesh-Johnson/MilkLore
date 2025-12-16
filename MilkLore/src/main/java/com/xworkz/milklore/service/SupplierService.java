package com.xworkz.milklore.service;

import com.xworkz.milklore.dto.SupplierBankDetailsDTO;
import com.xworkz.milklore.dto.SupplierDTO;
import com.xworkz.milklore.entity.SupplierEntity;

import javax.servlet.http.HttpServletResponse;
import java.time.LocalDate;
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

    boolean updateSupplierBankDetailsByAdmin(SupplierBankDetailsDTO supplierBankDetailsDTO,String email,String adminEmail);
    SupplierDTO getSupplierDetailsByNotificationId(Long notificationId);
    boolean requestForSupplierBankDetails(String supplierEmail);
    void downloadInvoicePdf(Integer supplierId,Integer paymentId, LocalDate start, LocalDate end, LocalDate paymentDate, HttpServletResponse response);
}
