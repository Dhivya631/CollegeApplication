package org.example.controller;

import org.example.entity.Department;
import org.example.service.AdminService;
import org.example.service.DepartmentService;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.ui.Model;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.ArrayList;
import java.util.List;
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.anyLong;
import static org.mockito.Mockito.*;
class DepartmentControllerTest {
    @Mock
    private DepartmentService departmentService;
    @Mock
    RedirectAttributes redirectAttributes;
    @Mock
    private MockMvc mockMvc;
    @Mock
    private Model model;
    @Autowired
    private AdminService adminService;
    @InjectMocks
    private DepartmentController departmentController;
    public DepartmentControllerTest() {
        MockitoAnnotations.openMocks(this);
    }
    @Test
    void getAllDepartments_Positive() {
        List<Department> departments = new ArrayList<>();
        when(departmentService.getAllDepartments()).thenReturn(departments);
        String viewName = departmentController.getAllDepartments(model);
        verify(model, times(1)).addAttribute("departments", departments);
        assertEquals("createDepartment", viewName);
    }
    @Test
    void getAllDepartments_Negative() {
        when(departmentService.getAllDepartments()).thenThrow(new RuntimeException("Error fetching departments"));
        RuntimeException exception = assertThrows(RuntimeException.class, () -> {
            departmentController.getAllDepartments(model);
        });
        assertEquals("Error fetching departments", exception.getMessage());
    }
    @Test
    void getDepartmentById_Positive() {
        Department department = new Department();
        when(departmentService.getDepartmentById(anyLong())).thenReturn(department);
        String viewName = departmentController.getDepartmentById(1L, model);
        verify(model, times(1)).addAttribute("department", department);
        assertEquals("index", viewName);
    }
    @Test
    void getDepartmentById_Negative_NotFound() {
        when(departmentService.getDepartmentById(anyLong())).thenReturn(null);
        String viewName = departmentController.getDepartmentById(1L, model);
        verify(model, times(1)).addAttribute("error", "Department is not found with ID: " + 1L);
        assertEquals("not-found", viewName);
    }

    @Test
    void showEditForm_Positive() {
        Department department = new Department();
        when(departmentService.findById(anyLong())).thenReturn(department);
        String viewName = departmentController.showEditForm(1L, model);
        verify(model, times(1)).addAttribute("department", department);
        assertEquals("editDepartment", viewName);
    }
    @Test
    void showEditForm_Negative() {
        when(departmentService.findById(anyLong())).thenThrow(new RuntimeException("Error fetching department"));
        RuntimeException exception = assertThrows(RuntimeException.class, () -> {
            departmentController.showEditForm(1L, model);
        });
        assertEquals("Error fetching department", exception.getMessage());
    }

    @Test
    void updateDepartment_Positive() {
        Department department = new Department();
        department.setId(1L);
        department.setName("CSE");
        department.setDescription("Computer Science and Engineering");
        when(departmentService.findById(anyLong())).thenReturn(department);
        String viewName = departmentController.updateDepartment(1L, department);
        assertEquals("redirect:/departments/display", viewName);
        verify(departmentService).updateDepartment(anyLong(), any(Department.class));
    }
    @Test
    void updateDepartment_Negative_NoDepartmentFound() {
        when(departmentService.findById(anyLong())).thenReturn(null);
        String viewName = departmentController.updateDepartment(1L, new Department());
        assertEquals("redirect:/departments/display", viewName);
    }
    @Test
    void givenMessage_whenShowCreateForm_thenSuccess() {
        // Given
        String message = "This is a test message";

        // When
        String result = departmentController.showCreateForm(message, model);

        // Then
        assertEquals("createDepartment", result);
        verify(model, times(1)).addAttribute(eq("department"), any(Department.class));
        verify(model, times(1)).addAttribute("message", message);
    }

    @Test
    void givenNoMessage_whenShowCreateForm_thenSuccess() {
        // Given
        String message = null;

        // When
        String result = departmentController.showCreateForm(message, model);

        // Then
        assertEquals("createDepartment", result);
        verify(model, times(1)).addAttribute(eq("department"), any(Department.class));
        verify(model, times(1)).addAttribute("message", message);
    }
    @Test
    void givenValidDepartment_whenCreateDepartment_thenRedirectWithSuccessMessage() {
        // Given
        Department department = new Department();
        department.setName("Engineering");
        Department createdDepartment = new Department();
        createdDepartment.setId(1L);
        createdDepartment.setName("Engineering");

        when(departmentService.createDepartment(department)).thenReturn(createdDepartment);

        // When
        String result = departmentController.createDepartment(department, model, redirectAttributes);

        // Then
        assertEquals("redirect:/departments/create", result);
        verify(redirectAttributes, times(1)).addAttribute("message", "Department created Successfully with ID: " + createdDepartment.getId());
    }

    @Test
    void givenExistingDepartment_whenCreateDepartment_thenRedirectWithErrorMessage() {
        // Given
        Department department = new Department();
        department.setName("Engineering");

        when(departmentService.createDepartment(department)).thenThrow(new RuntimeException("Department Already exists"));

        // When
        String result = departmentController.createDepartment(department, model, redirectAttributes);

        // Then
        assertEquals("redirect:/departments/create", result);
        verify(redirectAttributes, times(1)).addAttribute("message", "Failed to create department, Department Already exists!");
    }

    @Test
    void givenInvalidDepartment_whenCreateDepartment_thenRedirect() {
        // Given
        Department department = new Department();
        department.setName(null);

        // When
        String result = departmentController.createDepartment(department, model, redirectAttributes);

        // Then
        assertEquals("redirect:/departments/create", result);
        verify(redirectAttributes, never()).addAttribute(anyString(), anyString());
    }
}