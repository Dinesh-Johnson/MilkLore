package com.xworkz.milklore.controller;


import com.xworkz.milklore.service.*;
import com.xworkz.milklore.utill.CommonControllerHelper;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;

import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
public class SupplierControllerTest {

    private MockMvc mockMvc;

    @InjectMocks
    SupplierController controller;

    @Mock
    private AdminService adminService;

    @Mock
    private SupplierService supplierService;

    @Mock
    private CommonControllerHelper controllerHelper;

    @Value("${file.upload-dir}")
    private String uploadDir;

    @Value("${supplier-upload.path}")
    private String uploadPath;

    @Mock
    private MilkProductReceiveService collectMilkService;

    @Mock
    private NotificationService paymentNotificationService;

    @Mock
    private SupplierImportService supplierImportService;

    @BeforeEach
    void setup(){
        mockMvc = MockMvcBuilders.standaloneSetup(controller).build();
    }

//    @Test
//    void redirect_to_milkCollectionList()throws  Exception{
//        when(supplierService)
//    }


}
