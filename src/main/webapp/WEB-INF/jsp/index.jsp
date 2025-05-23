<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
    <title>Department</title>
    <style>
        h1{
            font-family: Times New Roman;
        }
        .container{
            font-family: Times New Roman;
        }
    </style>
</head>
<body>
    <%@ include file="nav.jsp" %><br>
    <div class="container">
    <h1>Department Details: </h1>
    <c:forEach items="${department}" var="departments">
        <p>Name: ${departments.name}</p>
        <p>Description: ${departments.description}</p>
        <a href="/departments">Back to Department List</a>
    </c:forEach>
    </div>
</body>
</html>