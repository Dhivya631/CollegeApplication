<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ include file="nav.jsp" %>
<%@ page import="java.util.List" %>
<%@ page import="org.example.entity.Department" %>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Course</title>
    <style>
    h2{
        font-family: Times New Roman;
    }
    .container{
        font-family: Times New Roman;
    }
    .center{
        text-align:center;
    }
    </style>
</head>
<body>
    <div class="row justify-content-center align-items-center vh-100">
                <div class="col-md-4">
                    <div class="card">
                        <div class="card-header text-center">
                        <h2>Edit Courses</h2>
                    </div>
                    <div class="card-body">
                        <form:form method="post" modelAttribute="course" action="/courses/edit/${course.rno}">
                            <form:hidden path="rno" />
                            <div class="form-group">
                                          <label for="name">Course Name:</label>
                                          <form:input path="name" class="form-control" id="name" required="required"/>
                            </div>
                            <div class="form-group">
                                          <label for="description">Description:</label>
                                          <form:input path="description" class="form-control" id="description"/>
                            </div>
                            <div class="form-group">
                                          <label for="credit">Credit:</label>
                                          <form:input path="credit" class="form-control" id="credit"/>
                            </div>
                            <div class="col-md-6">
                                            <label for="departmentId">Department:</label>
                                            <select id="departmentId" name="departmentId" class="form-select" required>
                                                        <option selected value="">Select Department</option>
                                                        <%
                                                                    List<Department> departments = (List<Department>) request.getAttribute("departments");
                                                                    if (departments != null) {
                                                                        for (Department department : departments) {
                                                                    %>
                                                                    <option value="<%= department.getId() %>"><%= department.getName() %></option>
                                                                    <%
                                                                        }
                                                                    }
                                                        %>
                                            </select>
                           </div>
                           <div class="d-flex justify-content-center mt-3">
                                 <button class="btn btn-primary" type="submit">Update</button>
                           </div>
                        </form:form>
                        <div class="center">
                                  <a href="/courses/display"> Back to Course display</a>
                        </div>
                    </div>
                </div>
            </div>
</body>
</html>
