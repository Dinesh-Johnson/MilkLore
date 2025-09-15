package com.xworkz.milklore.service;

import com.xworkz.milklore.dto.AdminDTO;
import com.xworkz.milklore.entity.AdminEntity;
import com.xworkz.milklore.repository.AdminRepo;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

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
}

