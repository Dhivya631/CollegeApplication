package org.example.service;

import jakarta.transaction.Transactional;
import org.example.config.DatabaseConfig;
import org.example.entity.Course;
import org.example.repository.CourseRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
public class CourseService {
    @Autowired
    private CourseRepository courseRepository;
    @Transactional
    public Course createCourse(Course course){
        return courseRepository.save(course);
    }
    public List<Course> findAllCourses(){
        return courseRepository.findAll();
    }
    public List<Course> getAllCourses(){
        return courseRepository.findAllGroup();
    }
    public List<Course> getAllUniqueCourses(){
        return courseRepository.findAllGroup();
    }


    public Course findById(Long id){
        return courseRepository.findById(id).orElse(null);
    }
    public Course save(Course course){
        return courseRepository.save(course);
    }
    public boolean deleteCourse(Long rid) {
        Optional<Course> optionalCourse = courseRepository.findById(rid);
        if (optionalCourse.isPresent()) {
            courseRepository.delete(optionalCourse.get());
            return true;
        } else {
            return false;
        }
    }

    public List<Course> findCoursesByIds(List<Long> courseIds){
        return courseRepository.findAllById(courseIds);
    }

    public List<Course> findCoursesByDepartmentId(Long departmentId){
        return courseRepository.findByDepartmentId(departmentId);
    }

    public Course getCourseById(Long rno){
        return courseRepository.findById(rno).orElse(null);
    }
    public Course updateCourse(Course course){
        return courseRepository.save(course);

    }

    public List<Course> getCoursesByName(String name) {
        return courseRepository.findByName(name);
    }

    public Long getNextCourseId() {
        Long maxId = courseRepository.getMaxCourseId();
        return (maxId == null) ? 1001L : maxId + 1;
    }

    public long getCourseCount() {
        return courseRepository.countCourse();
    }

    public List<Long> getAvailableCourseIds(String semesterName, Long departmentId, List<Long> courseIds) {

        List<Long> courseIdsAvailable = new ArrayList<>();

        Connection conn = null;
        Statement stmt = null;
        ResultSet rs2= null;

        try {

            conn = DatabaseConfig.getConnection();
            stmt = conn.createStatement();
            String query ="select course.id as ids,department.id,department.name as departmentName,semester.name FROM course_semester join semester on semester.id=course_semester.semester_id join department on department.id=semester.department_id join course on course_semester.course_id=course.id group by course_semester.id having department.id= "+departmentId+" and semester.name= '"+semesterName+"'";
            System.out.println(query);

            rs2 = stmt.executeQuery(query);

            while (rs2.next()) {

                courseIdsAvailable.add(rs2.getLong("ids"));

            }
            rs2.close();
        }
        catch(Exception e){
            e.printStackTrace();
        }

        finally {
            try {
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            }
            catch (SQLException se) {
                se.printStackTrace();
            }
        }
        return courseIdsAvailable;
    }


}