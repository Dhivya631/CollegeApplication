package org.example.repository;

import org.example.entity.Department;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface DepartmentRepository extends JpaRepository<Department,Long> {

    @Query("select count(d) from Department d")
    long countDepartment();

    @Query("select d.id from Department d where d.name = :departmentName")
    Long getIdByName(@Param("departmentName") String departmentName);

}