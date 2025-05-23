package org.example.repository;

import org.example.entity.CourseSemester;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface CourseSemesterRepository extends JpaRepository<CourseSemester, Long> {

}