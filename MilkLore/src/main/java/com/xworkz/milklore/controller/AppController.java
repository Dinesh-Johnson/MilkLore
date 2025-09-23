package com.xworkz.milklore.controller;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/")
public class AppController {

    public AppController() {
        System.out.println("AppController constructor");
    }

    @GetMapping("toIndex")
    public String index() {
        System.out.println("index method in controller");
        return "index";
    }

    @GetMapping("redirectToAdminLogin")
    public String adminLogin() {
        System.out.println("adminLogin method in APP controller");
        return "AdminLogin";
    }

    @GetMapping("manageSuppliers")
    public String manageSuppliers() {
        System.out.println("manageSuppliers method in APP controller");
        return "SuppliersList";
    }

    @GetMapping("reDirecttoSupplier")
    public String reDirecttoSupplier() {
        System.out.println("reDirecttoSupplier method in APP controller");

        return "SupplierRegister";
    }


}
