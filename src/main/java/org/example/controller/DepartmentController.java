package org.example.controller;

import org.example.entity.Department;
import org.example.service.AdminService;
import org.example.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/departments")
public class DepartmentController{
    private static final Logger logger=LoggerFactory.getLogger(DepartmentController.class);
    @Autowired
    private DepartmentService departmentService;

    @Autowired
    private AdminService adminService;

    @GetMapping
    public String getAllDepartments(Model model) {
        logger.info("Fetching all departments");
        List<Department> departments = departmentService.getAllDepartments();
        model.addAttribute("departments", departments);
        return "createDepartment";
    }

    @GetMapping("/{id}")
    public String getDepartmentById(@PathVariable Long id, Model model) {
        logger.info("Fetching Department with ID: "+id);
        Department department = departmentService.getDepartmentById(id);
        if (department != null) {
            model.addAttribute("department", department);
            logger.info("Department Found: {}",department.getName());
            return "index";//department
        } else {
            String errorMessage="Department not found with ID: "+id;
            model.addAttribute("error","Department is not found with ID: "+id);
            logger.error(errorMessage);
            return "not-found";
        }
    }

    @GetMapping("/create")
    public String showCreateForm(@RequestParam(required = false) String message,Model model) {
        logger.info("Displaying Create department form");
        model.addAttribute("department", new Department());
        model.addAttribute("message",message);
        return "createDepartment";
    }
    @PostMapping
    public String createDepartment(@ModelAttribute Department department, Model model, RedirectAttributes redirectAttributes) {
        logger.info("Creating new department: {}",department);
        try {
            if (department != null && department.getName() != null) {
                Department createdDepartment = departmentService.createDepartment(department);
                if (createdDepartment != null) {
                    logger.info("Department created Successfully with ID: {} ", createdDepartment.getId());
                    redirectAttributes.addAttribute("message", "Department created Successfully with ID: " + createdDepartment.getId());
                    return "redirect:/departments/create";
                }
            }
        }
        catch(Exception e) {
            String errorMessage = "Failed to create department, Department Already exists!";
            redirectAttributes.addAttribute("message", errorMessage);
            logger.error(errorMessage);
            return "redirect:/departments/create";
        }
        return "redirect:/departments/create";
    }
    @GetMapping("/display")
    public String displayDept(@RequestParam(name="id")Long employeeid,@RequestParam(name="isAdmin")Boolean isAdmin,Model model){
        List<Department> departments = departmentService.getAllDepartments();
        if(isAdmin!=null) {
            model.addAttribute("isAdmin", isAdmin);
        }
        model.addAttribute("departments", departments);
        if(employeeid!=null) {
            model.addAttribute("employeeid", employeeid);
        }
        return "displayDepartment";
    }
    @GetMapping("/edit/{id}")
    public String showEditForm(@PathVariable Long id, Model model) {
        logger.info("Editing department with ID: {}", id);
        model.addAttribute("department",departmentService.findById(id));
        return "editDepartment";
    }

    @PostMapping("/edit/{id}")
    public String updateDepartment(@PathVariable("id") Long id,@ModelAttribute("departments") Department department){
        logger.info("Received request to update department with ID: {}", id);
        Department existingDepartment = departmentService.findById(id);
        if (existingDepartment != null) {
            logger.debug("Department details before update: {}", existingDepartment);
        } else {
            logger.warn("No department found with ID:{}", id);
        }
        departmentService.updateDepartment(id, department);
        logger.info("Department updated successfully with ID:{} and updated department details:{}", id, department);
        return "redirect:/departments/display";
    }
    @GetMapping("/delete/{id}")
    public String deleteDepartment(@PathVariable Long id,Model model) {
        Boolean isAdmin=adminService.fetchIsAdminStatus();
        logger.info("Deleting department with ID:{}",id);
        model.addAttribute("isAdmin",isAdmin);
        if(isAdmin) {
            departmentService.deleteDepartment(id);
            logger.info("Deleted department successfully");
            return "displayDepartment";
        }
        else{
            return "admin";
        }
    }
    @GetMapping("/cse")
    public String getCseDepartment(Model model){
        model.addAttribute("departmentDetails", "Computer Science and Engineering Details");
        return "cse";
    }
    @GetMapping("/eee")
    public String getEeeDepartment(Model model){
        model.addAttribute("departmentDetails", "Electrical and Electronics Engineering Details");
        return "eee";
    }
    @GetMapping("/ece")
    public String getEceDepartment(Model model){
        model.addAttribute("departmentDetails", "Electrical and Communication Engineering Details");
        return "ece";
    }
    @GetMapping("/it")
    public String getItDepartment(Model model){
        model.addAttribute("departmentDetails", "Information Technology Engineering Details");
        return "it";
    }
    @GetMapping("/civil")
    public String getCivilDepartment(Model model){
        model.addAttribute("departmentDetails", "Civil Enginneering Details");
        return "civil";
    }
    @GetMapping("/auto")
    public String getAutoDepartment(Model model){
        model.addAttribute("departmentDetails", "Auto Enginneering Details");
        return "auto";
    }
    @GetMapping("/mech")
    public String getMechDepartment(Model model){
        model.addAttribute("departmentDetails", "Mechanical Enginneering Details");
        return "mech";
    }
}