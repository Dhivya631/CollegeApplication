package org.example.controller;

import org.example.entity.Department;
import org.example.entity.Student;
import org.example.service.AdminService;
import org.example.service.CourseService;
import org.example.service.DepartmentService;
import org.example.service.StudentService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
public class StudentController {
    private static final Logger logger= LoggerFactory.getLogger(StudentController.class);
    @Autowired
    private StudentService studentService;
    @Autowired
    private CourseService courseService;

    @Autowired
    private AdminService adminService;
    @Autowired
    private DepartmentService departmentService;

    public StudentController() {
        // default constructor
        //constructor is a block of code similar to a method. This is called when instance of object is created
    }

    @GetMapping("/register")
    public String showRegistrationForm(Model model) {
        model.addAttribute("student", new Student());
        model.addAttribute("departments",departmentService.getAllDepartments());
        return "register";
    }

    @PostMapping("/register")
    public String registerStudent(@ModelAttribute Student student, Model model) {
        logger.info("Registering student:{}", student);
        Student existingStudent = studentService.findStudentByUsernameAndEmail(student.getUsername(), student.getEmail());
        if (existingStudent != null) {
            model.addAttribute("error", "Student Exits with username and Email");
            model.addAttribute("departments", departmentService.getAllDepartments());
            return "register";
        } else {
            studentService.saveStudent(student);
            model.addAttribute("message", "Student Registration Successful");
            return "register";
        }
    }

    @GetMapping("/students")
    public String listStudents(@RequestParam("id")Long employeeid,@RequestParam("isAdmin")Boolean isAdmin, Model model) {
        logger.info("Fetching all students");
        List<Student> students = studentService.getAllStudents();
        model.addAttribute("students", students);
        model.addAttribute("isAdmin" ,isAdmin);
        model.addAttribute("employeeid" ,employeeid );
        logger.info("Fetched {} students", students.size());
        return "students";
    }
    @GetMapping("/students/{id}")
    public String getStudentById(@PathVariable Long id, Model model) {
        logger.info("Fetching student with ID: {}", id);
        Student student = studentService.getStudentById(id);
        List<Department> departments=departmentService.findAllDepartment();
        if (student != null) {
            model.addAttribute("student", student);
            model.addAttribute("departments",departments);
            logger.info("Found student: {}", student);
        } else {
            model.addAttribute("message", "Student not found");
            logger.warn("Student with ID {} not found", id);
        }
        return "student-details";
    }
    @GetMapping("/student-details")
    public String getStudentById(@RequestParam("id") long id, Model model) {
        logger.info("Fetching student with ID: {}", id);
        Student student = studentService.getStudentById(id);
        List<Department> departments=departmentService.findAllDepartment();
        if (student != null) {
            model.addAttribute("student", student);
            model.addAttribute("departments",departments);
            logger.info("Found student: {}", student);
        } else {
            model.addAttribute("message", "Student not found");
            logger.warn("Student with ID {} not found", id);
        }
        return "student-details";
    }
    @GetMapping("/login")
    public String showLoginForm() {
        logger.info("Entering to student login page");
        return "login";
    }
    @PostMapping("/login")
    public String login(@RequestParam String email, @RequestParam String password, Model model) {
        Student student = studentService.findByEmailAndPassword(email, password);
        if (student != null) {
            model.addAttribute("student",student);
            return "student-details";
        } else {
            model.addAttribute("error", "Invalid email or password");
            return "login";
        }
    }
    @GetMapping("/students/edit/{id}")
    public String showEditForm(@PathVariable Long id, Model model) {
        logger.info("Entering into student edit page: ");
        Student student = studentService.getStudentById(id);
        if(student!=null) {
            List<Department> departments = departmentService.findAllDepartment();
            model.addAttribute("student", student);
            model.addAttribute("departments", departments);
            return "editStudent";
        }
        else{
            model.addAttribute("error","Student not found");
            return "redirect:/students";
        }
    }
    @GetMapping("/students/delete/{id}")
    public String deleteStudent(@PathVariable Long id, Model model) {
        Boolean isAdmin=adminService.fetchIsAdminStatus();
        logger.info("Deleting student with ID: {}",id);
        model.addAttribute("isAdmin",isAdmin);
        if(isAdmin) {
            studentService.deleteStudent(id);
            logger.info("Deleted Student with ID: {}", id);
            return "students";
        }
        else{
            return "admin";
        }
    }
    @PostMapping("/students/edit/{id}")
    public String editStudent(@PathVariable Long id, @ModelAttribute Student student, Model model) {
        logger.info("Editing student with ID: {}",id);
        Student existingStudent = studentService.getStudentById(id);
        if(existingStudent!=null) {
            logger.info("Before updating student: {}",existingStudent);
            existingStudent.setName(student.getName());
            existingStudent.setEmail(student.getEmail());
            existingStudent.setUsername(student.getUsername());
            existingStudent.setPassword(student.getPassword());
            existingStudent.setDepartment(student.getDepartment());
            existingStudent.setSemester(student.getSemester());
            studentService.updateStudent(existingStudent);
            model.addAttribute("message", "Student details updated successfully");
            logger.info("updated Student: {}",existingStudent);
        }
        else{
            model.addAttribute("message","Student not found");
            logger.warn("Student with ID {} not found for update",id);
        }
        return "redirect:/student-details?id={id}";
    }
}
