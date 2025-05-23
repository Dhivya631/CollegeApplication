package org.example.service;

import org.example.entity.Department;
import org.example.repository.DepartmentRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Optional;

@Service
public class DepartmentService {

    @Autowired
    private DepartmentRepository departmentRepository;

    public Long getIdByDeptName(String departmentName){
        return departmentRepository.getIdByName(departmentName); }
    public List<Department> getAllDepartments() {
        return departmentRepository.findAll();
    }
    public Department findById(Long id){
        return departmentRepository.findById(id).orElse(null);
    }
    public List<Department> findAllDepartment(){
        return departmentRepository.findAll();
    }
    public Department save(Department department){
        return departmentRepository.save(department);
    }
    public Department getDepartmentById(Long id) {
        Optional<Department> department = departmentRepository.findById(id);
        if(department.isPresent()){
            return department.get();
        }
        else{
            return null;
        }
    }
    public Department createDepartment(Department department) {
        return departmentRepository.save(department);
    }
    public Department updateDepartment(Long id, Department departmentDetails) {
        Optional<Department> optionalDepartment = departmentRepository.findById(id);
        if (optionalDepartment.isPresent()) {
            Department department = optionalDepartment.get();
            department.setName(departmentDetails.getName());
            department.setDescription(departmentDetails.getDescription());
            return departmentRepository.save(department);
        } else {
            return null;
        }
    }
    public boolean deleteDepartment(Long id) {
        Optional<Department> optionalDepartment = departmentRepository.findById(id);
        if (optionalDepartment.isPresent()) {
            departmentRepository.delete(optionalDepartment.get());
            return true;
        } else {
            return false;
        }
    }

    public long getDepartmentCount() {
        return departmentRepository.countDepartment();
    }

}