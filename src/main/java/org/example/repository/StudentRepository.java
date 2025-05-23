package org.example.repository;

import org.example.entity.Student;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

@Repository
public interface StudentRepository extends JpaRepository<Student, Long> {
    Student findByEmailAndPassword(String email, String password);
    Student findByNameAndEmail(String name, String email);
    Student findByUsernameAndEmail(String username, String email);
    @Query("select count(s) from Student s")
    long countStudent();
}
