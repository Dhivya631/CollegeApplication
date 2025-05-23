<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.List" %>
<%@ page import="org.example.entity.Course" %>
<%@ include file="nav.jsp" %><br>
<!DOCTYPE html>
<html>
<head>
    <title>Display Students By Courses</title>
    <style>
        h2{
            font-family: Times New Roman;
            text-align: center;
        }
        .col-md-4{
            height:80vh;
        }
        body{
            margin-top:50px;
        }
    </style>
</head>
<body>
    <div class="row justify-content-center align-items-center vh-100">
            <div class="col-md-4">
                <div class="card">
                    <div class="card-header text-center">
                    <h2>View List of Students by Semester</h2>
                </div>
                <div class="card-body">
                    <form action="/displayStudentsBySemester" method="post">
                        <div class="col-md-6">
                            <label for="semesterName">Semester : </label><br>
                            <select id="semesterName" name="semesterName" class="form-select" required>
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
                       <div class="d-flex justify-content-center mt-3">
                             <button class="btn btn-primary" type="submit">View Students</button>
                       </div>
                    </form>
                     <a href="/adminDash" class="d-flex justify-content-center mt-3">Back to adminDash</a>
                </div>
            </div>

        </div>

    </body>
</html>