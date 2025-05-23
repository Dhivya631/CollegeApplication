package org.example.entity;

import jakarta.persistence.*;
import lombok.Data;

@Entity
@Data
public class CourseSemester {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private Long course_id;

    private Long semester_id;

    public void setId(Long id) {
        this.id = id;
    }

    public Long getId() {
        return id;
    }

    public Long getCourse_id() {
        return course_id;
    }

    public void setCourse_id(Long course_id) {
        this.course_id = course_id;
    }

    public void setSemester_id(Long semester_id) {
        this.semester_id = semester_id;
    }

    public Long getSemester_id() {
        return semester_id;
    }
}