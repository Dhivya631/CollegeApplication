package org.example.controller;

import org.example.entity.Course;
import org.example.entity.Department;
import org.example.service.AdminService;
import org.example.service.CourseService;
import org.example.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import java.util.*;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
@Controller
@RequestMapping("/courses")
public class CourseController {
    private static final Logger logger= LoggerFactory.getLogger(CourseController.class);
    @Autowired
    private CourseService courseService;
    @Autowired
    private DepartmentService departmentService;
    @Autowired
    private AdminService adminService;
    @GetMapping("/create")
    public String showCreateForm(Model model) {
        logger.debug("Entering showCreateForm");
        model.addAttribute("course", new Course());
        model.addAttribute("departments", departmentService.getAllDepartments());
        logger.debug("Exiting showCreateForm with departments: {}", departmentService.getAllDepartments());
        return "create";
    }

    @GetMapping
    public String listCourses(Model model) {
        model.addAttribute("courses", courseService.getAllCourses());
        return "list";
    }

    @PostMapping("/create")
    public String createCourse(@ModelAttribute Course course, @RequestParam("departmentId") Long departmentId) {
        Department department = departmentService.getDepartmentById(departmentId);
        course.setDepartment(department);
        List<Course> existingCourses = courseService.getCoursesByName(course.getName());
        if (existingCourses != null && !existingCourses.isEmpty()) {
            Long existingId = existingCourses.get(0).getId();
            course.setId(existingId);
        } else {
            Long newId = courseService.getNextCourseId();
            course.setId(newId);
        }
        courseService.createCourse(course);
        return "redirect:/courses/create";
    }
    @GetMapping("/display")
    public String displayCourse(@RequestParam("id")Long employeeid,@RequestParam("isAdmin")Boolean isAdmin,Model model){
        logger.info("Displaying courses");
        List<Course> courses=courseService.getAllUniqueCourses();
        model.addAttribute("isAdmin" ,isAdmin);
        model.addAttribute("courses", courses);
        model.addAttribute("employeeid" ,employeeid );
        logger.info("Displayed course details:{}",courses);
        return "courseDisplay";
    }
    @GetMapping("/edit/{rno}")
    public String showEditForm(@PathVariable("rno") Long rno, Model model) {
        logger.debug("Entering showEditForm with course ID: "+rno);
        Course course=courseService.getCourseById(rno);
        if(course==null){
            logger.error("Course with ID "+rno+" not found");
        }
        else{
            logger.debug("Course retrieved: "+course);
        }
        List<Department> departments=departmentService.getAllDepartments();
        model.addAttribute("course",course);
        model.addAttribute("departments",departments);
        logger.debug("Exiting showEditForm with course: {}", course);
        return "editCourse";
    }
    @PostMapping("/edit/{id}")
    public String editCourse(@PathVariable("id") Long courseId, @ModelAttribute Course course, BindingResult result, @RequestParam("departmentId") Long departmentId, Model model) {
        //BindingResult - holds the result of validation and binding and contains an error
        logger.debug("Entering editCourse with course: {} and department ID: {}", course, departmentId);
        if(result.hasErrors()){
            model.addAttribute("departments",departmentService.getAllDepartments());
            return "editCourse";
        }
        try {
            Course existingCourse=courseService.getCourseById(courseId);
            logger.info("Before updating the course: {}",existingCourse);
            Department department = departmentService.getDepartmentById(departmentId);
            existingCourse.setDepartment(department);
            existingCourse.setName(course.getName());
            existingCourse.setDescription(course.getDescription());
            existingCourse.setCredit(course.getCredit());
            courseService.updateCourse(existingCourse);
            logger.debug("Course updated successfully: {}", existingCourse);
            return "redirect:/courses/display";
        }
        catch (Exception e){
            logger.error("Error updating course: {}",course,e);
            return "error";
        }
    }
    @GetMapping("/delete/{id}")
    public String deleteCourse(@PathVariable Long id,Model model) {
        Boolean isAdmin=adminService.fetchIsAdminStatus();
        logger.info("Deleting course with ID:{}",id);
        if(isAdmin) {
            model.addAttribute("isAdmin", isAdmin);
            courseService.deleteCourse(id);
            logger.info("Deleted successfully");
            return "courseDisplay";
        }
        else{
            return "admin";
        }
    }
}