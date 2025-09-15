package com.xworkz.milklore.controller;

import com.xworkz.milklore.repository.AdminRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/")
public class AdminController {

    @Autowired
    AdminRepo repo;

    public AdminController() {
        System.out.println("Admin controller constructor");

    }

    @PostMapping("adminLogin")
    public  String adiminLogin(@RequestParam String email, @RequestParam String password, Model model) {
        System.out.println("adminLogin method in controller");
        if (repo.getPasswordByEmail(email) != null){
            return "AdminLoginSuccess";
        }else {
            model.addAttribute("message","Login Failed");
            return "AdminLogin";
        }
    }

}
