<%@ include file="nav.jsp" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <title>Login</title>
    <style>
        .center{
        text-align:center;
        }
    </style>
</head>
<body>
<div class="container">
<div class="row justify-content-center align-items-center vh-100">
        <div class="col-md-4">
            <div class="card">
                <div class="card-header text-center">
                <h3>Employee Login</h3>
            </div>
            <div class="card-body">

                <form action="/employee/login" method="post" modelAttribute="employee" >
                <div class="column">
                  </div>
                    <div class="form-group">
                      <label for="email" class="form-label">Enter Email</label>
                      <input type="text" id="email" class="form-control" name="email" required>
                    </div>
                    <div class="form-group">
                      <label for="password" class="form-label">Enter Password</label>
                      <input type="text" id="password" class="form-control" name="password" required>
                    </div><br>
                    <%
                                                                String error=(String)request.getAttribute("error");
                                                                 if(error!=null){
                                                              %>
                                                                  <div style="color:red;"><%=error %></div>
                                                                   <%
                                                                  }
                                                              %>
                     <div class="row">
                                              <div class="col-6 text-center">
                                                    <button type="submit" class="btn btn-primary me-2">Login</button>
                                              </div>
                                              <div class="col-6 text-center">
                                                    <a class="btn btn-danger me-2" href="/employee/register">Register</a>
                                              </div>
                     </div>
                </form>
                <div class="center">
                     <a href="/homedisplay">Back to home</a>
                </div>
            </div>
        </div>
    </div>
</div>
</div>
</body>
</html>
