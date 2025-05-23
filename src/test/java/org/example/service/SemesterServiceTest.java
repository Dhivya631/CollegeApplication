package org.example.service;

import static org.mockito.Mockito.*;
import static org.junit.jupiter.api.Assertions.*;

import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import java.util.Optional;

import org.example.entity.Semester;
import org.example.repository.CourseRepository;
import org.example.repository.SemesterRepository;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.mockito.junit.jupiter.MockitoExtension;

@ExtendWith(MockitoExtension.class)
class SemesterServiceTest {

    @Mock
    private SemesterRepository semesterRepository;

    @Mock
    private CourseRepository courseRepository;

    @InjectMocks
    private SemesterService semesterService;

    @BeforeEach
    void setUp() {
        MockitoAnnotations.openMocks(this);
    }

    @Test
    void testSave_Positive() {
        Semester semester = new Semester();
        when(semesterRepository.save(semester)).thenReturn(semester);
        Semester result = semesterService.save(semester);
        assertNotNull(result);
        verify(semesterRepository, times(1)).save(semester);
    }
    @Test
    void testFindAllSemesters_Positive() {
        List<Semester> semesters = Arrays.asList(new Semester(), new Semester());
        when(semesterRepository.findAll()).thenReturn(semesters);
        List<Semester> result = semesterService.findAllSemesters();
        assertNotNull(result);
        assertEquals(2, result.size());
    }

    @Test
    void testFindAllSemesters_Negative() {
        when(semesterRepository.findAll()).thenReturn(Collections.emptyList());
        List<Semester> result = semesterService.findAllSemesters();
        assertNotNull(result);
        assertTrue(result.isEmpty());
    }

    @Test
    void testAddDetails_Positive() {
        Long departmentId = 1L;
        String semesterName = "Spring 2024";
        Semester semester = new Semester();
        semester.setDepartmentId(departmentId);
        semester.setName(semesterName);
        when(semesterRepository.save(any(Semester.class))).thenReturn(semester);
        Semester result = semesterService.addDetails(departmentId, semesterName);
        assertNotNull(result);
        assertEquals(departmentId, result.getDepartmentId());
        assertEquals(semesterName, result.getName());
    }

//    @Test
//    public void testAddDetails_Negative() {
//        Long departmentId = 1L;
//        String semesterName = null;
//        assertThrows(IllegalArgumentException.class, () -> {
//            semesterService.addDetails(departmentId, semesterName);
//        });
//        verify(semesterRepository, never()).save(any(Semester.class));
//    }

    @Test
    void testFindById_Positive() {
        Long semesterId = 1L;
        Semester semester = new Semester();
        when(semesterRepository.findById(semesterId)).thenReturn(Optional.of(semester));
        Semester result = semesterService.findById(semesterId);
        assertNotNull(result);
    }

    @Test
    void testFindById_Negative() {
        Long semesterId = 1L;
        when(semesterRepository.findById(semesterId)).thenReturn(Optional.empty());
        assertThrows(RuntimeException.class, () -> {
            semesterService.findById(semesterId);
        });
    }

    @Test
    void testGetId_Positive() {
        Long maxId = 10L;
        when(semesterRepository.getMaxId()).thenReturn(maxId);
        Long result = semesterService.getId();
        assertNotNull(result);
        assertEquals(maxId, result);
    }

    @Test
    void testGetId_Negative() {
        when(semesterRepository.getMaxId()).thenReturn(null);
        Long result = semesterService.getId();
        assertNull(result);
    }

    @Test
    void testGetAllSemesters_Positive() {
        List<Semester> semesters = Arrays.asList(new Semester(), new Semester());
        when(semesterRepository.findAll()).thenReturn(semesters);
        List<Semester> result = semesterService.getAllSemesters();
        assertNotNull(result);
        assertEquals(2, result.size());
    }

    @Test
    void testGetAllSemesters_Negative() {
        when(semesterRepository.findAll()).thenReturn(Collections.emptyList());
        List<Semester> result = semesterService.getAllSemesters();
        assertNotNull(result);
        assertTrue(result.isEmpty());
    }
}