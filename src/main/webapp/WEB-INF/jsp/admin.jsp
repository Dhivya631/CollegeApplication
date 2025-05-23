<%@ include file="nav.jsp" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Login</title>
    <style>
        .col-md-4{
            height: 65vh;
        }
    </style>
</head>
<body>
<div class="container">
<div class="row justify-content-center align-items-center vh-100">
        <div class="col-md-4">
            <div class="card">
                <div class="card-header text-center">
                <h3>Admin Login</h3>
                </div>
                <div class="card-body">
                <form action="/adminlogin" method="post" modelAttribute="admin">
                    <div class="form-group">
                      <label for="email" class="form-label">Enter Email</label>
                      <input type="text" id="email" class="form-control" name="email" required>
                    </div>
                    <div class="form-group">
                      <label for="password" class="form-label">Enter Password</label>
                      <input type="text" id="password" class="form-control" name="password" required>
                    </div>
                    <%
                                        String error=(String)request.getAttribute("message"); %>
                                        <%     if(error!=null){
                                        %>
                                        <div style="color:red;"><%=error %></div>
                                        <%
                                              }
                                        %>
                    <div class="d-flex justify-content-center mt-3">
                      <button type="submit" class="btn btn-primary btn-block">Login</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
</div>
</body>
</html>