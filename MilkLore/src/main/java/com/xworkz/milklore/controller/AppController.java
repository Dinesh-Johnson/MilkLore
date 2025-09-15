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

    @GetMapping("index")
    public String index() {
        System.out.println("index method in controller");
        return "index";
    }

    @GetMapping("AdminLogin")
    public String adminLogin() {
        System.out.println("adminLogin method in controller");
        return "AdminLogin";
    }



}
