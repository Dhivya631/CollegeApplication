package org.example.service;

import org.example.entity.Student;
import org.example.repository.StudentRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class StudentService {
    @Autowired
    private StudentRepository studentRepository;

    public Student saveStudent(Student student) {

        return studentRepository.save(student);
    }
    public Student findStudentByUsernameAndEmail(String username, String email) {
        return studentRepository.findByUsernameAndEmail(username,email);
    }
    public Student findStudentByNameAndEmail(String name, String email) {
        return studentRepository.findByNameAndEmail(name,email);
    }
    public long getStudentCount() {
        return studentRepository.countStudent();
    }
    public List<Student> getAllStudents() {

        return studentRepository.findAll();
    }
    public Student getStudentById(Long id) {
        return studentRepository.findById(id).orElse(null);
    }

    public Student findByEmailAndPassword(String email, String password) {
        return studentRepository.findByEmailAndPassword(email, password);
    }

    public void deleteStudent(Long id) {
        studentRepository.deleteById(id);
    }

    public void updateStudent(Student student) {
        studentRepository.save(student);
    }

}

