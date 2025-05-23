package org.example.repository;

import org.example.entity.Course;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
@Repository
public interface CourseRepository extends JpaRepository<Course,Long> {
    List<Course> findByDepartmentId(Long departmentId);

    List<Course> findByName(String name);

    //    @Query("select c from Course c where c.id= :existingCourseId")
    @Query(value = "select * from Course where id = :existingCourseId limit 1",nativeQuery = true)
    Course findCourseById(@Param("existingCourseId") Long existingCourseId);

    @Query("SELECT MAX(course.id) FROM Course course")
    Long getMaxCourseId();

    @Query("SELECT c from Course c")
    List<Course> findAllGroup();


    @Query("select count(c) from Course c")
    long countCourse();

}
