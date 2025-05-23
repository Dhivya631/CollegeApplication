package org.example.service;

import static org.mockito.Mockito.*;
import static org.junit.jupiter.api.Assertions.*;

import java.util.Arrays;
import java.util.Collections;
import java.util.List;

import org.example.entity.CourseSemester;
import org.example.repository.CourseSemesterRepository;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.mockito.junit.jupiter.MockitoExtension;

@ExtendWith(MockitoExtension.class)
class CourseSemesterServiceTest {

    @Mock
    private CourseSemesterRepository courseSemesterRepository;

    @InjectMocks
    private CourseSemesterService courseSemesterService;

    @BeforeEach
    public void setUp() {
        MockitoAnnotations.openMocks(this);
    }

    @Test
    void testGetAllDetails() {
        List<CourseSemester> courseSemesters = Arrays.asList(new CourseSemester(), new CourseSemester());
        when(courseSemesterRepository.findAll()).thenReturn(courseSemesters);
        List<CourseSemester> result = courseSemesterService.getAllDetails();
        assertNotNull(result);
        assertEquals(2, result.size());
    }

    @Test
    void testGetAllDetails_Neg() {
        when(courseSemesterRepository.findAll()).thenReturn(Collections.emptyList());
        List<CourseSemester> result = courseSemesterService.getAllDetails();
        assertNotNull(result);
        assertTrue(result.isEmpty());
    }

    @Test
    void testAddCoursesToSemester() {
        List<Long> courseIds = Arrays.asList(1L, 2L, 3L);
        Long semesterId = 1L;
        courseSemesterService.addCoursesToSemester(courseIds, semesterId);
        verify(courseSemesterRepository, times(3)).save(any(CourseSemester.class));
    }

    @Test
    void testAddCoursesToSemester_Neg() {
        List<Long> courseIds = Collections.emptyList();
        Long semesterId = 1L;
        courseSemesterService.addCoursesToSemester(courseIds, semesterId);
        verify(courseSemesterRepository, never()).save(any(CourseSemester.class));
    }

    @Test
    void testSave() {
        CourseSemester courseSemester = new CourseSemester();
        courseSemesterService.save(courseSemester);
        verify(courseSemesterRepository, times(1)).save(courseSemester);
    }

}