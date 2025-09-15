package com.xworkz.milklore.service;

import com.xworkz.milklore.dto.AdminDTO;

public interface AdminService {

    boolean save (AdminDTO dto);

    String getPasswordByEmail(String email,String password);
}
