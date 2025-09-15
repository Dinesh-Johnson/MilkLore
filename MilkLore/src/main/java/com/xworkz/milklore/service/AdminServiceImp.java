package com.xworkz.milklore.service;

import com.xworkz.milklore.dto.AdminDTO;
import com.xworkz.milklore.entity.AdminEntity;
import com.xworkz.milklore.repository.AdminRepo;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.GetMapping;

@Service
@Slf4j
public class AdminServiceImp implements AdminService{

    @Autowired
    AdminRepo repo;

    @Autowired
    BCryptPasswordEncoder encoder;

    @Override
    public boolean save(AdminDTO dto) {
        log.info("Admin save method in service");
        AdminEntity entity=new AdminEntity();
        BeanUtils.copyProperties(dto,entity);
        entity.setPassword(encoder.encode(entity.getPassword()));
        return repo.save(entity);
    }

    @Override
    public String getPasswordByEmail(String email,String password) {
        System.out.println("Admin getPasswordByEmail method in service");
        String dbPassword=repo.getPasswordByEmail(email);
        if (encoder.matches(dbPassword,password)){
            return "Login Success";
        }
        return repo.getPasswordByEmail(email);
    }

    @Override
    public AdminDTO viewAdminByEmail(String email) {
        System.out.println("View By email Service");
        AdminEntity entity = repo.viewAdminByEmail(email);

        if (entity == null) {
            System.out.println("No AdminEntity found for email: " + email);
            return null; // or throw a custom exception
        }

        AdminDTO dto = new AdminDTO();
        BeanUtils.copyProperties(entity, dto);
        return dto;
    }

    @Override
    public boolean updateAdminDetails(String email, String adminName, String mobileNumber, String password) {
        log.info("Admin updateAdminDetails method in service");
        return repo.updateAdminDetails(email, adminName, mobileNumber, password);
    }

}

