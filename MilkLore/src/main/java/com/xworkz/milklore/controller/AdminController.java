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

import javax.servlet.http.HttpSession;
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

    @Autowired
    AppController controller;

    public AdminController() {
        System.out.println("Admin controller constructor");

    }

    @PostMapping("adminLogin")
    public String adiminLogin(@RequestParam String email,
                              @RequestParam String password,
                              Model model, HttpSession session) {
        System.out.println("adminLogin method in Admin controller");
        AdminDTO adminDTO = null;
        try {
            adminDTO = service.getPasswordByEmail(email, password);
            if (adminDTO != null) {
                log.info("If Block COntrolelr");
                session.setAttribute("dto", adminDTO);
                model.addAttribute("dto", adminDTO);
                return "AdminLoginSuccess";
            } else {
                log.info("Else Bock");
                model.addAttribute("errorMessage", "Account not present");
                return "AdminLogin";
            }
        } catch (RuntimeException e) {
            log.info("Catch block");
            model.addAttribute("errorMessage", e.getMessage());
            model.addAttribute("accountBlockedMsg", "Account blocked. Please reset your password using 'Forgot Password'.");
        }
        return "AdminLogin";
    }


    @GetMapping("viewProfile")
    public String onView(@RequestParam("email")String email,Model model,HttpSession session){
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
    public String onEdit(@RequestParam("email") String email, Model model,HttpSession session) {
        AdminDTO userlogin = (AdminDTO) session.getAttribute("dto");
        if(userlogin == null){
            return "AdminLogin";
        }
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
                         Model model,HttpSession session) {
        System.out.println("AdminEdit method in Admin controller");
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
            AdminDTO userlogin = (AdminDTO) session.getAttribute("dto");
            model.addAttribute("dto", dto);
            return "AdminLoginSuccess";
        } else {
            model.addAttribute("errorMessage", "Check The Details");
            return onEdit(email, model,session);
        }
    }
    @PostMapping("/forgotPassword")
    public String sendEmailForSetPassword(@RequestParam("email")String email,Model model){
        log.info("sendEmailForSetPassword method in admin Admin controller");
        if(service.sendMailToSetPassword(email))
        {
            log.info("Email send");
            model.addAttribute("errorMessage","Email send to your mail");
        }else{
            log.error("Email not send");
            model.addAttribute("errorMessage","Email not send to your mail");
        }
        return "AdminLogin";
    }

    @GetMapping("/setPassword")
    public String redirectToSetPassword(@RequestParam("email")String email, Model model)
    {
        log.info("redirectToSetPassword method in admin Admin controller");
        model.addAttribute("email",email);
        return "SetPassword";
    }

    @PostMapping("/setPassword")
    public String resetPassword(@RequestParam String email,@RequestParam String password,
                                @RequestParam String confirmPassword,Model model)
    {
        log.info("resetPassword method in admin Admin controller");
        if(service.setPasswordByEmail(email,password,confirmPassword))
        {
            log.info("password changed");
            model.addAttribute("email",email);
            model.addAttribute("errorMessage","Account unblocked");
            return controller.adminLogin();
        }else {
            log.error("password not changed");
            model.addAttribute("errorMessage","Password incorrect");
            return redirectToSetPassword(email,model);
        }
    }

    @GetMapping("redirectToAdminSuccess")
    public String redirectToAdminSuccess(@RequestParam String email,Model model){
        log.info("redirectToAdminSuccess method in admin Admin controller");
        AdminDTO dto = service.viewAdminByEmail(email);
        model.addAttribute("dto", dto);
        return "AdminLoginSuccess";
    }

    @GetMapping("logout")
    public String logout(HttpSession session,Model model){
        log.info("logout method in admin Admin controller");
        session.invalidate();
        model.addAttribute("errorMessage","Logged out successfully");
        return "AdminLogin";
    }


}
