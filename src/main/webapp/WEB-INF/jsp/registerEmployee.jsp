<%@ include file="nav.jsp" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <title>Employee Registration</title>
     <script type="text/javascript">
         function validateForm() {
             const age = document.getElementById('age').value;
             const phone = document.getElementById('phoneno').value;
             const email = document.getElementById('email').value;
             const name = document.getElementById('name').value;
             const username = document.getElementById('username').value;
             const password = document.getElementById('password').value;
             const emailPattern = /^[a-zA-Z0-9]+@[a-zA-Z0-9]+\.[a-zA-Z]{2,}$/;;
             const usernamePattern = /^[a-zA-Z0-9]+[0-9]+$/;
             const passwordPattern = /^[A-Z][a-z]+[^a-zA-Z0-9].*[0-9].*$/;
             const phonePattern = /^\d{10}$/;
             const agePattern = /^\d+$/;
             const ageNumber = parseInt(age, 10);
             if (!emailPattern.test(email)) {
                 alert('Please enter a valid email address.');
                 return false;
             }
             if (name === "" || /\d/.test(name)) {
                 alert('Name cannot be empty and digits.');
                 return false;
             }

             if (!usernamePattern.test(username)) {
                 alert('Username can only contain alphanumeric characters.');
                 return false;
             }
              if (!agePattern.test(age) || !Number.isInteger(ageNumber) || ageNumber < 0 || ageNumber > 120) {
                     alert('Please enter a valid age (an integer between 0 and 120).');
                     return false;
                 }
                 if (!phonePattern.test(phone)) {
                     alert('Please enter a valid phone number (exactly 10 digits).');
                     return false;
                 }

             if (!passwordPattern.test(password)||password === ""||password.length < 8) {
                 alert('Password must be at least 8 characters long, should contain atleast 1 special character,1 Uppercase, 1 Lowercase and 1 number ');
                 return false;
             }
             alert("Registered Successfully");
             return true;
         }

     </script>
</head>
<body>
<div class="container">
    <div class="row justify-content-center align-items-center vh-100">
            <div class="col-md-6">
                <div class="card">
                    <div class="card-header text-center">
                    <h3>Staff Registration</h3>
                    </div>
                <div class="card-body">

                    <form:form modelAttribute="employee" action="/employee/register" method="post" onsubmit="return validateForm()">
                    <div class="row mb-3">
                     <div class="col-md-6">
                     <label for="name" class="form-label">Name</label>
                     <input type="text" class="form-control" id="name" name="name" >
                     </div>
                     <div class="col-md-6">
                     <label for="username" class="form-label">Username</label>
                     <input type="text" class="form-control" id="username" name="username">
                     </div>
                    </div>
                    <div class="row mb-3">
                     <div class="col-md-6">
                     <label for="age" class="form-label">Age</label>
                     <input type="age" class="form-control" id="age" name="age">
                     </div>
                     <div class="col-md-6">
                     <label for="email" class="form-label">Email</label>
                     <input type="email" class="form-control" id="email" name="email">
                     </div>
                     <div class="col-md-6">
                     <label for="phoneno" class="form-label">Phone No.</label>
                     <input type="phoneno" class="form-control" id="phoneno" name="phoneno">
                     </div>
                     <div class="col-md-6">
                     <label for="designation" class="form-label">Designation:</label>
                     <select id="designation" name="designation" class="form-select">
                             <option selected value="">Choose...</option>
                             <option value="HOD">HOD</option>
                             <option value="AP1">AP1</option>
                             <option value="AP2">AP2</option>
                             <option value="AP3">AP3</option>
                             <option value="AP4">AP4</option>
                     </select>
                     </div>
                    </div>

                    <div class="row mb-3">
                   <div class="col-md-6">
                     <label for="course" class="form-label">Course</label>
                     <form:select path="${course.name}" class="form-select" id="course" name="course">
                                <option selected>Choose course</option>
                                <form:options items="${courses}" itemValue="name" itemLabel="name" />
                     </form:select>
                   </div>
                    <div class="col-md-6">
                          <label for="department" class="form-label">Department</label>
                          <form:select path="${department.name}" class="form-select" id="department" name="department">
                                      <option selected>Choose department</option>
                                      <form:options items="${departments}" itemValue="name" itemLabel="name" />
                          </form:select>
                    </div>
                   </div>

                    <div class="row mb-3">
                     <div class="col-md-6">
                     <label for="password" class="form-label">Password</label>
                     <input type="password" class="form-control" id="password" name="password">
                     </div>
                    </div>
                     <div class="col-12 text-center">
                     <button type="submit" class="btn btn-primary me-2">Register</button>
                     </div>
                     </form:form>
                     </div>
                     </div>
                     </div>
                     </div>
                     </div>
    </form>
</body>
</html>