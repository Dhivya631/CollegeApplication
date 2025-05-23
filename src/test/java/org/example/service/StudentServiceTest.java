package org.example.service;

import org.example.entity.Student;
import org.example.repository.StudentRepository;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import java.util.Arrays;
import java.util.List;
import java.util.Optional;
import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class StudentServiceTest {

    @Mock
    private StudentRepository studentRepository;

    @InjectMocks
    private StudentService studentService;

    private Student student;

    @BeforeEach
    public void setup() {
        student = new Student();
        student.setId(1L);
        student.setEmail("vani@gmail.com");
        student.setPassword("vani");
    }

    @Test
    void testGetAllStudents_Positive() {
        List<Student> students = Arrays.asList(student);
        when(studentRepository.findAll()).thenReturn(students);

        List<Student> result = studentService.getAllStudents();

        assertEquals(1, result.size());
        verify(studentRepository, times(1)).findAll();
    }

    @Test
    void testGetAllStudents_Negative() {
        when(studentRepository.findAll()).thenThrow(new RuntimeException("Fetch failed"));

        Exception exception = assertThrows(RuntimeException.class, () -> {
            studentService.getAllStudents();
        });

        assertEquals("Fetch failed", exception.getMessage());
    }

    @Test
    void testFindByEmailAndPassword_Pos() {
        when(studentRepository.findByEmailAndPassword(student.getEmail(), student.getPassword()))
                .thenReturn(student);
        Student result = studentService.findByEmailAndPassword(student.getEmail(), student.getPassword());
        assertNotNull(result);
        assertEquals(student.getEmail(), result.getEmail());
        verify(studentRepository, times(1)).findByEmailAndPassword(student.getEmail(), student.getPassword());
    }

    @Test
    void testFindByEmailAndPassword_Neg() {
        when(studentRepository.findByEmailAndPassword(student.getEmail(), student.getPassword()))
                .thenReturn(null);

        Student result = studentService.findByEmailAndPassword(student.getEmail(), student.getPassword());

        assertNull(result);
    }

    @Test
    void testDeleteStudent_Pos() {
        doNothing().when(studentRepository).deleteById(student.getId());

        studentService.deleteStudent(student.getId());

        verify(studentRepository, times(1)).deleteById(student.getId());
    }

    @Test
    void testDeleteStudent_Neg() {
        doThrow(new RuntimeException("Delete failed")).when(studentRepository).deleteById(student.getId());

        Exception exception = assertThrows(RuntimeException.class, () -> {
            studentService.deleteStudent(student.getId());
        });

        assertEquals("Delete failed", exception.getMessage());
    }

    @Test
    void testUpdateStudent_Positive() {
        when(studentRepository.save(student)).thenReturn(student);

        studentService.updateStudent(student);

        verify(studentRepository, times(1)).save(student);
    }

    @Test
    void testUpdateStudent_Neg() {
        when(studentRepository.save(student)).thenThrow(new RuntimeException("Update failed"));

        Exception exception = assertThrows(RuntimeException.class, () -> {
            studentService.updateStudent(student);
        });

        assertEquals("Update failed", exception.getMessage());
    }

    @Test
    void testGetStudentById_Pos() {
        when(studentRepository.findById(student.getId())).thenReturn(Optional.of(student));

        Student result = studentService.getStudentById(student.getId());

        assertNotNull(result);
        assertEquals(student.getId(), result.getId());
        verify(studentRepository, times(1)).findById(student.getId());
    }

    @Test
    void testSaveStudent_Negative() {
        when(studentRepository.save(student)).thenThrow(new RuntimeException("Save failed"));

        Exception exception = assertThrows(RuntimeException.class, () -> {
            studentService.saveStudent(student);
        });

        assertEquals("Save failed", exception.getMessage());
    }
}
