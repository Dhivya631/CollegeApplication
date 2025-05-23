<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.List" %>
<%@ page import="org.example.entity.Department" %>
<%@ include file="nav.jsp" %><br>
<!DOCTYPE html>
<html>
<head>
    <title>Create Course</title>
    <style>
        h2{
            font-family: Times New Roman;
            text-align: center;
        }
        .col-md-4{
            height:80vh;
        }
         .center{
                    text-align: center;
         }
    </style>
</head>
<body>
    <div class="row justify-content-center align-items-center vh-100">
            <div class="col-md-4">
                <div class="card">
                    <div class="card-header text-center">
                    <h2>Create Course</h2>
                </div>
                <div class="card-body">
                    <form action="/courses/create" method="post">
                        <div class="form-group">
                                      <label for="name">Course Name:</label>
                                      <input type="text" class="form-control" id="name" name="name" required>
                        </div>
                        <div class="form-group">
                                      <label for="description">Description:</label>
                                      <input type="text" class="form-control" id="description" name="description" required>
                        </div>
                        <div class="form-group">
                                      <label for="credit">Credit:</label>
                                      <input type="text" class="form-control" id="credit" name="credit" required>
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
                             <button class="btn btn-primary" type="submit">Create</button>
                       </div>
                    </form>
                </div>
                <div class="center">
                     <a href="/adminDash">Back to Admin Dashboard</a>
                </div>
            </div>
        </div>

    </body>
</html>