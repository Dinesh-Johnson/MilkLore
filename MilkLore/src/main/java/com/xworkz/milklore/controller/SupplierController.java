package com.xworkz.milklore.controller;

import com.xworkz.milklore.dto.*;
import com.xworkz.milklore.service.*;
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

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
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

    @Value("${supplier-upload.path}")
    private String uploadPath;

    @Autowired
    private MilkProductReceiveService collectMilkService;

    @Autowired
    private NotificationService paymentNotificationService;

    @Autowired
    private SupplierImportService supplierImportService;

    public SupplierController() {
        log.info("SupplierController constructor");
    }

    // List Suppliers
    @GetMapping("/redirectToMilkSuppliersList")
    public String getMilkSupplierList(HttpSession session, @RequestParam(defaultValue = "1") int page,
                                      @RequestParam(defaultValue = "10") int size, Model model) {
        log.info("getMilkSupplierList method in supplier controller");

        // Get admin DTO and add to model
        String email = (String) session.getAttribute("adminEmail");
        AdminDTO adminDTO = adminService.viewAdminByEmail(email);
        if (adminDTO != null) {
            model.addAttribute("dto", adminDTO);
        }

        List<SupplierDTO> list = supplierService.getAllSuppliers(page, size);
        long totalSuppliers = adminService.getSupplierCount();
        int totalPages = (int) Math.ceil((double) totalSuppliers / size);
        model.addAttribute("milkSuppliers", list);
        model.addAttribute("currentPage", page);
        model.addAttribute("pageSize", size);
        model.addAttribute("totalPages", totalPages);
        controllerHelper.addNotificationData(model,email);
        return "SuppliersList";
    }

    // Register Supplier
    @PostMapping("/registerSupplier")
    public String addMilkSupplier(@Valid SupplierDTO supplierDTO,
                                  BindingResult bindingResult,
                                  HttpSession session,
                                  Model model) {
        log.info("addMilkSupplier in supplierController");
        System.out.println(supplierDTO);
        String email = (String) session.getAttribute("adminEmail");
        System.out.println("Admin Email :" + email);
        if (bindingResult.hasErrors()) {
            log.warn("fields has error");
            bindingResult.getFieldErrors()
                    .stream().map(fieldError -> fieldError.getField() + "->" + fieldError.getDefaultMessage())
                    .forEach(System.out::println);
            model.addAttribute("supplier", supplierDTO);
            model.addAttribute("error", "Details not saved");
            return getMilkSupplierList(session, 1, 10, model);
        }
        if (supplierService.addSupplier(supplierDTO, email)) {
            log.info("supplier added");
            model.addAttribute("success", "Supplier details saved");
        } else {
            log.warn("supplier not added");
            model.addAttribute("error", "Supplier details not saved");
        }
        return getMilkSupplierList(session, 1, 10, model);
    }

    // Edit Supplier
    @PostMapping("/updateMilkSupplier")
    public String editSupplier(@Valid SupplierDTO supplierDTO,
                               BindingResult bindingResult,
                               HttpSession session,
                               Model model
                                ) {
        log.info("editSupplier method in supplierController");
        System.out.println(supplierDTO);
        String adminEmail = (String) session.getAttribute("adminEmail");
        System.out.println("Admin EMail Update :" + adminEmail);
        if (bindingResult.hasErrors()) {
            log.warn("fields has error");
            bindingResult.getFieldErrors()
                    .stream().map(fieldError -> fieldError.getField() + "->" + fieldError.getDefaultMessage())
                    .forEach(System.out::println);
            model.addAttribute("supplier", supplierDTO);
            model.addAttribute("error", "Details not saved");
            return getMilkSupplierList(session, 1, 10, model);
        }
        if (supplierService.editSupplierDetails(supplierDTO, adminEmail)) {
            log.info("supplier updated");
            model.addAttribute("success", "Supplier details updated");
        } else {
            log.warn("supplier not updated");
            model.addAttribute("error", "Supplier details not updated");
        }
        return getMilkSupplierList(session, 1, 10, model);
    }

    // Delete Supplier
    @GetMapping("/deleteMilkSupplier")
    public String deleteSupplier(HttpSession session,
                                 @RequestParam(required = false) String adminEmail,
                                 Model model) {
        log.info("deleteSupplier in supplier controller");
        String email = (String) session.getAttribute("adminEmail");
        if (supplierService.deleteSupplierDetails(email, adminEmail)) {
            log.info("supplier deleted");
            model.addAttribute("success", "Supplier details deleted");
        } else {
            log.warn("supplier not deleted");
            model.addAttribute("error", "Supplier details deleted");
        }
        return getMilkSupplierList(session, 1, 10, model);
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
    public String checkOtpForSupplierLogin(@RequestParam String email, @RequestParam String otp, Model model,
                                           HttpSession session,HttpServletResponse response,HttpServletRequest request){


        email = email.trim();
        otp = otp.trim();
        boolean verified = supplierService.verifyOtp(email, otp);

        if (verified) {
            // ✅ Save supplier email in session
            model.addAttribute("errorMessage", "successfully login");
            model.addAttribute("success","success");
            session.setAttribute("supplierEmail", email);
            Cookie cookie = new Cookie("supplierEmail", email);
            cookie.setMaxAge(7 * 24 * 60 * 60);
            cookie.setPath("/");
            response.addCookie(cookie);

            SupplierDTO dto = supplierService.getSupplierDetailsByEmail(email);
            if (dto != null) {
                model.addAttribute("dto", dto);
            }
            session.setAttribute("userRole", "SUPPLIER");
            return getSupplierDashboardPage(session,request,model);
        } else {
            model.addAttribute("email", email);
            model.addAttribute("otpSent", true);
            model.addAttribute("showOtpModal", true);
            model.addAttribute("message", "Invalid or expired OTP. Try again.");
            return "SupplierLogin";
        }
    }

    @GetMapping("/redirectToSupplierDashboard")
    public String getSupplierDashboardPage(HttpSession session, HttpServletRequest request, Model model) {
        log.info("getSupplierDashboardPage method in supplier controller");

        // ✅ Use session email if not provided
        String email = (String) session.getAttribute("supplierEmail");
        if (email == null || email.trim().isEmpty()) {
            email = (String) session.getAttribute("supplierEmail");
            log.info("Email fetched from session: {}", email);
        }

        if (email == null || email.trim().isEmpty()) {
            log.warn("Email missing or session expired");
            model.addAttribute("errorMessage", "Session expired. Please log in again.");
            return "SupplierLogin";
        }

        SupplierDTO dto = supplierService.getSupplierDetailsByEmail(email.trim());
        if (dto == null) {
            model.addAttribute("errorMessage", "No supplier found for " + email);
            return "SupplierLogin";
        }

        // ✅ Now safely get all supplier-related data
        LocalDate lastDate = collectMilkService.getLastCollectedDate(dto.getSupplierId());
        model.addAttribute("lastCollectedDate", lastDate == null ? "Yet to collect" : lastDate);

        Double litres = collectMilkService.getTotalLitre(dto.getSupplierId());
        model.addAttribute("totalLitres", litres == null ? 0 : litres);

        Double amount = paymentNotificationService.getTotalAmountPaid(dto.getSupplierId());
        model.addAttribute("totalAmountPaid", amount == null ? "No Collection" : "Rs." + amount + "/-");

        model.addAttribute("paymentList", paymentNotificationService.getPaymentDetailsForSupplier(dto));
        model.addAttribute("collectionList", collectMilkService.getAllDetailsBySupplierEmail(email));
        model.addAttribute("dto", dto);

        return "SupplierDashboard";
    }



    @GetMapping("/redirectToUpdateSupplierProfile")
    public String getUpdateProfilePage(@RequestParam(required = false) String email,
                                       Model model,HttpSession session) {
        log.info("getUpdateProfilePage method in supplier controller");

        // If email is not provided in request, try to get it from 
        if (email == null || email.trim().isEmpty()) {
            if (email == null) {
                log.warn("No email provided and no email in ");
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
    public String updateSupplierProfile(@Valid SupplierDTO supplierDTO, BindingResult bindingResult, @RequestParam(required = false)MultipartFile profilePicture,
                                        Model model,HttpSession session,HttpServletRequest request)
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
            return getSupplierDashboardPage(session,request,model);
        }else {
            model.addAttribute("errorMessage","Details not updated");
            model.addAttribute("dto",supplierDTO);
        }
        return "SupplierProfileFragment";
    }

    @GetMapping("logoutSupplier")
    public String supplierLogout(@RequestParam String email,HttpSession session)
    {
        log.info("supplier log out");
        session.invalidate();
        return "redirect:/toIndex";
    }

    @GetMapping("redirectToUpdateSupplierBankDetails")
    public String redirectToUpdateSupplierBankDetailsPage(HttpSession session,Model model)
    {
        log.info("redirectToUpdateSupplierBankDetailsPage method in supplier controller");
        String email = (String) session.getAttribute("email");
        model.addAttribute("dto",supplierService.getSupplierDetailsByEmail(email));
        return "UpdateSupplierBankDetails";
    }


    @PostMapping("/updateBankDetails")
    public String supplierUpdateBankDetails(@Valid SupplierBankDetailsDTO supplierBankDetailsDTO, BindingResult bindingResult,
                                            HttpSession session, Model model, HttpServletRequest request)
    {
        log.info("supplierUpdateBankDetailsPage method in supplier controller");
        String email = (String) session.getAttribute("supplierEmail");
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
            return getSupplierDashboardPage(session,request,model);
        }else {
            model.addAttribute("bank",supplierBankDetailsDTO);
            model.addAttribute("dto.email",email);
        }
        return "UpdateSupplierBankDetails";
    }

    //admin
    @PostMapping("/updateSupplierBankDetailsByAdmin")
    public String updateSupplierBankDetailsByAdmin(@Valid SupplierBankDetailsDTO supplierBankDetailsDTO,BindingResult bindingResult,
                                                   HttpSession session,@RequestParam String email,Model model)
    {
        log.info("updateSupplierBankDetailsByAdmin method in supplier controller");
        String adminEmail = (String) session.getAttribute("adminEmail");
        if(bindingResult.hasErrors())
        {
            log.error("fields has error");
            bindingResult.getFieldErrors().stream().map(e->e.getField()+" -> "+e.getDefaultMessage())
                    .forEach(System.out::println);
            model.addAttribute("error","Bank details not updated");
            return getMilkSupplierList(session,1,10,model);
        }
        if(supplierService.updateSupplierBankDetailsByAdmin(supplierBankDetailsDTO,email,adminEmail))
        {
            model.addAttribute("success","Bank details updated");
        }else {
            model.addAttribute("error","Bank details not updated");
        }
        return getMilkSupplierList(session,1,10,model);
    }


    @GetMapping("/redirectToPaymentStatus")
    public String getPaymentStatus(HttpSession session,Model model)
    {
        log.info("getPayment status in supplier controller");
        String email = (String) session.getAttribute("supplierEmail");
        SupplierDTO supplierDTO=supplierService.getSupplierDetailsByEmail(email);
        List<PaymentDetailsDTO> list=paymentNotificationService.getPaymentDetailsForSupplier(supplierDTO);
        model.addAttribute("dto",supplierDTO);
        model.addAttribute("paymentList",list);
        return "SupplierPaymentStatus";
    }


    @GetMapping("/generateInvoiceForSupplier")
    public void getInvoiceForSupplier(@RequestParam String periodStart, @RequestParam String periodEnd,
                                      @RequestParam String paymentDate, @RequestParam Integer supplierId,@RequestParam Integer paymentId, HttpServletResponse response)
    {
        log.info("getInvoiceForSupplier method in supplier controller");
        supplierService.downloadInvoicePdf(supplierId,paymentId, LocalDate.parse(periodStart), LocalDate.parse(periodEnd), LocalDate.parse(paymentDate), response);
    }

    @PostMapping("/importForSupplierRegister")
    public String uploadFile(@RequestParam("file") MultipartFile file,@RequestParam String email, Model model,HttpSession session) {
        log.info("uploadFile method in SupplierController");
        AdminDTO adminDTO = adminService.viewAdminByEmail(email);
        model.addAttribute("dto", adminDTO);
        try {
            if (file.isEmpty()) {
                model.addAttribute("error", "Please choose a file to upload.");
                return getMilkSupplierList(session,1,10,model);
            }

            File directory = new File(uploadPath);
            if (!directory.exists()) {
                directory.mkdirs();
            }
            String fileName = System.currentTimeMillis() + "_" + file.getOriginalFilename();
            Path filePath = Paths.get(uploadPath, fileName);

            Files.copy(file.getInputStream(), filePath, StandardCopyOption.REPLACE_EXISTING);

            List<SupplierDTO> invalidRows=supplierImportService.importSuppliersFromExcel(filePath.toString(),email);
            if(invalidRows.isEmpty())
            {
                model.addAttribute("success", "All records are saved");
                return getMilkSupplierList(session,1,10,model);
            }else{
                model.addAttribute("invalidRows",invalidRows);
                model.addAttribute("error",invalidRows.size()+" records are not saved");
            }
            log.info("File uploaded successfully to: {}", filePath.toAbsolutePath());
        } catch (Exception e) {
            log.error("Upload failed: " + e.getMessage());
            model.addAttribute("error", "Error saving file: " + e.getMessage());
        }
        controllerHelper.addNotificationData(model,email);
        return "SuppliersList";
    }

}
