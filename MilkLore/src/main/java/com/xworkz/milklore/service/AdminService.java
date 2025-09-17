package com.xworkz.milklore.service;


import com.xworkz.milklore.dto.AdminDTO;

public interface AdminService {

    boolean save (AdminDTO dto);

    AdminDTO getPasswordByEmail(String email,String password);

    AdminDTO viewAdminByEmail(String email);
    boolean updateAdminDetails(String email, String adminName, String mobileNumber,String profilePath);
    boolean checkEmailByEmail(String email);
    boolean sendMailToSetPassword(String email);
    boolean setPasswordByEmail(String email,String password,String confirmPassword);

}
