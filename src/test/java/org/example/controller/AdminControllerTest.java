package org.example.controller;

import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.Mockito.when;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.model;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.view;

import org.example.entity.Admin;
import org.example.service.AdminService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
class AdminControllerTest {

    private MockMvc mockMvc;

    @Mock
    private AdminService adminService;

    @InjectMocks
    private AdminController adminController;

    @BeforeEach
    public void setUp() {
        MockitoAnnotations.openMocks(this);//initialise mock that can be annotated with mockito annotation
        mockMvc = MockMvcBuilders.standaloneSetup(adminController).build();
        //mockMvc - simulate HTTP requests to the controller endpoints

        //MockMvcBuilders.standaloneSetup(adminController) - create a standalone setup for testing the specified controller(adminController) without loading the full application context
        //    ->this approach is faster and isolates the controller for unit testing

        //build() -> finalize the setup and return a mockMvc that can be used to perform Http request and validate response
    }

    @Test
    void testShowAdminloginForm() throws Exception {
        mockMvc.perform(get("/adminlogin"))
                .andExpect(status().isOk())
                .andExpect(view().name("admin"));
    }

    @Test
    void testAdminLogin_Success() throws Exception {
        Admin mockAdmin = new Admin();
        when(adminService.findByEmailAndPassword(anyString(), anyString())).thenReturn(mockAdmin);

        mockMvc.perform(post("/adminlogin")
                        .param("email", "admin@gmail.com")
                        .param("password", "password"))
                .andExpect(status().isOk())
                .andExpect(model().attribute("admin", mockAdmin))
                .andExpect(model().attribute("id", mockAdmin.getId()))
                .andExpect(view().name("adminDashboard"));
    }

    @Test
    void testAdminLogin_Failure() throws Exception {
        when(adminService.findByEmailAndPassword(anyString(), anyString())).thenReturn(null);
        mockMvc.perform(post("/adminlogin")
                        .param("email", "admin@gmail.com")
                        .param("password", "wrongpassword"))
                .andExpect(status().isOk())
                .andExpect(model().attribute("message", "Invalid email or password"))
                .andExpect(view().name("admin"));
    }

    @Test
    void testAdminDashReturn() throws Exception {
        mockMvc.perform(get("/adminDash"))
                .andExpect(status().isOk())
                .andExpect(view().name("adminDashboard"));
    }
}