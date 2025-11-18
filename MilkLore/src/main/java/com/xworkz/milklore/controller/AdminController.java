package com.xworkz.milklore.controller;

import com.xworkz.milklore.dto.AdminDTO;
import com.xworkz.milklore.dto.PaymentDetailsDTO;
import com.xworkz.milklore.service.AdminService;
import com.xworkz.milklore.service.MilkProductReceiveService;
import com.xworkz.milklore.service.NotificationService;
import com.xworkz.milklore.service.SupplierService;
import com.xworkz.milklore.utill.CommonControllerHelper;
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

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

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
    private NotificationService notificationService;

    @Autowired
    private SupplierService supplierService;

    @Autowired
    private CommonControllerHelper controllerHelper;

    @Autowired
    private MilkProductReceiveService collectMilkService;

    @Autowired
    AppController controller;

    public AdminController() {
        System.out.println("Admin controller constructor");

    }

    @PostMapping("adminLogin")
    public String adiminLogin(@RequestParam String email, @RequestParam String password,
                              Model model, HttpSession session, HttpServletResponse response, HttpServletRequest request) {
        System.out.println("adminLogin method in Admin controller");
        AdminDTO adminDTO = null;
        try {
            adminDTO = service.getPasswordByEmail(email, password);
            if (adminDTO != null) {
                log.info("If Block COntrolelr");
                session.setAttribute("dto", adminDTO);
                model.addAttribute("dto", adminDTO);
                session.setAttribute("userRole", "ADMIN");
                session.setAttribute("adminEmail",email);
                Cookie cookie = new Cookie("adminEmail", email);
                cookie.setMaxAge(7 * 24 * 60 * 60);
                cookie.setPath("/");
                response.addCookie(cookie);
                return redirectToAdminSuccess(session,model,request);
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
    public String redirectToUpdate(HttpSession session, Model model) {
        log.info("redirectTo update page in adminController");
        String email = (String) session.getAttribute("adminEmail");
        AdminDTO adminDTO = service.viewAdminByEmail(email);
        model.addAttribute("dto", adminDTO);
        return "AdminEdit";
    }

    @PostMapping("AdminEdit")
    public String onEdit(@RequestParam("adminName") String adminName,
                         @RequestParam("mobileNumber") String mobileNumber,
                         @RequestParam(value = "profileImage", required = false) MultipartFile profilePicture,
                         @RequestParam("email") String email,
                         Model model,HttpSession session,HttpServletRequest request) {
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
            model.addAttribute("dto", dto);
            return "AdminLoginSuccess";
        } else {
            model.addAttribute("errorMessage", "Check The Details");
            return redirectToUpdate(session, model);
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


    @GetMapping("/adminLogout")
    public String updateAdminLogout(Model model,HttpSession session,HttpServletRequest request)
    {
        log.info("updateAdminLogout method in admin controller");
        String email = (String) session.getAttribute("adminEmail");
        if(service.updateAdminLogoutTime(email))
        {
            log.info("logout time changed");
            session.invalidate();
            return "redirect:/toIndex";
        }
        return redirectToAdminSuccess(session,model,request);
    }

    @GetMapping("redirectToAdminSuccess")
    public String redirectToAdminSuccess(HttpSession session, Model model, HttpServletRequest request){
        log.info("redirectToAdminSuccess method in admin Admin controller");
        String email = (String) session.getAttribute("adminEmail");
        if (email == null) {
            Cookie[] cookies = request.getCookies();
            if (cookies != null) {
                for (Cookie c : cookies) {
                    if ("adminEmail".equals(c.getName())) {
                        email = c.getValue();
                        session.setAttribute("adminEmail", email);
                        break;
                    }
                }
            }
        }
        AdminDTO dto = service.viewAdminByEmail(email);
        model.addAttribute("dto", dto);
        controllerHelper.addNotificationData(model,email);
        log.error("WORKING");
        return "AdminLoginSuccess";
    }


    @GetMapping("/supplierPaymentDetails")
    public String getSupplierPaymentDetails(@RequestParam Long notificationId,HttpSession session, Model model)
    {
        log.info("getSupplierPaymentDetails method in supplier controller");
        model.addAttribute("supplier",supplierService.getSupplierDetailsByNotificationId(notificationId));
        String email = (String) session.getAttribute("adminEmail");
        model.addAttribute("dto",service.viewAdminByEmail(email));
        model.addAttribute("notificationId",notificationId);
        model.addAttribute("paymentAmount",notificationService.getAmountById(notificationId));
        model.addAttribute("milkList",collectMilkService.getAllDetailsBySupplier(notificationId));
        controllerHelper.addNotificationData(model,email);
        return "SupplierPayDetails";
    }


    @PostMapping("/payToSupplier")
    public String payToSupplier(HttpSession session,@RequestParam String supplierEmail,@RequestParam Long notificationId,
                                Model model,HttpServletRequest request)
    {
        log.info("pay to supplier method in supplier controller");

        String email = (String) session.getAttribute("adminEmail");
        if(notificationService.markAsReadForPayment(notificationId,supplierEmail,email))
        {
            return redirectToAdminSuccess(session,model,request);
        }
        model.addAttribute("errorMessage","Amount Not paid");
        return getSupplierPaymentDetails(notificationId,session,model);
    }

    @PostMapping("/requestSupplierBankDetails")
    public String requestForSupplierBankDetails(HttpSession session,@RequestParam String supplierEmail,@RequestParam Long notificationId,Model model)
    {
        log.info("requestForSupplierBankDetails method in admin Controller");
        String email = (String) session.getAttribute("adminEmail");
        if(supplierService.requestForSupplierBankDetails(supplierEmail))
        {
            model.addAttribute("dto",service.viewAdminByEmail(email));
            model.addAttribute("successMessage","Mail sent successfully");
        }else {
            model.addAttribute("errorMessage", "Mail not send");
        }
        return getSupplierPaymentDetails(notificationId,session,model);

    }

    @GetMapping("/redirectToAdminPaymentHistory")
    public String redirectToAdminPaymentHistory(HttpSession session,@RequestParam(defaultValue = "1") int page,
                                                @RequestParam(defaultValue = "10") int size, Model model)
    {
        log.info("redirectToAdminPaymentHistory method in adminController");
        List<PaymentDetailsDTO> list=notificationService.getAllPaymentDetailsForAdminHistory(page,size);
        model.addAttribute("paymentList",list);
        String email = (String) session.getAttribute("adminEmail");
        model.addAttribute("dto",service.viewAdminByEmail(email));

        Integer totalCount= notificationService.getTotalCount();
        int totalPages = (int) Math.ceil((double) totalCount / size);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("pageSize", size);

        controllerHelper.addNotificationData(model,email);
        return "AdminPaymentHistory";
    }

}
