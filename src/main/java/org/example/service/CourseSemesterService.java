package org.example.service;

import org.example.entity.CourseSemester;
import org.example.repository.CourseSemesterRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CourseSemesterService {

    @Autowired
    private CourseSemesterRepository courseSemesterRepository;

    public List<CourseSemester> getAllDetails() {
        return courseSemesterRepository.findAll();
    }

    public void addCoursesToSemester(List<Long> courseIds,Long semesterId){
        for (Long courseId : courseIds){
            CourseSemester courseSemester = new CourseSemester();
//            courseSemester.setCourse(new Course(courseId));
//            courseSemester.setSemester(new Semester(semesterId));
            courseSemesterRepository.save(courseSemester);
        }
    }

    public void save(CourseSemester courseSemester) {
        courseSemesterRepository.save(courseSemester);
    }
}