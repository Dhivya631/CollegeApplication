package org.example.service;

import org.example.entity.Employee;
import org.example.repository.EmployeeRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class EmployeeService {
    @Autowired
    private EmployeeRepository employeeRepository;

    public Employee saveEmployee(Employee employee){
        return employeeRepository.save(employee);
    }

    public long getEmployeeCount() {
        return employeeRepository.countEmployee();
    }

    public Employee findByEmailAndPassword(String email, String password) {
        return employeeRepository.findByEmailAndPassword(email, password);
    }
    public List<Employee> getAllEmployees(){
        return employeeRepository.findAll();
    }


    public Employee getEmployeeById(Long id) {
        Optional<Employee> optionalEmployee = employeeRepository.findById(Math.toIntExact(id));
        return optionalEmployee.orElseThrow(() -> new IllegalArgumentException("Invalid employee Id:" + id));
    }

    public void deleteEmployee(Long id) {
        Employee employee = getEmployeeById(id);
        employeeRepository.delete(employee);
    }

}