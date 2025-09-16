package com.xworkz.milklore.repository;

import com.xworkz.milklore.entity.AdminEntity;

public interface AdminRepo {

    boolean save(AdminEntity adminEntity);
    String getPasswordByEmail(String email);
    AdminEntity viewAdminByEmail(String email);
    boolean updateAdminDetails(String email, String adminName, String mobileNumber,String profilePath);


}
