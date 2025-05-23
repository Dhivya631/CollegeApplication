package org.example.controller;

import org.example.entity.*;
import org.example.repository.CourseRepository;
import org.example.repository.SemesterRepository;
import org.example.service.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.*;

@Controller
public class ControllerMain {

    private static final Logger logger=LoggerFactory.getLogger(ControllerMain.class);

    @Autowired
    private DepartmentService departmentService;

    @Autowired
    private StudentService studentService;
    @Autowired
    private CourseService courseService;

    @Autowired
    private SemesterService semesterService;

    @Autowired
    private SemesterRepository semesterRepository;

    @Autowired
    private EmployeeService employeeService;

    @Autowired
    private CourseSemesterService courseSemesterService;

    @Autowired
    private CourseRepository courseRepository;

    @GetMapping("/displayStudentsByDept")
    public String displayStudentByDep(Model model){
        model.addAttribute("departments", departmentService.getAllDepartments());
        return "displayStudentsByDeptIP";
    }

    @PostMapping("/displayStudentsByDept")
    public String displayStudentByDept(@RequestParam("departmentId") Long departmentId, Model model){
//        model.addAttribute("students", studentService.getAllStudents());
        Department department = departmentService.getDepartmentById(departmentId);
        model.addAttribute("departmentName",department.getName());
        return "displayStudentsByDeptOP";
    }

    @GetMapping("/displayStaffsByDept")
    public String displayStaffsByDep(Model model){
//        model.addAttribute("course", new Course());
        model.addAttribute("departments", departmentService.getAllDepartments());
        return "displayStaffsByDeptIP";
    }

    @PostMapping("/displayStaffsByDept")
    public String displayStaffsByDept(@RequestParam("departmentId") Long departmentId, Model model){
//        model.addAttribute("staffs", employeeService.getAllEmployees());
        Department department = departmentService.getDepartmentById(departmentId);
        model.addAttribute("departmentName",department.getName());
        return "displayStaffsByDeptOP";
    }
    @PostMapping("/setDesignation")
    public String setDesignation(@RequestParam("id") long id, @RequestParam("designation") String designation, Model model){
        Employee employee = employeeService.getEmployeeById(id);
        System.out.println(designation);
        employee.setDesignation(designation);
        employeeService.saveEmployee(employee);
        return "redirect:/employee/display";
    }
    @GetMapping("/addSemester")
    public String addSemester(@RequestParam(value = "departmentId",required = false) Long departmentId,Model model){
        logger.info("Received request to add semester with departmentId:{}",departmentId);
        if (departmentId != null) {
            logger.debug("Fetching courses for departmentId:{}",departmentId);
            model.addAttribute("courses",courseService.findCoursesByDepartmentId(departmentId));
        }
        else{
            logger.debug("Fetching all courses");
            model.addAttribute("courses",courseService.getAllCourses());
        }

        model.addAttribute("semester",new Semester());
        return "addSemester";
    }
    @PostMapping("/addSemester/{departmentId}")
    public String addSemesterPost(@RequestParam("courseIds") List<Long> courseIds,
                                  @RequestParam("semesterName") String semesterName,@PathVariable("departmentId") Long departmentId, Model model) {

        logger.info("Received Post request to add semester with department:{}",departmentId);
        List<Long> existingCourses = courseService.getAvailableCourseIds(semesterName, departmentId, courseIds);
        if(!existingCourses.isEmpty()){
            logger.info("Some Courses already exits for departmentsID:{} and semesterName:{}",departmentId,semesterName);
            List<String> courseNames = new ArrayList<>();
            for(Long existingCourseId : existingCourses) {
                logger.debug("Existing with courseID:{}",departmentId);
                System.out.println(existingCourseId+"/n");
                Course course = courseRepository.findCourseById(existingCourseId);

                String cname = course.getName();
                courseNames.add(cname);

            }
            model.addAttribute("message","The following course already exist for the given department and semester: "+String.join(", ",courseNames+""));
        }
        else {
            model.addAttribute("message","Course Added Successfully!.");
            Department department=departmentService.getDepartmentById(departmentId);
            semesterService.addDetails(departmentId,semesterName);
            Long semId = semesterService.getId();
            for (Long courseId : courseIds){
                CourseSemester courseSemester=new CourseSemester();
                courseSemester.setCourse_id(courseId);
                courseSemester.setSemester_id(semId);
                courseSemesterService.save(courseSemester);
            }
        }
        return "addSemester";

    }

    @GetMapping("/semesters")
    public String listSemesters(Model model){
        logger.info("Received request to list all semesters");
        model.addAttribute("semesters",semesterService.findAllSemesters());
        return "semesters";
    }

    @GetMapping("/displayCoursesBySemester")
    public String displayCoursesBySemester(Model model){
        logger.info("Received request to display courses by semester");
        model.addAttribute("departments",departmentService.getAllDepartments());
        model.addAttribute("semesters",semesterService.getAllSemesters());
        model.addAttribute("semcourses",courseSemesterService.getAllDetails());
        return "displayCoursesBySemesterIP";

    }
    @GetMapping("/displayAllSemesterCourses")
    public String displayAllSemesterCourses(Model model){
        logger.info("Received request to display all courses by semester");
        return "displayAllSemesterCourses";
    }
    @GetMapping("/displayStudentsBySemester")
    public String displayStudentBySemester(Model model){
        logger.info("Received request to display student by semester");
        return "displayStudentsBySemesterIP";
    }

    @PostMapping("/displayStudentsBySemester")
    public String displayStudentBySem(@RequestParam("semesterName") String semesterName,Model model){
        model.addAttribute("semesterName" ,semesterName);
        return "displayStudentsBySemesterOP";
    }

}