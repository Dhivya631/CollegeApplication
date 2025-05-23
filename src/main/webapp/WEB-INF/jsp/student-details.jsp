<%@ include file="nav.jsp" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <title>Student Dashboard</title>

    <style>
        h2{
            text-align: center;
            font-family: Times New Roman;
        }
        .container{
            text-align: center;
        }
    </style>

</head>
<body>
    <br>

    <h2 class="text-center my-4">Display Student</h2>

    <div class="container d-flex justify-content-center">

  <table class="table table-bordered w-50">
    <tr>
    <td>Name:</td>
    <td>${student.name}</td>
    </tr>
    <tr>
        <td>Username:</td>
        <td>${student.username}</td>
        </tr>
            <tr>
                <td>Department:</td>
                <td>${student.department}</td>
                </tr>
                <tr>
                    <td>Semester:</td>
                    <td>${student.semester}</td>
                    </tr>
                    <tr>
                        <td>Email:</td>
                        <td>${student.email}</td>
                        </tr>
                  <tr>
               <td>Password:</td>
                  <td>${student.password}</td>
                 </tr>
                 <tr>
                                <td>Action:</td>
                                 <td><a href="/students/edit/${student.id}" class="btn btn-primary">Edit</a></td>
                 </tr>
   </table>
   </div>
   <div class="text-center mt-3">
            <a href="/login">Back to login Page</a>
   </div>
</body>
</html>