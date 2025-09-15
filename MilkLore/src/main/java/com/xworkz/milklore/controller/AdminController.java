package com.xworkz.milklore.controller;

import com.xworkz.milklore.dto.AdminDTO;
import com.xworkz.milklore.service.AdminService;
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
    AdminService service;

    public AdminController() {
        System.out.println("Admin controller constructor");

    }

    @PostMapping("adminLogin")
    public  String adiminLogin(@RequestParam String email, @RequestParam String password, Model model) {
        System.out.println("adminLogin method in controller");
        if (service.getPasswordByEmail(email,password) != null){
            return "AdminLoginSuccess";
        }else {
            model.addAttribute("message","Login Failed");
            return "AdminLogin";
        }
    }

    @GetMapping("viewProfile")
    public String onView(@RequestParam("email")String email,Model model){
        System.out.println("Opening View In Page..");
        AdminDTO dto = service.viewAdminByEmail(email);

        if (dto == null) {
            model.addAttribute("errorMessage", "No admin found for email: " + email);
            return "AdminLoginSuccess";  // show an error page or redirect
        }

        model.addAttribute("dto", dto);
        return "AdminDetails";
    }
}
