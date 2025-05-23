package org.example.service;

import org.example.entity.Semester;
import org.example.repository.CourseRepository;
import org.example.repository.SemesterRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class SemesterService {

    @Autowired
    private SemesterRepository semesterRepository;
    @Autowired
    private CourseRepository courseRepository;

    public Semester save(Semester semester){
        semesterRepository.save(semester);
        return semester;
    }
    public List<Semester> findAllSemesters() {
        return semesterRepository.findAll();
    }

    public Semester addDetails(Long departmentId, String semesterName) {

        Semester semester = new Semester();
        semester.setName(semesterName);
        semester.setDepartmentId(departmentId);
        return semesterRepository.save(semester);

    }

    public Semester findById(Long id){
        Semester semester = semesterRepository.findById(id).orElseThrow(()-> new RuntimeException("Semester not found"));
        return semester;
    }

    public Long getId() {
        Long id = semesterRepository.getMaxId();
        return id;
    }

    public List<Semester> getAllSemesters() {
        return semesterRepository.findAll();
    }
}