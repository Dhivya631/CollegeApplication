<%@ include file="nav.jsp" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard</title>
    <style>
        .container{
            font-family: Times New Roman;
            text-align: center;
        }
        .container1{
            padding:100px;
            margin-left:310px;
            display:flex;
        }
        .link{
            color: inherit;  /* Inherit color from parent */
            text-decoration: none; /* Removes underline */
            cursor: auto;  /* Changes hand cursor to auto */
        }
        .card-header{
            text-align: center;
            font-family: Times New Roman;
            background-color: #483D8B;
            color: white;
        }
        .list-group-item{
            text-align: center;
        }
        .content{
            padding:23px;
            margin-left:200px;
        }
        .content1{
            padding:30px;
            margin-left:200px;
        }
        .center{
                    text-align: center;
                    font-family: Times New Roman;
        }
        body{
            margin-top:50px;
        }
    </style>
</head>
<body>
    <div class="container">
          <h2>Welcome to Admin Dashboard</h2>
    </div>
    <div class="content">
    <div class="row">
    <div class="col-sm-6">
    <div class="card" style="width: 18rem;">
      <div class="card-header">
        <h4>Student</h4>
      </div>
      <ul class="list-group list-group-flush">
        <li class="list-group-item"> <a href="/register" class="link">Add Student</a></li>
        <li class="list-group-item"><a href="/students?isAdmin=true&id=${admin.id}" class="link">Display All Students</a></li>
        <li class="list-group-item"><a href="/displayStudentsByDept" class="link">Display Students By Department</a></li>
        <li class="list-group-item"><a href="/displayStudentsBySemester" class="link">Display Students By Semester</a></li>
      </ul>
    </div>
    </div>
    <div class="col-sm-6">
             <div class="card" style="width: 18rem;">
                  <div class="card-header">
                    <h4>Course</h4>
                  </div>
                  <ul class="list-group list-group-flush">
                    <li class="list-group-item"><a href="/courses/create" class="link">Add Course</a></li>
                     <li class="list-group-item"><a href="/courses/display?isAdmin=true&id=${admin.id}" class="link">Display All Courses</a></li>
                    <li class="list-group-item"><a href="/addSemester" class="link">Add Semester</a></li>
                    <li class="list-group-item"><a href="/displayAllSemesterCourses" class="link">Display All Courses By Semester</a></li>

                  </ul>
             </div>
    </div>
    </div>
    </div>
    <div class="content1">
        <div class="row">
          <div class="col-sm-6">
        <div class="card" style="width: 18rem;">
          <div class="card-header">
            <h4>Departments</h4>
          </div>
          <ul class="list-group list-group-flush">
            <li class="list-group-item"> <a href="/departments/create" class="link">Create Departments</a></li>
             <li class="list-group-item"><a href="/departments/display?isAdmin=true&id=${admin.id}" class="link">Display All Departments</a></li>
          </ul>
        </div>
        </div>
        <div class="col-sm-6">
             <div class="card" style="width: 18rem;">
                  <div class="card-header">
                    <h4>Staff</h4>
                  </div>
                  <ul class="list-group list-group-flush">
                    <li class="list-group-item"><a href="/employee/register" class="link">Add Staff</a></li>
                    <li class="list-group-item"><a href="/employee/display?isAdmin=true&id=${admin.id}" class="link">Display All Staffs</a></li>
                    <li class="list-group-item"><a href="/displayStaffsByDept" class="link">Display Staffs By Department</a></li>
                  </ul>
            </div>
            </div>
        </div>
        </div>
        <div class="center">
                 <a class="btn btn-danger" href="/adminlogin">Logout</a><br><br>
          </div>

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

</body>
</html>