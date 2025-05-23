<%@ include file="nav.jsp" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page import="java.util.List" %>
<%@ page import="org.example.entity.Department" %>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Student</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <script type="text/javascript">
        function validateForm() {
          const email = document.getElementById('email').value;
          const name = document.getElementById('name').value;
          const username = document.getElementById('username').value;
          const password = document.getElementById('password').value;

          const emailPattern = /^[a-zA-Z0-9]+@[a-zA-Z0-9]+\.[a-zA-Z]{2,}$/;
          const usernamePattern = /^[a-zA-Z]+[0-9]+$/;
          const passwordPattern = /^[A-Z][a-z]+[^a-zA-Z0-9][0-9]*$/;

          if (!emailPattern.test(email)) {
            alert('Please enter a valid email address');
            return false;
          }

          if (name.trim() === '' || /\d/.test(name)) {
            alert('Name cannot be empty and should not contain digits.');
            return false;
          }

          if (!usernamePattern.test(username)) {
            alert('Username can only contain alphanumeric characters.');
            return false;
          }

          if (!passwordPattern.test(password) || password === '' || password.length < 8) {
            alert('Password must be at least 8 characters long, should contain atleast 1 special character,1 Uppercase, 1 Lowercase and 1 number ');
            return false;
          }

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
                                <h3>Edit Student </h3>
                                </div>
                            <div class="card-body">

                   <form action="/students/edit/${student.id}" method="post" onsubmit="return validateForm()">
                   <input type="hidden" name="id" value="${student.id}">
                     <div class="row mb-3">
                      <div class="col-md-6">
                     <label for="name" class="form-label">Name</label>
                        <input type="text" class="form-control" id="name" name="name" value="${student.name}" >
                          </div>
                            <div class="col-md-6">
                               <label for="username" class="form-label">Username</label>
                                  <input type="text" class="form-control" id="username" name="username" value="${student.username}">
                            </div>
                            </div>

                <div class="row mb-3">
                   <div class="col-md-6">
                     <label for="password" class="form-label">Password</label>
                        <input type="text" class="form-control" id="password" name="password" value="${student.password}" >
                         </div>
                          </div>
                           <div class="row mb-3">
                              <div class="col-md-6">
                               <label for="department" class="form-label">Department</label>
                               <select id="department" name="department" class="form-select" required>
                               <%
                                    List<Department> departments = (List<Department>) request.getAttribute("departments");

                                    for (Department department : departments) {
                               %>
                               <option value="<%= department.getName() %>"><%= department.getName() %></option>
                                <%
                                     }
                                 %>
                               </select>
                               </div>
                                <div class="col-md-6">
                                       <label for="semester" class="form-label">Semester</label>
                                        <select id="semester" class="form-select" name="semester">
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
                           </div>
                          <div class="row mb-3">
                                 <label for="email" class="form-label">Email</label>
                                     <input type="text" class="form-control" id="email" name="email" value="${student.email}">
                                         </div>
                            <div class="col-12 text-center">
                                <button type="submit" class="btn btn-primary me-2">Update</button>
                            </div>
                       </form>
                </div>
            </div>
        </div>
    </div>
    </div>
</body>
</html>