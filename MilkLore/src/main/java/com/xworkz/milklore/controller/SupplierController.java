package com.xworkz.milklore.controller;

import com.xworkz.milklore.dto.AdminDTO;
import com.xworkz.milklore.dto.PaymentDetailsDTO;
import com.xworkz.milklore.dto.SupplierBankDetailsDTO;
import com.xworkz.milklore.dto.SupplierDTO;
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
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalDate;
import java.util.List;

@Slf4j
@Controller
@RequestMapping("/")
@PropertySource("classpath:application.properties")
public class SupplierController {

    @Autowired
    private AdminService adminService;

    @Autowired
    private SupplierService supplierService;

    @Autowired
    private CommonControllerHelper controllerHelper;

    @Value("${file.upload-dir}")
    private String uploadDir;

    @Autowired
    private MilkProductReceiveService collectMilkService;

    @Autowired
    private NotificationService paymentNotificationService;

    public SupplierController() {
        log.info("SupplierController constructor");
    }

    // List Suppliers
    @GetMapping("/redirectToMilkSuppliersList")
    public String getMilkSupplierList(@RequestParam String email, @RequestParam(defaultValue = "1") int page,
                                      @RequestParam(defaultValue = "10") int size, Model model, HttpSession session) {
        log.info("getMilkSupplierList method in supplier controller");


        List<SupplierDTO> list = supplierService.getAllSuppliers(page, size);
        long totalSuppliers = adminService.getSupplierCount();
        int totalPages = (int) Math.ceil((double) totalSuppliers / size);
        model.addAttribute("milkSuppliers", list);
        model.addAttribute("currentPage", page);
        model.addAttribute("pageSize", size);
        model.addAttribute("totalPages", totalPages);

        return "SuppliersList";
    }

    // Register Supplier
    @PostMapping("/registerSupplier")
    public String addMilkSupplier(@Valid SupplierDTO supplierDTO,
                                  BindingResult bindingResult,
                                  @RequestParam String adminEmail,
                                  Model model,
                                  HttpSession session) {
        log.info("addMilkSupplier in supplierController");
        System.out.println(supplierDTO);
        System.out.println("Admin Email :" + adminEmail);
        if (bindingResult.hasErrors()) {
            log.warn("fields has error");
            bindingResult.getFieldErrors()
                    .stream().map(fieldError -> fieldError.getField() + "->" + fieldError.getDefaultMessage())
                    .forEach(System.out::println);
            model.addAttribute("supplier", supplierDTO);
            model.addAttribute("error", "Details not saved");
            return getMilkSupplierList(adminEmail, 1, 10, model, session);
        }
        if (supplierService.addSupplier(supplierDTO, adminEmail)) {
            log.info("supplier added");
            model.addAttribute("success", "Supplier details saved");
        } else {
            log.warn("supplier not added");
            model.addAttribute("error", "Supplier details not saved");
        }
        return getMilkSupplierList(adminEmail, 1, 10, model, session);
    }

    // Edit Supplier
    @PostMapping("/updateMilkSupplier")
    public String editSupplier(@Valid SupplierDTO supplierDTO,
                               BindingResult bindingResult,
                               @RequestParam String adminEmail,
                               Model model,
                               HttpSession session) {
        log.info("editSupplier method in supplierController");
        System.out.println(supplierDTO);
        System.out.println("Admin EMail Update :" + adminEmail);
        if (bindingResult.hasErrors()) {
            log.warn("fields has error");
            bindingResult.getFieldErrors()
                    .stream().map(fieldError -> fieldError.getField() + "->" + fieldError.getDefaultMessage())
                    .forEach(System.out::println);
            model.addAttribute("supplier", supplierDTO);
            model.addAttribute("error", "Details not saved");
            return getMilkSupplierList(adminEmail, 1, 10, model, session);
        }
        if (supplierService.editSupplierDetails(supplierDTO, adminEmail)) {
            log.info("supplier updated");
            model.addAttribute("success", "Supplier details updated");
        } else {
            log.warn("supplier not updated");
            model.addAttribute("error", "Supplier details not updated");
        }
        return getMilkSupplierList(adminEmail, 1, 10, model, session);
    }

    // Delete Supplier
    @GetMapping("/deleteMilkSupplier")
    public String deleteSupplier(@RequestParam String email,
                                 @RequestParam(required = false) String adminEmail,
                                 Model model,
                                 HttpSession session) {
        log.info("deleteSupplier in supplier controller");
        if (supplierService.deleteSupplierDetails(email, adminEmail)) {
            log.info("supplier deleted");
            model.addAttribute("success", "Supplier details deleted");
        } else {
            log.warn("supplier not deleted");
            model.addAttribute("error", "Supplier details deleted");
        }
        return getMilkSupplierList(adminEmail, 1, 10, model, session);
    }

    @GetMapping("/searchSuppliers")
    public String getSearchSuppliers(@RequestParam String keyword, @RequestParam String email, Model model) {
        log.info("getSearchSuppliers method in supplier controller");
        AdminDTO adminDTO = adminService.viewAdminByEmail(email);
        model.addAttribute("dto", adminDTO);
        List<SupplierDTO> list = supplierService.searchSuppliers(keyword);
        if (list.isEmpty())
            model.addAttribute("error", "Data not found");
        model.addAttribute("milkSuppliers", list);
        model.addAttribute("currentPage", 1);
        model.addAttribute("totalPages", 1);
        controllerHelper.addNotificationData(model,email);
        return "SuppliersList";

    }

    @GetMapping("/redirectToSupplierLogin")
    public String supplierLoginPage() {
        log.info("Supplier Log IN Page");
        return "SupplierLogin";
    }

    // ---------------- SEND OTP ----------------
    @PostMapping("/sendOtp")
    public String sendOtp(@RequestParam String email, Model model) {
        // Trim email just in case
        email = email.trim();

        boolean sent = supplierService.generateAndSendOtp(email);

        // Add attributes to show modal on JSP
        model.addAttribute("email", email);           // preserve email in form
        model.addAttribute("otpSent", sent);          // used for styling message
        model.addAttribute("showOtpModal", sent);     // triggers modal to open
        model.addAttribute("message", sent
                ? "OTP sent successfully to your email."
                : "Failed to send OTP. Check your email.");

        return "SupplierLogin"; // JSP page
    }

    // ---------------- VERIFY OTP ----------------
    @PostMapping("/verifyOtp")
    public String verifyOtp(@RequestParam String email,
                            @RequestParam String otp,
                            Model model,HttpSession session) {
        email = email.trim();
        otp = otp.trim();

        boolean verified = supplierService.verifyOtp(email, otp);

        if (verified) {
            // Store email in session
            session.setAttribute("supplierEmail", email);

            // Add email to model for the current request
            model.addAttribute("email", email);

            // Get supplier details to pass to the dashboard
            SupplierDTO dto = supplierService.getSupplierDetailsByEmail(email);
            if (dto != null) {
                model.addAttribute("dto", dto);
            }
            return "SupplierDashboard"; // JSP page for dashboard
        } else {
            // OTP wrong → reopen modal with error
            model.addAttribute("email", email);
            model.addAttribute("otpSent", true);           // keep modal styling
            model.addAttribute("showOtpModal", true);      // show modal again
            model.addAttribute("message", "Invalid or expired OTP. Try again.");

            return "SupplierLogin"; // JSP page
        }
    }
    @GetMapping("/redirectToSupplierDashboard")
    public String getSupplierDashboardPage(@RequestParam String email, Model model) {
        log.info("getSupplierDashboardPage method in supplier controller");
        SupplierDTO dto = supplierService.getSupplierDetailsByEmail(email);
        LocalDate lastDate=collectMilkService.getLastCollectedDate(dto.getSupplierId());
        if(lastDate==null)
            model.addAttribute("lastCollectedDate","Yet to collect");
        else model.addAttribute("lastCollectedDate",lastDate);

        Double litres=collectMilkService.getTotalLitre(dto.getSupplierId());
        if(litres==null)
            model.addAttribute("totalLitres",0);
        else model.addAttribute("totalLitres",litres);

        Double amount=paymentNotificationService.getTotalAmountPaid(dto.getSupplierId());
        if(amount==null)
            model.addAttribute("totalAmountPaid","No Collection");
        else model.addAttribute("totalAmountPaid","Rs."+amount+"/-");
        model.addAttribute("dto", dto);
        return "SupplierDashboard";
    }

    @GetMapping("/redirectToUpdateSupplierProfile")
    public String getUpdateProfilePage(@RequestParam(required = false) String email,
                                       Model model,
                                       HttpSession session) {
        log.info("getUpdateProfilePage method in supplier controller");

        // If email is not provided in request, try to get it from session
        if (email == null || email.trim().isEmpty()) {
            email = (String) session.getAttribute("supplierEmail");
            if (email == null) {
                log.warn("No email provided and no email in session");
                return "redirect:/supplierLogin"; // or appropriate error page
            }
        }

        SupplierDTO dto = supplierService.getSupplierDetailsByEmail(email.trim());

        if (dto == null) {
            log.warn("No supplier found for email: {}", email);
            model.addAttribute("errorMessage", "No supplier found with email: " + email);
            return "SupplierDashboard"; // fallback page
        }

        model.addAttribute("dto", dto);
        return "SupplierProfileFragment"; // JSP for profile update
    }


    @PostMapping("updateSupplierProfile")
    public String updateSupplierProfile(@Valid SupplierDTO supplierDTO, BindingResult bindingResult, @RequestParam(required = false)MultipartFile profilePicture, Model model)
    {
        log.info("updateSupplierProfile method in supplier controller");
        if(bindingResult.hasErrors())
        {
            log.error("fields has error");
            bindingResult.getFieldErrors().stream().map(e->e.getField()+" -> "+e.getDefaultMessage())
                    .forEach(log::error);
            model.addAttribute("dto",supplierDTO);
            model.addAttribute("errorMessage","Invalid details");
            return "SupplierProfileFragment";
        }
        if (profilePicture != null && !profilePicture.isEmpty()) {
            try {
                byte[] bytes = profilePicture.getBytes();
                String fileName = supplierDTO.getFirstName() + "_" + System.currentTimeMillis() + "_" + profilePicture.getOriginalFilename();
                Path path = Paths.get(uploadDir ,fileName);
                Files.write(path, bytes);
                supplierDTO.setProfilePath(path.getFileName().toString());
            } catch (IOException e) {
                log.error(e.getMessage());
            }
        } else {
            log.warn("No new profile picture uploaded.");
        }
        if(supplierService.updateSupplierDetailsBySupplier(supplierDTO))
        {
            return getSupplierDashboardPage(supplierDTO.getEmail(),model);
        }else {
            model.addAttribute("errorMessage","Details not updated");
            model.addAttribute("dto",supplierDTO);
        }
        return "SupplierProfileFragment";
    }
    @GetMapping("redirectToUpdateSupplierBankDetails")
    public String redirectToUpdateSupplierBankDetailsPage(@RequestParam String email,Model model)
    {
        log.info("redirectToUpdateSupplierBankDetailsPage method in supplier controller");
        model.addAttribute("dto",supplierService.getSupplierDetailsByEmail(email));
        return "UpdateSupplierBankDetails";
    }


    @PostMapping("/updateBankDetails")
    public String supplierUpdateBankDetails(@Valid SupplierBankDetailsDTO supplierBankDetailsDTO, BindingResult bindingResult, @RequestParam String email, Model model)
    {
        log.info("supplierUpdateBankDetailsPage method in supplier controller");
        if(bindingResult.hasErrors())
        {
            log.error("fields has error");
            bindingResult.getFieldErrors().stream().map(e->e.getField()+" -> "+e.getDefaultMessage())
                    .forEach(System.out::println);
            model.addAttribute("bank",supplierBankDetailsDTO);
            model.addAttribute("dto.email",email);
            return "UpdateSupplierBankDetails";
        }
        if(supplierService.updateSupplierBankDetails(supplierBankDetailsDTO,email))
        {
            log.info("bank details updated");
            return getSupplierDashboardPage(email,model);
        }else {
            model.addAttribute("bank",supplierBankDetailsDTO);
            model.addAttribute("dto.email",email);
        }
        return "UpdateSupplierBankDetails";

    }

    @PostMapping("/updateSupplierBankDetailsByAdmin")
    public String updateSupplierBankDetailsByAdmin(@Valid SupplierBankDetailsDTO supplierBankDetailsDTO,BindingResult bindingResult,
                                                   @RequestParam String adminEmail,@RequestParam String email,Model model,HttpSession session)
    {
        log.info("updateSupplierBankDetailsByAdmin method in supplier controller");
        if(bindingResult.hasErrors())
        {
            log.error("fields has error");
            bindingResult.getFieldErrors().stream().map(e->e.getField()+" -> "+e.getDefaultMessage())
                    .forEach(System.out::println);
            model.addAttribute("error","Bank details not updated");
            return getMilkSupplierList(adminEmail,1,10,model,session);
        }
        if(supplierService.updateSupplierBankDetailsByAdmin(supplierBankDetailsDTO,email,adminEmail))
        {
            model.addAttribute("success","Bank details updated");
        }else {
            model.addAttribute("error","Bank details not updated");
        }
        model.addAttribute("email", email);
        return getMilkSupplierList(adminEmail,1,10,model,session);
    }

    @GetMapping("/redirectToPaymentStatus")
    public String getPaymentStatus(@RequestParam String email,Model model)
    {
        log.info("getPayment status in supplier controller");
        SupplierDTO supplierDTO=supplierService.getSupplierDetailsByEmail(email);
        List<PaymentDetailsDTO> list=paymentNotificationService.getPaymentDetailsForSupplier(supplierDTO);
        model.addAttribute("dto",supplierDTO);
        model.addAttribute("paymentList",list);
        return "SupplierPaymentStatus";
    }

}
