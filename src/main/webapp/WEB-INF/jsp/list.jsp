<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
    <title>Courses</title>
</head>
<body>
    <h1>Courses</h1>
    <a href="/courses/create">Create Course</a>
    <ul>
        <th:block th:each="course : ${courses}">
            <li>
                <strong>Course Name:</strong> <span th:text="${course.courseName}"></span><br>
                <strong>Description:</strong> <span th:text="${course.description}"></span><br>
                <strong>Department:</strong> <span th:text="${course.department.department}"></span>
            </li>
        </th:block>
    </ul>
</body>
</html>