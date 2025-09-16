package com.xworkz.milklore.controller;

import com.xworkz.milklore.dto.AdminDTO;
import com.xworkz.milklore.service.AdminService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

@Controller
@RequestMapping("/")
@PropertySource("classpath:application.properties")
@Slf4j
public class AdminController {

    @Autowired
    AdminService service;

    @Value("${file.upload-dir}")
    private String uploadDir;

    public AdminController() {
        System.out.println("Admin controller constructor");

    }

    @PostMapping("adminLogin")
    public  String adiminLogin(@RequestParam String email, @RequestParam String password, Model model) {
        System.out.println("adminLogin method in controller");
        if (service.getPasswordByEmail(email,password) != null){
            AdminDTO dto = service.viewAdminByEmail(email);
            model.addAttribute("dto", dto);
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
        return "AdminEdit";
    }

    @GetMapping("editProfile")
    public String onEdit(@RequestParam("email") String email, Model model) {
        System.out.println("Opening Edit In Page..");
        AdminDTO dto = service.viewAdminByEmail(email);
        model.addAttribute("dto", dto);
        return "AdminEdit";
    }

    @PostMapping("AdminEdit")
    public String onEdit(@RequestParam("adminName") String adminName,
                         @RequestParam("mobileNumber") String mobileNumber,
                         @RequestParam(value = "profileImage", required = false) MultipartFile profilePicture,
                         @RequestParam("email") String email,
                         Model model) {
        System.out.println("AdminEdit method in controller");
        String filePath = null;

        if (profilePicture != null && !profilePicture.isEmpty()) {
            try {
                System.out.println(uploadDir);
                byte[] bytes = profilePicture.getBytes();
                String fileName = adminName + "-" + System.currentTimeMillis() + "-" + profilePicture.getOriginalFilename();
                Path path = Paths.get(uploadDir, fileName);
                Files.write(path, bytes);
                filePath = path.getFileName().toString();
            } catch (Exception e) {
                System.out.println(e.getMessage());
            }
        } else {
            log.info("Profile picture is empty");
        }

        if (service.updateAdminDetails(email, adminName, mobileNumber, filePath)) {
            AdminDTO dto = service.viewAdminByEmail(email);
            model.addAttribute("dto", dto);
            return "AdminLoginSuccess";
        } else {
            model.addAttribute("errorMessage", "Check The Details");
            return onEdit(email, model);
        }
    }

}
