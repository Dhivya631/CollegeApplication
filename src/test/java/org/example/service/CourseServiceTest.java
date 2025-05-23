package org.example.service;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

import java.util.Arrays;
import java.util.List;
import java.util.Optional;

import org.example.entity.Course;
import org.example.entity.Department;
import org.example.repository.CourseRepository;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;

class CourseServiceTest {

    @Mock
    private CourseRepository courseRepository;

    @InjectMocks
    private CourseService courseService;

    @BeforeEach
    public void setup() {
        MockitoAnnotations.openMocks(this);
    }

    @Test
    void testGetAllCourses() {
        Department department1 = new Department();
        department1.setId(1L);
        department1.setName("CSE");
        department1.setDescription("Computer Science and Engineering");
        Department department2 = new Department();
        department2.setId(2L);
        department2.setName("IT");
        department2.setDescription("Information Engineering");
        Course course1 = new Course();
        course1.setId(1L);
        course1.setName("Java");
        course1.setDescription("Programming Language");
        course1.setCredit("3");
        course1.setDepartment(department1);
        Course course2 = new Course();
        course2.setId(2L);
        course2.setName("C++");
        course2.setDescription("Programming Language");
        course2.setCredit("4");
        course2.setDepartment(department2);
        List<Course> courses = Arrays.asList(course1, course2);
        when(courseRepository.findAll()).thenReturn(courses);
        System.out.println("Mocked Course list: " + courses);
        List<Course> result = courseService.findAllCourses();
        System.out.println("Result from courseService: " + result);
        assertEquals(2, result.size());
        assertEquals("Java", result.get(0).getName());
        verify(courseRepository, times(1)).findAll();
    }

    @Test
    void testFindById_Positive() {
        Course course = new Course();
        when(courseRepository.findById(1L)).thenReturn(Optional.of(course));

        Course result = courseService.findById(1L);

        assertNotNull(result);
        assertEquals(course, result);
    }

    @Test
    void testFindById_Negative() {
        when(courseRepository.findById(1L)).thenReturn(Optional.empty());

        Course result = courseService.findById(1L);

        assertNull(result);
    }

    @Test
    void testSaveCourse() {
        Course course = new Course();
        when(courseRepository.save(course)).thenReturn(course);

        Course result = courseService.save(course);

        assertNotNull(result);
        assertEquals(course, result);
    }

    @Test
    void testDeleteCourse_Positive() {
        Course course = new Course();
        when(courseRepository.findById(1L)).thenReturn(Optional.of(course));

        boolean result = courseService.deleteCourse(1L);

        assertTrue(result);
        verify(courseRepository, times(1)).delete(course);
    }

    @Test
    void testDeleteCourse_Negative() {
        when(courseRepository.findById(1L)).thenReturn(Optional.empty());

        boolean result = courseService.deleteCourse(1L);

        assertFalse(result);
        verify(courseRepository, times(0)).delete(any(Course.class));
    }

    @Test
    void testGetCourseById_Positive() {
        Course course = new Course();
        when(courseRepository.findById(1L)).thenReturn(Optional.of(course));

        Course result = courseService.getCourseById(1L);

        assertNotNull(result);
        assertEquals(course, result);
    }

    @Test
    void testGetCourseById_Negative() {
        when(courseRepository.findById(1L)).thenReturn(Optional.empty());

        Course result = courseService.getCourseById(1L);

        assertNull(result);
    }

    @Test
    void testUpdateCourse() {
        Course course = new Course();
        when(courseRepository.save(course)).thenReturn(course);

        Course result = courseService.updateCourse(course);

        assertNotNull(result);
        assertEquals(course, result);
    }

    @Test
    void testGetCoursesByCname() {
        List<Course> courses = Arrays.asList(new Course(), new Course());
        when(courseRepository.findByName("Java")).thenReturn(courses);

        List<Course> result = courseService.getCoursesByName("Java");

        assertEquals(2, result.size());
        verify(courseRepository, times(1)).findByName("Java");
    }

    @Test
    void testGetNextCourseId_Positive() {
        when(courseRepository.getMaxCourseId()).thenReturn(10L);

        Long result = courseService.getNextCourseId();

        assertEquals(11L, result);
    }

    @Test
    void testGetNextCourseId_Negative() {
        when(courseRepository.getMaxCourseId()).thenReturn(null);

        Long result = courseService.getNextCourseId();

        assertEquals(1001L, result);
    }

    @Test
    void testCreateCourse() {
        Course course = new Course();
        when(courseRepository.save(course)).thenReturn(course);
        courseService.createCourse(course);
        verify(courseRepository, times(1)).save(course);
    }
}
