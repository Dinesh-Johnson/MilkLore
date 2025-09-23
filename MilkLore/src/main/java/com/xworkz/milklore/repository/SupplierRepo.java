package com.xworkz.milklore.repository;

import com.xworkz.milklore.entity.SupplierEntity;

import java.util.List;

public interface SupplierRepo {

    boolean addSupplier(SupplierEntity supplierEntity);

    List<SupplierEntity> getAllSuppliers();

    boolean checkEmail(String email);

    boolean checkPhoneNumber(String phoneNumber);

    boolean updateSupplierDetails(SupplierEntity supplierEntity,Boolean isDelete);

    SupplierEntity getSupplierByEmail(String email);

}
