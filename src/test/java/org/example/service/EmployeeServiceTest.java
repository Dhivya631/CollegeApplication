package org.example.service;

import static org.mockito.Mockito.*;
import static org.junit.jupiter.api.Assertions.*;

import java.util.Optional;
import java.util.List;
import java.util.ArrayList;

import org.example.entity.Employee;
import org.example.repository.EmployeeRepository;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

@ExtendWith(MockitoExtension.class)
class EmployeeServiceTest {

    @Mock
    private EmployeeRepository employeeRepository;

    @InjectMocks
    private EmployeeService employeeService;

    private Employee employee;

    @BeforeEach
    void setUp() {
        employee = new Employee();
        employee.setEmployeeid(1);
        employee.setName("John Doe");
        employee.setEmail("john.doe@example.com");
        employee.setPassword("password");
    }

    @Test
    void testSaveEmployee() {
        when(employeeRepository.save(employee)).thenReturn(employee);
        Employee savedEmployee = employeeService.saveEmployee(employee);
        assertEquals(employee, savedEmployee);
        verify(employeeRepository, times(1)).save(employee);
    }

    @Test
    void testGetEmployeeCount() {
        long count = 5L;
        when(employeeRepository.countEmployee()).thenReturn(count);
        long employeeCount = employeeService.getEmployeeCount();
        assertEquals(count, employeeCount);
        verify(employeeRepository, times(1)).countEmployee();
    }

    @Test
    void testFindByEmailAndPassword() {
        String email = "john.doe@example.com";
        String password = "password";
        when(employeeRepository.findByEmailAndPassword(email, password)).thenReturn(employee);
        Employee foundEmployee = employeeService.findByEmailAndPassword(email, password);
        assertEquals(employee, foundEmployee);
        verify(employeeRepository, times(1)).findByEmailAndPassword(email, password);
    }

    @Test
    void testGetAllEmployees() {
        List<Employee> employees = new ArrayList<>();
        employees.add(employee);
        when(employeeRepository.findAll()).thenReturn(employees);
        List<Employee> allEmployees = employeeService.getAllEmployees();
        assertEquals(employees, allEmployees);
        verify(employeeRepository, times(1)).findAll();
    }

    @Test
    void testGetEmployeeById() {
        int id = 1;
        when(employeeRepository.findById(id)).thenReturn(Optional.of(employee));
        Employee foundEmployee = employeeService.getEmployeeById((long)id);
        assertEquals(employee, foundEmployee);
        verify(employeeRepository, times(1)).findById(id);
    }

    @Test
    void testGetEmployeeByIdNotFound() {
        int id = 99;
        when(employeeRepository.findById(id)).thenReturn(Optional.empty());
        Exception exception = assertThrows(IllegalArgumentException.class, () -> {
            employeeService.getEmployeeById((long)id);
        });
        assertEquals("Invalid employee Id:99", exception.getMessage());
        verify(employeeRepository, times(1)).findById(id);
    }

    @Test
    void testDeleteEmployee() {
        int id = 1;
        when(employeeRepository.findById(id)).thenReturn(Optional.of(employee));
        employeeService.deleteEmployee((long)id);
        verify(employeeRepository, times(1)).delete(employee);
    }

    @Test
    void testDeleteEmployeeNotFound() {
        int id = 99;
        when(employeeRepository.findById(id)).thenReturn(Optional.empty());
        Exception exception = assertThrows(IllegalArgumentException.class, () -> {
            employeeService.deleteEmployee((long)id);
        });
        assertEquals("Invalid employee Id:99", exception.getMessage());
        verify(employeeRepository, times(1)).findById(id);
        verify(employeeRepository, times(0)).delete(any(Employee.class));
    }
}