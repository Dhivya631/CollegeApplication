package org.example.controller;


import org.example.entity.Admin;
import org.example.service.AdminService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class AdminController {
    private static final Logger logger= LoggerFactory.getLogger(AdminController.class);
    @Autowired
    private AdminService adminService;
    public static Admin adm;
    @GetMapping("/adminlogin")
    public String showAdminLoginForm() {
        return "admin";
    }
    @PostMapping("/adminlogin")
    public String adminLogin(@RequestParam String email, @RequestParam String password, Model model) {
        Admin admin = adminService.findByEmailAndPassword(email, password);
        logger.info("Admin Details:{}",admin);
        if (admin != null) {
            adm=admin;
            model.addAttribute("admin",admin);
            model.addAttribute("id", (Long)admin.getId());
            return "adminDashboard";
        } else {
            model.addAttribute("message", "Invalid email or password");
            return "admin";
        }
    }
    @GetMapping("/adminDash")
    public String adminDashReturn(Model model){
        model.addAttribute("admin" ,adm);
        return "adminDashboard";
    }
}
