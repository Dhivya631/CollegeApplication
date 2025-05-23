<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ include file="nav.jsp" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Department</title>
    <style>
    h2{
        font-family: Times New Roman;
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
                            <h2>Edit Department</h2>
                        </div>
                        <div class="card-body">
                            <form:form method="post" modelAttribute="department" action="/departments/edit/${department.id}">
                                <form:hidden path="id" />
                                <div class="form-group">
                                              <label for="name">Name:</label>
                                              <form:input path="name" class="form-control" id="name" required="true"/>
                                </div>
                                <div class="form-group">
                                              <label for="description">Description:</label>
                                              <form:input path="description" class="form-control" id="description"/>
                                </div>
                               <div class="d-flex justify-content-center mt-3">
                                     <button class="btn btn-primary" type="submit">Update</button>
                               </div>
                            </form:form>
                            <div class="center">
                                      <a href="/departments/display"> Back to display department</a>
                            </div>
                        </div>
                    </div>
         </div>
</body>
</html>