package org.example.service;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

import org.example.entity.Department;
import org.example.repository.DepartmentRepository;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.util.Arrays;
import java.util.List;
import java.util.Optional;


@ExtendWith(MockitoExtension.class)
class DepartmentServiceTest {

    @Mock
    private DepartmentRepository departmentRepository;

    @InjectMocks
    private DepartmentService departmentService;

    private Department department1;
    private Department department2;

    @BeforeEach
    void setUp() {
        department1 = new Department();
        department1.setId(1L);
        department1.setName("HR");
        department1.setDescription("Human Resources");

        department2 = new Department();
        department2.setId(2L);
        department2.setName("IT");
        department2.setDescription("Information Technology");
    }

    @Test
    void testGetAllDepartments() {
        when(departmentRepository.findAll()).thenReturn(Arrays.asList(department1, department2));

        List<Department> departments = departmentService.getAllDepartments();
        assertNotNull(departments);
        assertEquals(2, departments.size());
        verify(departmentRepository, times(1)).findAll();
    }

    @Test
    void testFindById_Positive() {
        when(departmentRepository.findById(1L)).thenReturn(Optional.of(department1));

        Department department = departmentService.findById(1L);
        assertNotNull(department);
        assertEquals("HR", department.getName());
        verify(departmentRepository, times(1)).findById(1L);
    }

    @Test
    void testFindById_Negative() {
        when(departmentRepository.findById(1L)).thenReturn(Optional.empty());

        Department department = departmentService.findById(1L);
        assertNull(department);
        verify(departmentRepository, times(1)).findById(1L);
    }

    @Test
    void testSave() {
        when(departmentRepository.save(department1)).thenReturn(department1);

        Department savedDepartment = departmentService.save(department1);
        assertNotNull(savedDepartment);
        assertEquals("HR", savedDepartment.getName());
        verify(departmentRepository, times(1)).save(department1);
    }

    @Test
    void testGetDepartmentById_Positive() {
        when(departmentRepository.findById(1L)).thenReturn(Optional.of(department1));

        Department department = departmentService.getDepartmentById(1L);
        assertNotNull(department);
        assertEquals("HR", department.getName());
        verify(departmentRepository, times(1)).findById(1L);
    }

    @Test
    void testGetDepartmentById_Negative() {
        when(departmentRepository.findById(1L)).thenReturn(Optional.empty());

        Department department = departmentService.getDepartmentById(1L);
        assertNull(department);
        verify(departmentRepository, times(1)).findById(1L);
    }

    @Test
    void testCreateDepartment() {
        when(departmentRepository.save(department1)).thenReturn(department1);

        Department createdDepartment = departmentService.createDepartment(department1);
        assertNotNull(createdDepartment);
        assertEquals("HR", createdDepartment.getName());
        verify(departmentRepository, times(1)).save(department1);
    }

    @Test
    void testUpdateDepartment_Positive() {
        when(departmentRepository.findById(1L)).thenReturn(Optional.of(department1));
        when(departmentRepository.save(department1)).thenReturn(department1);

        Department updatedDetails = new Department();
        updatedDetails.setName("HR Updated");
        updatedDetails.setDescription("Human Resources Updated");

        Department updatedDepartment = departmentService.updateDepartment(1L, updatedDetails);
        assertNotNull(updatedDepartment);
        assertEquals("HR Updated", updatedDepartment.getName());
        assertEquals("Human Resources Updated", updatedDepartment.getDescription());
        verify(departmentRepository, times(1)).findById(1L);
        verify(departmentRepository, times(1)).save(department1);
    }

    @Test
    void testUpdateDepartment_Negative() {
        when(departmentRepository.findById(1L)).thenReturn(Optional.empty());

        Department updatedDetails = new Department();
        updatedDetails.setName("HR Updated");
        updatedDetails.setDescription("Human Resources Updated");

        Department updatedDepartment = departmentService.updateDepartment(1L, updatedDetails);
        assertNull(updatedDepartment);
        verify(departmentRepository, times(1)).findById(1L);
        verify(departmentRepository, times(0)).save(any());
    }

    @Test
    void testDeleteDepartment_Positive() {
        when(departmentRepository.findById(1L)).thenReturn(Optional.of(department1));
        doNothing().when(departmentRepository).delete(department1);

        boolean isDeleted = departmentService.deleteDepartment(1L);
        assertTrue(isDeleted);
        verify(departmentRepository, times(1)).findById(1L);
        verify(departmentRepository, times(1)).delete(department1);
    }

    @Test
    void testDeleteDepartment_Negative() {
        when(departmentRepository.findById(1L)).thenReturn(Optional.empty());

        boolean isDeleted = departmentService.deleteDepartment(1L);
        assertFalse(isDeleted);
        verify(departmentRepository, times(1)).findById(1L);
        verify(departmentRepository, times(0)).delete(any());
    }
}