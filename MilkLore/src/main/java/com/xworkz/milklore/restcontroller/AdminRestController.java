package com.xworkz.milklore.restcontroller;

import com.xworkz.milklore.dto.AdminDTO;
import com.xworkz.milklore.service.AdminService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;

@RestController
@RequestMapping("/")
@Api(value = "Admin management")
@Slf4j
public class AdminRestController {

    @Autowired
    private AdminService adminService;

    public AdminRestController()
    {
        log.info("AdminRestController constructor");
    }

    @PostMapping("/adminDetails")
    @ApiOperation(value = "Save admin data")
    public ResponseEntity<String> saveAdminDetails(@Valid @RequestBody AdminDTO adminDTO,
                                                   BindingResult bindingResult) {
        log.info("Admin saveAdminDetails method in rest controller");

        if(bindingResult.hasErrors()) {
            System.out.println("Error in fields");
            bindingResult.getFieldErrors()
                    .forEach(fieldError -> System.out.println(fieldError.getField()+"-> "+fieldError.getDefaultMessage()));
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Errors in fields");
        }
        if(adminService.save(adminDTO)) {
            return ResponseEntity.ok("Details saved");
        } else {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Invalid details");
        }
    }

    @GetMapping("/viewAdminByEmail")
    public boolean viewAdminByEmail(@RequestParam("email") String email) {
        log.info("Admin viewAdminByEmail method in rest controller");
        return true;
    }

    @GetMapping("/checkEmail")
    public boolean checkEmailByEmail(@RequestParam("email") String email) {
        log.info("Checking if email exists: {}", email);
        return adminService.viewAdminByEmail(email) != null;
    }

}
