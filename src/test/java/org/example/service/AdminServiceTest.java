package org.example.service;

import org.example.entity.Admin;
import org.example.repository.AdminRepository;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

class AdminServiceTest {

    @Mock
    private AdminRepository adminRepository;

    @InjectMocks
    private AdminService adminService;

    @BeforeEach
    void setUp() {
        MockitoAnnotations.openMocks(this);
    }

    @Test
    void testFindByEmailAndPassword_Pos() {
        String email = "Vani@gmail.com";
        String password = "Pass$12";
        Admin expectedAdmin = new Admin();
        expectedAdmin.setEmail(email);
        expectedAdmin.setPassword(password);

        when(adminRepository.findByEmailAndPassword(email, password)).thenReturn(expectedAdmin);

        Admin actualAdmin = adminService.findByEmailAndPassword(email, password);

        assertNotNull(actualAdmin);
        assertEquals(expectedAdmin, actualAdmin);
        verify(adminRepository, times(1)).findByEmailAndPassword(email, password);
    }

    @Test
    void testFindByEmailAndPassword_wrong() {
        String email = "wrong@gmail.com.com";
        String password = "Pass@12";

        when(adminRepository.findByEmailAndPassword(email, password)).thenReturn(null);

        Admin actualAdmin = adminService.findByEmailAndPassword(email, password);

        assertNull(actualAdmin);
        verify(adminRepository, times(1)).findByEmailAndPassword(email, password);
    }
}