package org.example.controller;

import org.example.entity.Course;
import org.example.entity.Department;
import org.example.service.CourseService;
import org.example.service.DepartmentService;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import static org.assertj.core.api.AssertionsForClassTypes.assertThat;
import java.util.ArrayList;
import java.util.List;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.anyLong;
import static org.mockito.Mockito.*;

class CourseControllerTest {

    @Mock
    private CourseService courseService;

    @Mock
    private DepartmentService departmentService;

    @Mock
    private Model model;

    @Mock
    private RedirectAttributes redirectAttributes;

    @Mock
    private BindingResult bindingResult;
    @InjectMocks
    private CourseController courseController;

    public CourseControllerTest() {
        MockitoAnnotations.openMocks(this);
    }

    @Test
    void showCreateForm_Positive() {
        List<Department> departments = new ArrayList<>();
        when(departmentService.getAllDepartments()).thenReturn(departments);
        String viewName = courseController.showCreateForm(model);
        verify(model, times(1)).addAttribute(eq("course"), any(Course.class));
        verify(model, times(1)).addAttribute("departments", departments);
        assertEquals("create", viewName);
    }

    @Test
    void showCreateForm_Negative() {
        when(departmentService.getAllDepartments()).thenThrow(new RuntimeException("Error fetching departments"));
        RuntimeException exception = assertThrows(RuntimeException.class, () -> {
            courseController.showCreateForm(model);
        });
        assertEquals("Error fetching departments", exception.getMessage());
    }

    @Test
    void createCourse_Positive() {
        Department department = new Department();
        Course course = new Course();
        List<Course> existingCourses = new ArrayList<>();
        when(departmentService.getDepartmentById(anyLong())).thenReturn(department);
        when(courseService.getCoursesByName(anyString())).thenReturn(existingCourses);
        when(courseService.getNextCourseId()).thenReturn(1L);
        String viewName = courseController.createCourse(course, 1L);
        verify(courseService, times(1)).createCourse(course);
        assertEquals("redirect:/courses/create", viewName);
    }

    @Test
    void displayCourse_Positive() {
        Long employeeid=1L;
        Boolean isAdmin=true;
        List<Course> courses = new ArrayList<>();
        when(courseService.getAllUniqueCourses()).thenReturn(courses);
        String viewName = courseController.displayCourse(employeeid,isAdmin,model);
        verify(model).addAttribute("courses", courses);
        assertThat(viewName).isEqualTo("courseDisplay");
    }


    @Test
    void displayCourse_neg() {
        Long employeeid=1L;
        Boolean isAdmin=true;
        String viewName = courseController.displayCourse(employeeid,isAdmin,model);
        verify(model).addAttribute("courses",new ArrayList<>());
        assertThat(viewName).isEqualTo("courseDisplay");
    }


    @Test
    void showEditForm_Positive() {
        Department department=new Department();
        department.setId(1L);
        department.setName("CSE");
        department.setDescription("Computer Science Description");
        System.out.println("Getting all values from department: " +department);
        Course course = new Course();
        course.setRno(1L);
        course.setId(1001);
        course.setName("Java");
        course.setDescription("Programming Language");
        course.setCredit("4");
        course.setDepartment(department);
        System.out.println("Getting all values from course: "+course);
        List<Department> departments = new ArrayList<>();
        when(courseService.getCourseById(anyLong())).thenReturn(course);
        when(departmentService.getAllDepartments()).thenReturn(departments);
        String viewName = courseController.showEditForm(1L, model);

        verify(model, times(1)).addAttribute("course", course);
        verify(model, times(1)).addAttribute("departments", departments);
        assertEquals("editCourse", viewName);
    }

    @Test
    void showEditForm_Negative() {
        when(courseService.getCourseById(anyLong())).thenThrow(new RuntimeException("Error fetching course"));
        RuntimeException exception = assertThrows(RuntimeException.class, () -> {
            courseController.showEditForm(1L, model);
        });
        assertEquals("Error fetching course", exception.getMessage());
    }

    @Test
    void editCourse_Positive() {
        // Given
        Course course = new Course();
        Department department = new Department();
        Course existingCourse = new Course();
        existingCourse.setId(1L);
        when(courseService.getCourseById(1L)).thenReturn(existingCourse);
        when(departmentService.getDepartmentById(1L)).thenReturn(department);
        when(bindingResult.hasErrors()).thenReturn(false);
        // When
        String viewName = courseController.editCourse(1L, course, bindingResult, 1L, model);

        // Then
        verify(courseService, times(1)).updateCourse(existingCourse);
        assertEquals("redirect:/courses/display", viewName);
    }

    @Test
    void editCourse_Negative_ValidationErrors() {
        // Given
        when(bindingResult.hasErrors()).thenReturn(true);

        // When
        String viewName = courseController.editCourse(1L, new Course(), bindingResult, 1L, model);

        // Then
        verify(model, times(1)).addAttribute(eq("departments"), any());
        assertEquals("editCourse", viewName);
    }

    @Test
    void editCourse_Negative_CourseNotFound() {
        // Given
        when(bindingResult.hasErrors()).thenReturn(false);
        when(courseService.getCourseById(1L)).thenReturn(null);

        // When
        String viewName = courseController.editCourse(1L, new Course(), bindingResult, 1L, model);

        // Then
        assertEquals("error", viewName);
    }

}