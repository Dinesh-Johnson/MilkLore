package com.xworkz.milklore.controller;

import com.xworkz.milklore.service.AdminService;
import com.xworkz.milklore.service.MilkProductReceiveService;
import com.xworkz.milklore.service.NotificationService;
import com.xworkz.milklore.service.SupplierService;
import com.xworkz.milklore.utill.CommonControllerHelper;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;

import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.Mockito.when;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@ExtendWith(MockitoExtension.class)
class AdminControllerTest {

    private MockMvc mockMvc;

    @InjectMocks
    private AdminController controller;

    @Mock
    private AdminService service;

    @Mock
    private NotificationService notificationService;

    @Mock
    private SupplierService supplierService;

    @Mock
    private CommonControllerHelper controllerHelper;

    @Mock
    private MilkProductReceiveService collectMilkService;

    @Mock
    private AppController appController;

    @BeforeEach
    void setup() {
        mockMvc = MockMvcBuilders.standaloneSetup(controller).build();
    }

    @Test
    void adminLogin_whenAccountNotPresent_returnsAdminLoginWithError() throws Exception {
        when(service.getPasswordByEmail(anyString(), anyString())).thenReturn(null);

        // act & assert: POST /adminLogin should return view "AdminLogin" and set errorMessage
        mockMvc.perform(post("/adminLogin")
                        .param("email", "notfound@example.com")
                        .param("password", "badpass"))
                .andExpect(status().isOk())
                .andExpect(view().name("AdminLogin"))
                .andExpect(model().attributeExists("errorMessage"));
    }
}