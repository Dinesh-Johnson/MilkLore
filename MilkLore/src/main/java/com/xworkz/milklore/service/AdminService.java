package com.xworkz.milklore.service;

import com.xworkz.milklore.dto.AdminDTO;
import com.xworkz.milklore.entity.AdminEntity;

public interface AdminService {

    boolean save (AdminDTO dto);

    String getPasswordByEmail(String email,String password);

    AdminDTO viewAdminByEmail(String email);
    boolean updateAdminDetails(String email, String adminName, String mobileNumber, String password);
}
