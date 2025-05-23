package org.example.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import org.example.entity.Course;
import org.example.entity.Department;
import org.example.entity.Employee;
import org.example.service.AdminService;
import org.example.service.CourseService;
import org.example.service.DepartmentService;
import org.example.service.EmployeeService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/employee")
public class EmployeeController {
    private static final Logger logger= LoggerFactory.getLogger(EmployeeController.class);
    @Autowired
    private EmployeeService employeeService;

    @Autowired
    private CourseService courseService;

    @Autowired
    private AdminService adminService;
    @Autowired
    private DepartmentService departmentService;

    @GetMapping("/register")
    public String showRegistrationForm(Model model){
        model.addAttribute("employee",new Employee());
        model.addAttribute("departments",departmentService.getAllDepartments());
        model.addAttribute("courses",courseService.getAllCourses());
        return "registerEmployee";
    }

    @PostMapping("/register")
    public String registerEmployee(@ModelAttribute Employee employee,@RequestParam("designation") String designation){

        employeeService.saveEmployee(employee);

        Long eid = employeeService.getEmployeeCount()+1;
        if(designation.equals("HOD")){
            String departmentName = employee.getDepartment();
            Long departmentId = departmentService.getIdByDeptName(departmentName);
            Department department = departmentService.getDepartmentById(departmentId);
            System.out.println("\n\n\n\n"+employee.getEmployeeid()+"\n\n");
            department.setHod(eid+"");
            departmentService.save(department);
        }
        return "redirect:/employee/login";
    }

    @GetMapping("/login")
    public String showLoginForm(){
        logger.info("Entering to employee login page");
        return "loginEmployee";
    }
    @PostMapping("/login")
    public String login(@RequestParam String email, @RequestParam String password, Model model) {
        Employee employee = employeeService.findByEmailAndPassword(email, password);
        if (employee != null) {
            model.addAttribute("employee", employee);
            model.addAttribute("id" , (long)employee.getEmployeeid() );
            return "employeeDashboard";
        } else {
            model.addAttribute("error", "Invalid email or password");
            return "loginEmployee";
        }
    }

    @GetMapping("/display")
    public String displayEmployees(@RequestParam("id")Long employeeid,@RequestParam("isAdmin")Boolean isAdmin,Model model){
        List<Employee> employees = employeeService.getAllEmployees();
        try{
            ObjectMapper objectMapper = new ObjectMapper();
            String employeeJson = objectMapper.writeValueAsString(employees);
            model.addAttribute("isAdmin" ,isAdmin);
            model.addAttribute("employeeJson", employeeJson);
            model.addAttribute("employeeid" ,employeeid );
        }catch(Exception e){
            e.printStackTrace();
        }
        return "displayEmployee";
    }

    @GetMapping("/update/{id}")
    public String showUpdateForm(@PathVariable("id") long id, Model model)
    {

        logger.info("Entering into Employee update page");
        Employee employee = employeeService.getEmployeeById(id);
        List<Course> courses=courseService.getAllCourses();
        List<Department> departments=departmentService.getAllDepartments();
        model.addAttribute("employee", employee);
        model.addAttribute("courses",courses);
        model.addAttribute("departments",departments);
        return "updateEmployee";

    }

    // Update employee
    @PostMapping("/update/{id}")
    public String updateEmployee(@PathVariable("id") Long id, @ModelAttribute Employee employee, Model model)
    {
        Employee existingEmployee = employeeService.getEmployeeById(id);
        existingEmployee.setName(employee.getName());
        existingEmployee.setUsername(employee.getUsername());
        existingEmployee.setAge(employee.getAge());
        existingEmployee.setEmail(employee.getEmail());
        existingEmployee.setPhoneno(employee.getPhoneno());
        existingEmployee.setCourse(employee.getCourse());
        existingEmployee.setDepartment(employee.getDepartment());
        existingEmployee.setPassword(employee.getPassword());
        existingEmployee.setDesignation(employee.getDesignation());
        employeeService.saveEmployee(existingEmployee);
        model.addAttribute("message", "Staff details updated successfully");
        String designation = existingEmployee.getDesignation();
        if(designation.equals("HOD")){
            String departmentName = existingEmployee.getDepartment();
            Long departmentId = departmentService.getIdByDeptName(departmentName);
            Department department = departmentService.getDepartmentById(departmentId);
//            System.out.println("\n\n\n\n"+existingEmployee.getEmployeeid()+"\n\n");
            department.setHod(id+"");
            departmentService.save(department);
        }
        return "redirect:/employee/employeeDashboard?id={id}";
    }

    @GetMapping("/delete/{id}")
    public String deleteEmployee(@PathVariable Long id, Model model) {
        Boolean isAdmin=adminService.fetchIsAdminStatus();
        logger.info("Deleting employee with ID: {}",id);
        model.addAttribute("isAdmin",isAdmin);
        if(isAdmin) {
            employeeService.deleteEmployee(id);
            logger.info("Deleted Employee with ID: {}", id);
            return "displayEmployee";
        }
        else{
            return "admin";
        }
    }
    @GetMapping("/employeeDashboard")
    public String showEmployeeDetails(@RequestParam("id") long id, Model model)
    {
        Employee employee = employeeService.getEmployeeById(id);
        model.addAttribute("employee", employee);
        model.addAttribute("id" ,id );
        return "employeeDashboard";
    }

}