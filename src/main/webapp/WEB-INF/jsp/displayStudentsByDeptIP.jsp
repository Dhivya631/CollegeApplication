<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.List" %>
<%@ page import="org.example.entity.Department" %>
<%@ include file="nav.jsp" %><br>
<!DOCTYPE html>
<html>
<head>
    <title>Display Students By Dept</title>
    <style>
        h2{
            font-family: Times New Roman;
            text-align: center;
        }
        .col-md-4{
            height:80vh;
        }
        body{
            margin-top:50px;
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
                    <h2>View List of Students by Department</h2>
                </div>
                <div class="card-body">
                    <form action="/displayStudentsByDept" method="post">
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
                             <button class="btn btn-primary" type="submit">View Students</button>
                       </div>
                    </form>
                    <div class="center">
                        <a href="/adminDash">Back to AdminPage</a>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>