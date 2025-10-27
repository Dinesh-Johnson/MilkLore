package com.xworkz.milklore.repository;

import com.xworkz.milklore.entity.AdminEntity;

import java.util.List;

public interface AdminRepo {

    boolean save(AdminEntity adminEntity);
    AdminEntity viewAdminByEmail(String email);
    boolean updateAdminDetails(String email, String adminName, String mobileNumber,String profilePath);
    boolean loginAttemptBlockedEmail(String email,boolean isBlocked);
    boolean setPasswordByEmail(String email,String password,String confirmPassword);
    List<AdminEntity> findAll();


}
