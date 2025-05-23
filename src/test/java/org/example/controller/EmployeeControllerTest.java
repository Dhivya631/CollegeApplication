package org.example.controller;

import static org.assertj.core.api.AssertionsForClassTypes.assertThat;
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;
import java.util.ArrayList;
import java.util.List;
import org.example.entity.Course;
import org.example.entity.Department;
import org.example.entity.Employee;
import org.example.service.AdminService;
import org.example.service.CourseService;
import org.example.service.DepartmentService;
import org.example.service.EmployeeService;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.ui.Model;

@ExtendWith(MockitoExtension.class)
class EmployeeControllerTest {

    @Mock
    private DepartmentService departmentService;

    @Mock
    private CourseService courseService;
    @Mock
    private EmployeeService employeeService;
    @Mock
    private AdminService adminService;
    @Mock
    private Model model;

    @InjectMocks
    private EmployeeController employeeController;
    private Employee employee;
    private List<Course>courses;
    private  List<Department>departments;
    private List<Employee>employees;
    private Employee existingEmployee;
    private Employee updatedEmployee;
    @BeforeEach
    void setUp() {
        employee = new Employee();
        employee.setDepartment("Engineering");
    }

    @Test
    void testShowRegistrationForm() {
        when(departmentService.getAllDepartments()).thenReturn(new ArrayList<>());
        when(courseService.getAllCourses()).thenReturn(new ArrayList<>());
        Model model = mock(Model.class);
        String viewName = employeeController.showRegistrationForm(model);
        verify(model, times(1)).addAttribute("employee", new Employee());
        verify(model, times(1)).addAttribute("departments", new ArrayList<>());
        verify(model, times(1)).addAttribute("courses", new ArrayList<>());
        assertEquals("registerEmployee", viewName);
    }



    @Test
    void givenValidEmployeeAndDesignationHOD_whenRegisterEmployee_thenSuccess() {
        String designation = "HOD";
        when(employeeService.saveEmployee(any(Employee.class))).thenReturn(employee);
        when(employeeService.getEmployeeCount()).thenReturn(1L);
        when(departmentService.getIdByDeptName("Engineering")).thenReturn(1L);
        Department department = new Department();
        when(departmentService.getDepartmentById(1L)).thenReturn(department);
        String result = employeeController.registerEmployee(employee, designation);
        assertEquals("redirect:/employee/login", result);
        verify(departmentService, times(1)).save(any(Department.class));
    }

    @Test
    void givenValidEmployeeAndDesignationNonHOD_whenRegisterEmployee_thenSuccess() {
        String designation = "lecture";
        String result = employeeController.registerEmployee(employee, designation);
        assertEquals("redirect:/employee/login", result);
        verify(departmentService, times(0)).save(any(Department.class));
    }
    @Test
    void testShowLoginForm() {
        String viewName = employeeController.showLoginForm();
        assertEquals("loginEmployee", viewName);
    }
    @Test
    void testLogin_InvalidCredentials() {
        String email = "admin@gmail.com";
        String password = "wpass";
        when(employeeService.findByEmailAndPassword(email, password)).thenReturn(null);
        Model model = mock(Model.class);
        String viewName = employeeController.login(email, password, model);
        verify(employeeService, times(1)).findByEmailAndPassword(email, password);
        verify(model, times(1)).addAttribute("error", "Invalid email or password");
        assertEquals("loginEmployee", viewName);
    }
    @Test
    void givenValidParams_whenDisplayEmployees_thenSuccess() throws Exception {
        Long employeeid = 1L;
        Boolean isAdmin = true;

        when(employeeService.getAllEmployees()).thenReturn(employees);
        ObjectMapper objectMapper = new ObjectMapper();
        String employeeJson = objectMapper.writeValueAsString(employees);
        String result = employeeController.displayEmployees(employeeid, isAdmin, model);
        assertEquals("displayEmployee", result);
        verify(model, times(1)).addAttribute("isAdmin", isAdmin);
        verify(model, times(1)).addAttribute("employeeJson", employeeJson);
        verify(model, times(1)).addAttribute("employeeid", employeeid);
    }

    @Test
    void givenValidParams_whenDisplayEmployees_thenException() {
        Long employeeid = 1L;
        Boolean isAdmin = true;
        when(employeeService.getAllEmployees()).thenThrow(new RuntimeException("Database error"));
        Exception exception = assertThrows(RuntimeException.class, () -> {
            employeeController.displayEmployees(employeeid, isAdmin, model);
        });
        assertEquals("Database error", exception.getMessage());
        verify(model, times(0)).addAttribute(anyString(), any());
    }
    @Test
    void givenValidId_whenShowUpdateForm_thenSuccess() {
        long id = 1L;
        when(employeeService.getEmployeeById(id)).thenReturn(employee);
        when(courseService.getAllCourses()).thenReturn(courses);
        when(departmentService.getAllDepartments()).thenReturn(departments);
        String result = employeeController.showUpdateForm(id, model);
        assertEquals("updateEmployee", result);
        verify(model, times(1)).addAttribute("employee", employee);
        verify(model, times(1)).addAttribute("courses", courses);
        verify(model, times(1)).addAttribute("departments", departments);
    }

    @Test
    void givenInvalidId_whenShowUpdateForm_thenEmployeeNotFound() {
        long id = 99L;
        when(employeeService.getEmployeeById(id)).thenReturn(null);
        String result = employeeController.showUpdateForm(id, model);
        assertEquals("updateEmployee", result);
        verify(model, times(0)).addAttribute("employee", employee);
        verify(model, times(0)).addAttribute("courses", courses);
        verify(model, times(0)).addAttribute("departments", departments);
    }
    @Test
    void testDeleteEmployee_AsAdmin() {
        Long employeeId = 1L;
        when(adminService.fetchIsAdminStatus()).thenReturn(true);
        String viewName = employeeController.deleteEmployee(employeeId, model);
        verify(adminService, times(1)).fetchIsAdminStatus();
        verify(employeeService, times(1)).deleteEmployee(employeeId);
        verify(model, times(1)).addAttribute("isAdmin", true);
        assertThat(viewName).isEqualTo("displayEmployee");
    }

    @Test
    void testDeleteEmployee_NotAsAdmin() {
        Long employeeId = 1L;
        when(adminService.fetchIsAdminStatus()).thenReturn(false);
        String viewName = employeeController.deleteEmployee(employeeId, model);
        verify(adminService, times(1)).fetchIsAdminStatus();
        verify(employeeService, never()).deleteEmployee(anyLong());
        verify(model, times(1)).addAttribute("isAdmin", false);
        assertThat(viewName).isEqualTo("admin");
    }

    @Test
    void givenValidId_whenShowEmployeeDetails_thenSuccess() {
        long id = 1L;
        when(employeeService.getEmployeeById(id)).thenReturn(employee);
        String result = employeeController.showEmployeeDetails(id, model);
        assertEquals("employeeDashboard", result);
        verify(model, times(1)).addAttribute("employee", employee);
        verify(model, times(1)).addAttribute("id", id);
    }

}