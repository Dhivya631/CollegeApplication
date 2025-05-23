<%@ page import="java.sql.*, java.util.*" %>
<%@ include file="nav.jsp" %>
<%@ page import="org.example.config.DatabaseConfig" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Add Courses to Semester</title>
    <style>
        .center{
            text-align:center;
        }
    </style>
</head>
<body>
<div class="container">
<div class="row justify-content-center align-items-center vh-100">
    <div class="col-md-5">
    <div class="card">
        <div class="card-header text-center">
            <h3>Add Courses to Semester</h3>
        </div>
    <div class="card-body">

    <%

        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        ResultSet rs2 = null;
        List<Map<String, String>> departments = new ArrayList<>();
        List<Map<String, String>> courses = new ArrayList<>();

        String selectedDepartmentId = request.getParameter("departmentId");


        try {
            conn = DatabaseConfig.getConnection();
            stmt = conn.createStatement();

            // Retrieve departments
            String deptQuery = "SELECT id, name FROM department";
            rs = stmt.executeQuery(deptQuery);
            while (rs.next()) {
                Map<String, String> department = new HashMap<>();
                department.put("id", rs.getString("id"));
                department.put("name", rs.getString("name"));
                departments.add(department);
            }
            rs.close();

            // Retrieve courses based on selected department
            if (selectedDepartmentId != null && !selectedDepartmentId.isEmpty()) {
                String courseQuery = "SELECT id, name FROM course WHERE department_id = " + selectedDepartmentId;
                rs = stmt.executeQuery(courseQuery);
                while (rs.next()) {
                    Map<String, String> course = new HashMap<>();
                    course.put("id", rs.getString("id"));
                    course.put("name", rs.getString("name"));
                    courses.add(course);
                }
                rs.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }


    %>

    <form action="/addSemester" method="get">
    <div class="form-group">
        <label for="departmentId" class="form-label">Select Department:</label>
        <select id="departmentId" name="departmentId" class="form-select" onchange="this.form.submit()">
            <option value="">Select a department</option>
            <%
                for (Map<String, String> department : departments) {
                    String departmentId = department.get("id");
                    String deptName = department.get("name");
                    String selected = (selectedDepartmentId != null && selectedDepartmentId.equals(departmentId)) ? "selected" : "";
            %>
                    <option value="<%= departmentId %>" <%= selected %>><%= deptName %></option>
            <%
                }
            %>
        </select>
    </div>
    </form>

    <br>

    <%
        if (selectedDepartmentId != null && !selectedDepartmentId.isEmpty()) {
    %>

        <form action="/addSemester/<%= selectedDepartmentId %>" method="post">
            <div class="form-group">
                   <label for="semesterName" class="form-label">Semester</label>
                   <select id="semesterName" class="form-select" name="semesterName">
                     <option selected>Choose...</option>
                     <option>Sem 1</option>
                     <option>Sem 2</option>
                     <option>Sem 3</option>
                     <option>Sem 4</option>
                     <option>Sem 5</option>
                     <option>Sem 6</option>
                     <option>Sem 7</option>
                     <option>Sem 8</option>
                   </select>
            </div>
            <br>

            <%
                String selectedSemesterName = request.getParameter("semesterName");
            %>

            <div class="form-group">
            <label for="courses" class="form-label">Select Courses:</label>
            <br>
            <select id="courses" name="courseIds" class="form-select" multiple="multiple">
                <%
                    for (Map<String, String> course : courses) {
                        String courseId = course.get("id");
                        String courseName = course.get("name");
                %>
                        <option value="<%= courseId %>"><%= courseName %></option>
                <%
                    }
                %>
            </select>
            </div>



            <div class="d-flex justify-content-center mt-3">
            <button type="submit" class="btn btn-primary btn-block" >Add Courses</button>
            </div>
        </form>

    <%
        } else {
    %>
        <p>Please select a department to see available courses.</p>
    <%
        }
    %>


        <%
        String message = (String) request.getAttribute("message");
        if (message != null && !message.isEmpty()) {
        %>
        <script type="text/javascript">
            alert("Message from request: <%= message %>");
        </script>
        <%
        }
        %>

    </div>
    <div class="center">
                                 <a href="/adminDash">Back to adminDash</a>
   </div>
    </div>
    </div>
    </div>
</body>
</html>
