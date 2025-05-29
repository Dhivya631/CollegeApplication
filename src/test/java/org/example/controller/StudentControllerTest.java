package org.example.controller;

import org.example.entity.Department;
import org.example.entity.Student;
import org.example.service.AdminService;
import org.example.service.DepartmentService;
import org.example.service.StudentService;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.ui.Model;

import java.util.Arrays;
import java.util.List;

import static org.assertj.core.api.Assertions.assertThat;
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class StudentControllerTest {

    @Mock
    private StudentService studentService;

    @Mock
    private DepartmentService departmentService;
    @Mock
    private Model model;

    @Mock
    private AdminService adminService;

    @InjectMocks
    private StudentController studentController;


    @Test
    void testRegisterStudent_Success() {
        Student student = new Student();
        student.setUsername("Anu");
        student.setEmail("anu@gmail.com");

        when(studentService.findStudentByUsernameAndEmail(any(), any())).thenReturn(null);
        String viewName = studentController.registerStudent(student, mock(Model.class));
        verify(studentService, times(1)).saveStudent(student);
        assertEquals("register", viewName); // Assuming this is the name of your view template
    }

    @Test
    void testRegisterStudent_StudentAlreadyExists() {
        Student existingStudent = new Student();
        existingStudent.setUsername("Admin");
        existingStudent.setEmail("admin@gmail.com");

        Student student = new Student();
        student.setUsername("Admint"); // Same name as existing student
        student.setEmail("admin@gmail.com"); // Same email as existing student
        when(studentService.findStudentByUsernameAndEmail(any(), any())).thenReturn(existingStudent);
        Model model = mock(Model.class);
        String viewName = studentController.registerStudent(student, model);
        verify(studentService, never()).saveStudent(student);
//        verify(model, times(1)).addAttribute(eq("studentExists"), eq(true));
        assertEquals("register", viewName); // Assuming this is the name of your view template
    }
    @Test
    void testListStudents() {
        Long employeeId = 123L;
        Boolean isAdmin = true;
        List<Student> students = Arrays.asList(new Student(), new Student());

        when(studentService.getAllStudents()).thenReturn(students);

        Model model = mock(Model.class);
        String viewName = studentController.listStudents(employeeId, isAdmin, model);

        verify(studentService, times(1)).getAllStudents();
        assertEquals("students", viewName);
    }

    @Test
    void testListStudents_Exception() {
        Long employeeId = 123L;
        Boolean isAdmin = true;
        when(studentService.getAllStudents()).thenThrow(new RuntimeException("Service exception"));
        Model model = mock(Model.class);
        String viewName = null;
        try {
            viewName = studentController.listStudents(employeeId, isAdmin, model);
        } catch (RuntimeException e) {
            assertEquals("Service exception", e.getMessage());
        }
        verify(model, never()).addAttribute(anyString(), any());
    }
    @Test
    void testGetStudentById_StudentFound() {
        Long studentId = 1L;
        Student student = new Student();
        List<Department> departments = Arrays.asList(new Department(), new Department());

        when(studentService.getStudentById(studentId)).thenReturn(student);
        when(departmentService.findAllDepartment()).thenReturn(departments);
        Model model = mock(Model.class);
        String viewName = studentController.getStudentById(studentId, model);
        verify(studentService, times(1)).getStudentById(studentId);
        verify(departmentService, times(1)).findAllDepartment();
        verify(model, times(1)).addAttribute("student", student);
        verify(model, times(1)).addAttribute("departments", departments);
        assertEquals("student-details", viewName);
    }
    @Test
    void testGetStudentById_StudentNotFound() {
        Long studentId = 1L;
        when(studentService.getStudentById(studentId)).thenReturn(null);
        when(departmentService.findAllDepartment()).thenReturn(List.of());
        Model model = mock(Model.class);
        String viewName = studentController.getStudentById(studentId, model);
        verify(studentService, times(1)).getStudentById(studentId);
        verify(departmentService, times(1)).findAllDepartment();
        verify(model, times(1)).addAttribute("message", "Student not found");
        assertEquals("student-details", viewName);
    }
    @Test
    void testshowloginForm(){
        String viewName=studentController.showLoginForm();
        assertEquals("login",viewName);
    }
    @Test
    void testLogin_ValidCredentials() {
        // Given
        String email = "admin@gmail.com";
        String password = "admin";
        Student student = new Student();

        when(studentService.findByEmailAndPassword(email, password)).thenReturn(student);
        Model model = mock(Model.class);
        String viewName = studentController.login(email, password, model);
        verify(studentService, times(1)).findByEmailAndPassword(email, password);
        verify(model, times(1)).addAttribute("student", student);
        assertEquals("student-details", viewName); // Assuming "student-details" is the view name
    }
    @Test
    void testLogin_InvalidCredentials() {
        String email = "admin@gmail.com.com";
        String password = "adpass";
        when(studentService.findByEmailAndPassword(email, password)).thenReturn(null);
        Model model = mock(Model.class);
        String viewName = studentController.login(email, password, model);
        verify(studentService, times(1)).findByEmailAndPassword(email, password);
        verify(model, times(1)).addAttribute("error", "Invalid email or password");
        assertEquals("login", viewName);
    }
    @Test
    void testShowEditForm_StudentFound() {
        Long studentId = 1L;
        Student student = new Student();
        List<Department> departments = Arrays.asList(new Department(), new Department());

        when(studentService.getStudentById(studentId)).thenReturn(student);
        when(departmentService.findAllDepartment()).thenReturn(departments);
        Model model = mock(Model.class);
        String viewName = studentController.showEditForm(studentId, model);
        verify(studentService, times(1)).getStudentById(studentId);
        verify(departmentService, times(1)).findAllDepartment();
        verify(model, times(1)).addAttribute("student", student);
        verify(model, times(1)).addAttribute("departments", departments);
        assertEquals("editStudent", viewName);
    }
    @Test
    void testShowEditForm_StudentNotFound() {
        Long studentId = 1L;

        when(studentService.getStudentById(studentId)).thenReturn(null);
        Model model = mock(Model.class);
        String viewName = studentController.showEditForm(studentId, model);
        verify(studentService, times(1)).getStudentById(studentId);
        verify(model, times(1)).addAttribute("error", "Student not found");
        assertEquals("redirect:/students", viewName);
    }
    @Test
    void givenAdmin_whenDeleteStudent_thenSuccess() {
        // Given
        Long id = 1L;
        when(adminService.fetchIsAdminStatus()).thenReturn(true);

        // When
        String result = studentController.deleteStudent(id, model);

        // Then
        assertEquals("students", result);
        verify(model, times(1)).addAttribute("isAdmin", true);
        verify(studentService, times(1)).deleteStudent(id);
    }

    @Test
    void givenNotAdmin_whenDeleteStudent_thenRedirectToAdmin() {
        // Given
        Long id = 1L;
        when(adminService.fetchIsAdminStatus()).thenReturn(false);

        // When
        String result = studentController.deleteStudent(id, model);

        // Then
        assertEquals("admin", result);
        verify(model, times(1)).addAttribute("isAdmin", false);
        verify(studentService, times(0)).deleteStudent(anyLong());
    }


    @Test
    void testDeleteStudent_AsAdmin() {
        Long studentId = 1L;
        when(adminService.fetchIsAdminStatus()).thenReturn(true);
        String viewName = studentController.deleteStudent(studentId, model);
        verify(adminService, times(1)).fetchIsAdminStatus();
        verify(studentService, times(1)).deleteStudent(studentId);
        verify(model, times(1)).addAttribute("isAdmin", true);
        assertThat(viewName).isEqualTo("students");
    }

    @Test
    void testDeleteStudent_NotAsAdmin() {
        Long studentId = 1L;
        when(adminService.fetchIsAdminStatus()).thenReturn(false);
        String viewName = studentController.deleteStudent(studentId, model);
        verify(adminService, times(1)).fetchIsAdminStatus();
        verify(studentService, never()).deleteStudent(anyLong());
        verify(model, times(1)).addAttribute("isAdmin", false);
        assertThat(viewName).isEqualTo("admin");
    }

}
