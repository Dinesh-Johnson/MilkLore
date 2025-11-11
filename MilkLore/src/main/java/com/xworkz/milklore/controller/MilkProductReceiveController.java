package com.xworkz.milklore.controller;

import com.xworkz.milklore.dto.AdminDTO;
import com.xworkz.milklore.dto.MilkProductReceiveDTO;
import com.xworkz.milklore.service.AdminService;
import com.xworkz.milklore.service.MilkProductReceiveService;
import com.xworkz.milklore.utill.CommonControllerHelper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;


@Slf4j
@Controller
@RequestMapping("/")
public class MilkProductReceiveController {

    @Autowired
    private AdminService adminService;

    @Autowired
    private MilkProductReceiveService collectMilkService;

    @Autowired
    private CommonControllerHelper controllerHelper;

    public MilkProductReceiveController()
    {
        log.info("CollectMilkController constructor");
    }

    @GetMapping("/redirectToCollectMilk")
    public String getCollectMilkPage(@RequestParam String email, Model model){
        log.info("getCollectMilkPage in CollectMilkController");
        AdminDTO adminDTO=adminService.viewAdminByEmail(email);
        model.addAttribute("dto",adminDTO);
        controllerHelper.addNotificationData(model,email);
        return "CollectMilk";
    }

    @GetMapping("/redirectToGetCollectMilkList")
    public String redirectToGetCollectMilkList(@RequestParam String email, Model model){
        log.info("redirectToGetCollectMilkList in CollectMilkController");
        AdminDTO adminDTO=adminService.viewAdminByEmail(email);
        model.addAttribute("dto",adminDTO);
        return "ProductReceive";
    }

    @PostMapping("addCollectMilk")
    public String getCollectedMilk(@Valid MilkProductReceiveDTO collectMilkDTO,
                                   BindingResult bindingResult,
                                   @RequestParam String email, Model model)
    {
        log.info("===== Inside addCollectMilk POST method =====");
        if(bindingResult.hasErrors())
        {
            log.error("Fields has error");
            bindingResult.getFieldErrors().stream().map(e->e.getField()+" -> "+e.getDefaultMessage())
                    .forEach(log::error);
            model.addAttribute("error","Wrong details");
            model.addAttribute("milk",collectMilkDTO);
            return getCollectMilkPage(email,model);
        }
        if(collectMilkService.save(collectMilkDTO,email))
        {
            log.info("successfully saved");
            model.addAttribute("success","Details saved");
        }else {
            log.info("Not saved");
            model.addAttribute("error","Details not saved");
            model.addAttribute("milk",collectMilkDTO);
        }
        controllerHelper.addNotificationData(model,email);
        AdminDTO adminDTO=adminService.viewAdminByEmail(email);
        model.addAttribute("dto",adminDTO);
        return "ProductReceive";
    }

    @GetMapping("/getCollectMilkList")
    public String getCollectMilkList(
            @RequestParam(value = "collectedDate", required = false)
            @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate collectedDate,
            @RequestParam String email,
            Model model) {

        log.info("getCollectMilkList called with collectedDate={}", collectedDate);

        List<MilkProductReceiveDTO> collectMilkList = new ArrayList<>();

        if (collectedDate != null) {
            collectMilkList = collectMilkService.getAllDetailsByDate(collectedDate);
        }

        AdminDTO adminDTO = adminService.viewAdminByEmail(email);
        model.addAttribute("dto", adminDTO);
        controllerHelper.addNotificationData(model, email);

        model.addAttribute("collectMilkList", collectMilkList);
        return "ProductReceive";
    }


    @GetMapping("/getCollectMilkListBySupplierEmail")
    public String getCollectMilkListBySupplierEmail(@RequestParam String email, Model model) {
        log.info("Fetching milk collection for email={}", email);
        List<MilkProductReceiveDTO> collectMilkList = collectMilkService.getAllDetailsBySupplierEmail(email);
        collectMilkList.forEach(System.out::println);
        log.info("Service returned {} records", collectMilkList.size());
        model.addAttribute("collectMilkList", collectMilkList);
        controllerHelper.addNotificationData(model,email);
        AdminDTO adminDTO=adminService.viewAdminByEmail(email);
        model.addAttribute("dto",adminDTO);
        return "ViewProductReceive";
    }


    @GetMapping("/redirectToExportAllMilkCollectData")
    public void exportAllMilkCollectData(HttpServletResponse response)
    {
        log.info("exportAllMilkCollectData method in collect milk controller");
        collectMilkService.exportAllMilkCollectData(response);
    }

}
