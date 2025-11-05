package com.xworkz.milklore.repository;

import com.xworkz.milklore.entity.SupplierEntity;

import java.util.List;

public interface SupplierRepo {

    boolean addSupplier(SupplierEntity supplierEntity);

    List<SupplierEntity> getAllSuppliers(int pageNumber,int pageSize);

    boolean checkEmail(String email);

    boolean checkPhoneNumber(String phoneNumber);

    boolean updateSupplierDetails(SupplierEntity supplierEntity,Boolean isDelete);
    boolean updateSupplierLogin(SupplierEntity supplierEntity);

    Integer getSuppliersCount();

    SupplierEntity getSupplierByEmail(String email);

    List<SupplierEntity> getSearchSuppliers(String searchTerm);

    SupplierEntity getSupplierByPhone(String phone);

    boolean loginWithOtp(String email, String otp);

    boolean updateSupplierDetailsBySupplier(SupplierEntity supplierEntity);

    List<SupplierEntity> getAllActiveSupplierEntities();

    SupplierEntity getSupplierDetailsAndBankById(Integer id);

}
