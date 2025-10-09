package com.xworkz.milklore.controller;

import com.xworkz.milklore.dto.AdminDTO;
import com.xworkz.milklore.dto.SupplierDTO;
import com.xworkz.milklore.service.AdminService;
import com.xworkz.milklore.service.SupplierService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import java.util.List;

@Slf4j
@Controller
@RequestMapping("/")
public class SupplierController {

    @Autowired
    private AdminService adminService;

    @Autowired
    private SupplierService supplierService;

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
        return "SuppliersList";

    }

    @GetMapping("/redirectToSupplierLogin")
    public String supplierLoginPage() {
        log.info("Supplier Log IN Page");
        return "SupplierLogin";
    }

    @PostMapping("/supplierLogin")
    public String handleSupplierLogin(@RequestParam String email,
                                      @RequestParam(required = false) String otp,
                                      Model model) {

        System.out.println(email);
        if (otp == null || otp.isEmpty()) {
            // Send OTP
            boolean sent = supplierService.generateAndSendOtp(email);
            if (sent) {
                model.addAttribute("message", "OTP sent to your email. Please enter it below.");
            } else {
                model.addAttribute("message", "Failed to send OTP. Check your email.");
            }
            model.addAttribute("email", email);
            return "supplierLogin";
        } else {
            // Verify OTP
            boolean verified = supplierService.verifyOtp(email, otp);
            if (verified) {
                return "SupplierDashboard"; // success page
            } else {
                model.addAttribute("message", "Invalid or expired OTP. Try again.");
                model.addAttribute("email", email);
                return "supplierLogin";
            }
        }
    }
}
