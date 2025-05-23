package org.example.controller;

import org.example.service.CourseService;
import org.example.service.DepartmentService;
import org.example.service.EmployeeService;
import org.example.service.StudentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class CountController {

    @Autowired
    private StudentService studentService;
    @Autowired
    private EmployeeService employeeService;
    @Autowired
    private CourseService courseService;
    @Autowired
    private DepartmentService departmentService;
    @GetMapping("/homedisplay")
    public String showCarousel(Model model) {
        model.addAttribute("studentsCount", studentService.getStudentCount());
        model.addAttribute("employeeCount", employeeService.getEmployeeCount());
        model.addAttribute("coursesCount", courseService.getCourseCount());
        model.addAttribute("departmentsCount", departmentService.getDepartmentCount());
        return "home";
    }
}