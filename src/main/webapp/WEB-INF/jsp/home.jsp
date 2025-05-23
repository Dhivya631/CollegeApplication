<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ include file="nav.jsp" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <title>Home</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>
    <style>
        body{
            margin-top:46px;
        }
        .carousel-caption{
            margin-right:50px;
            margin-left:50px;
            right:0;
            left:auto;
            top:50%;
            transform: translateY(-50%);
            background-color: rgba(255,255,255,0.8);
            padding:20px;
            border-radius:5px;
            color:black;
            text-align:center;
        }
       .carousel-item {
           width: 100%;
           height: 600px; /* Adjust height as needed */
           background-size: cover;
           background-position: center;
       }
       .carousel-item .nested-image
        {
            position: absolute;
            top: 65%; left: 40%;
            transform: translate(-70%, -80%);
            max-width: 80%; /* Adjust size as needed */
            height: auto;
        }
          .stats-container {
              display: flex;
              flex-wrap: wrap;
              gap: 20px;
              justify-content: center;
          }
          .stat-box {
                border: 1px solid #ccc;
                border-radius: 10px;
                padding: 20px;
                width: 150px;
                text-align: center;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                background-color: #f9f9f9;
            }
            .stat-box h6 {
                margin: 10px 0;
            }
            .stat-box p {
                font-size: 1.2em;
                font-weight: bold;
            }
            .card{
                width:370px;
                margin:25px;
            }
            .login-container{
                display:flex;
                align-items:center;
                justify-content:center;
                height:80%;
            }
            .card-header{
                font-family:Times New Roman;
            }
    </style>
</head>
<body>
<div id="carouselExampleCaptions" class="carousel slide" data-ride="carousel">
        <ol class="carousel-indicators">
          <li data-target="#carouselExampleCaptions" data-slide-to="0" class="active"></li>
          <li data-target="#carouselExampleCaptions" data-slide-to="1"></li>
          <li data-target="#carouselExampleCaptions" data-slide-to="2"></li>
          <li data-target="#carouselExampleCaptions" data-slide-to="3"></li>
        </ol>
        <div class="carousel-inner">
          <div class="carousel-item active">
                <img src="${pageContext.request.contextPath}/img/department.jpg" class="d-block w-100" alt="...">
                <div class="carousel-caption d-none d-md-block">
                  <h5>About</h5>
                  <p>XYZ is extensive search engine for the students, parents, and education industry players who are seeking information on higher education sector in India and abroad. One can rely on Collegedunia.com for getting most brief and relevant data on colleges and universities</p>
                </div>
          </div>
          <div class="carousel-item" style="background-image: url('${pageContext.request.contextPath}/img/bg4.jpg');">
           <img src="${pageContext.request.contextPath}/img/bg3.jpg" class="nested-image" alt="Nested Image">
          </div>
        <div class="carousel-item" style="background-image: url('${pageContext.request.contextPath}/img/bg9.jpg');">
            <div class="carousel-caption d-none d-md-block">
                 <h5>Statistics</h5>
                 <div class="stats-container">
                        <div class="stat-box">
                           <div>
                                <h6>Students</h6>
                                <p>${studentsCount}</p>
                           </div>
                        </div>
                        <div class="stat-box">
                           <div>
                               <h6>Employee</h6>
                               <p>${employeeCount}</p>
                           </div>
                        </div>
                        <div class="stat-box">
                           <div>
                                <h6>Courses</h6>
                                <p>${coursesCount}</p>
                           </div>
                        </div>
                        <div class="stat-box">
                           <div>
                                <h6>Departments</h6>
                                <p>${departmentsCount}</p>
                           </div>
                        </div>
                 </div>
            </div>
        </div>
        <div class="carousel-inner">
                    <div class="carousel-item" style="background-image: url('${pageContext.request.contextPath}/img/auto1.jpg');">
                        <div class="carousel-caption d-none d-md-block login-container">
                            <div class="container">
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="card">
                                            <div class="card-header text-center">
                                                <h3>Admin Login</h3>
                                            </div>
                                            <div class="card-body">
                                                <form action="/adminlogin" method="post">
                                                    <div class="form-group">
                                                        <label for="adminEmail" class="form-label">Enter Email</label>
                                                        <input type="email" id="adminEmail" name="email" class="form-control" required>
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="adminPassword" class="form-label">Enter Password</label>
                                                        <input type="password" id="adminPassword" name="password" class="form-control" required>
                                                    </div>
                                                    <div class="d-flex justify-content-center mt-3">
                                                        <button type="submit" class="btn btn-primary">Login</button>
                                                    </div>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="card">
                                            <div class="card-header text-center">
                                                <h3>Student Login</h3>
                                            </div>
                                            <div class="card-body">
                                                            <form action="/login" method="post" modelAttribute="student">
                                                                <div class="form-group">
                                                                  <label for="email" class="form-label">Enter Email</label>
                                                                  <input type="text" id="email" class="form-control" name="email" required>
                                                                </div>
                                                                <div class="form-group">
                                                                  <label for="password" class="form-label">Enter Password</label>
                                                                  <input type="text" id="password" class="form-control" name="password" required>
                                                                </div><br>
                                                                <div class="row">
                                                                      <div class="col-6 text-center">
                                                                            <button type="submit" class="btn btn-primary me-2">Login</button>
                                                                      </div>
                                                                      <div class="col-6 text-center">
                                                                            <a class="btn btn-danger me-2" href="/register">Register</a>
                                                                      </div>
                                                               </div>
                                                            </form>
                                            </div>
                                        </div>
                                    </div>
                                 </div>
                            </div>
                        </div>
                    </div>
        </div>
        <a class="carousel-control-prev" href="#carouselExampleCaptions" role="button" data-slide="prev">
          <span class="carousel-control-prev-icon" aria-hidden="true"></span>
          <span class="sr-only">Previous</span>
        </a>
        <a class="carousel-control-next" href="#carouselExampleCaptions" role="button" data-slide="next">
          <span class="carousel-control-next-icon" aria-hidden="true"></span>
          <span class="sr-only">Next</span>
        </a>
      </div>
</body>
</html>
