<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js" integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js" integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF" crossorigin="anonymous"></script>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary fixed-top">
      <a class="navbar-brand" href="#">Engineering College Application</a>
      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <ul class="navbar-nav mr-auto">
          <li class="nav-item active">
            <a class="nav-link" href="/homedisplay">Home</a>
          </li>
        </ul>
          <ul class="navbar-nav ml-auto">
         <li class="nav-item dropdown">
                   <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                     Departments
                   </a>
                   <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
                     <li><a class="dropdown-item"  href="/departments/cse">Computer Science And Engineering</a></li>
                     <li><a class="dropdown-item" href="/departments/eee">Electrical and Electronic Engineering</a></li>
                     <li><a class="dropdown-item" href="/departments/it">Information Technology</a></li>
                     <li><a class="dropdown-item" href="/departments/ece">Electronics and Communication Engineering</a></li>
                     <li><a class="dropdown-item" href="/departments/civil">Civil Engineering</a></li>
                     <li><a class="dropdown-item" href="/departments/mech">Mechanical Engineering</a></li>
                     <li><a class="dropdown-item" href="/departments/auto">Automobile Engineering</a></li>
                   </ul>
          </li>
          <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                        Login
                </a>
                <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
                     <li><a class="dropdown-item" href="/login">Student</a></li>
                     <li><a class="dropdown-item" href="/employee/login">Staff</a></li>
                     <li><a class="dropdown-item" href="/adminlogin">Admin</a></li>
                </ul>
          </li>
           <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                         Register
                </a>
                <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
                       <li><a class="dropdown-item" href="/register">Student</a></li>
                       <li><a class="dropdown-item" href="/employee/register">Staff</a></li>
                </ul>
           </li>

        </ul>
       </div>
    </nav>
</body>
</html>