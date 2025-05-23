<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ include file="nav.jsp" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
    <title>Create Department</title>
    <style>
        h2{
            font-family:Times New Roman;
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
                        <h2>Create Department</h2>
                    </div>
                    <div class="card-body">
                        <form action="/departments" method="post">
                            <div class="form-group">
                                      <label for="name">Name:</label>
                                      <input type="text" class="form-control" id="name" name="name" required>
                            </div>
                             <div class="form-group">
                                      <label for="description">Description:</label>
                                      <input type="text" class="form-control" id="description" name="description" required>
                             </div>
                             <div class="d-flex justify-content-center mt-3">
                                      <button class="btn btn-primary" type="submit">Create</button>
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
                        </form>
                        <div class="center">
                            <a href="/adminDash">Back to Admin Dashboard</a>
                        </div>
                    </div>
                </div>
      </div>
</body>
</html>