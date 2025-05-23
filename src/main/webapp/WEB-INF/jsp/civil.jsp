<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ include file="nav.jsp" %>
<%@ page import="java.sql.*" %>
<%@ page import="org.example.config.DatabaseConfig" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Civil Department</title>
    <!-- Include Bootstrap CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        .department-overview {
            display: flex;
            align-items: center;
            height: 100vh;
        }
        .overview-text {
            padding: 20px;
        }
        .overview-image img {
            max-width: 100%;
            height: auto;
        }
        .hod-image img{
            margin-left:140px;
            max-width:100%;
            height:auto;
        }
        .hod-content{
            padding:20px;
        }
        .hod-section{
            background-color: #e9ecef;
            padding: 50px 0;
        }
        .hod-section row{
             align-items:center;
        }
        h2{
          text-align: center;
        }
        .heading{
            font-family:Times New Roman;
            margin-top:80px;
            background-image: url('${pageContext.request.contextPath}/img/Info.jpg');
            background-repeat: no-repeat;
            background-size: cover;
            padding:20px;
            color:white;
            height:90px;
            margin-top:55px;
        }
        h3{
            font-family:Times New Roman;
        }
        .btn{
              width:200px;
              height:50px;
              font-size:20px;
              font-family:Times New Roman;
              margin-right:100px;
              margin-left:100px;
        }
        .head{
              background-color: #949494;
        }
        h3{
              font-family:Times New Roman;
        }
        .center{
              text-align:center;
        }
        table, th, td {
               margin-left: auto;
               margin-right: auto;
               border: 0px;
               font-family: Times New roman;
               font-style: normal;
               font-size: 20px;
               width: 500px;
               height:20px;
        }
        .cont{
                font-family: Times New Roman;
                padding:20px;
                font-size:18px;
        }
        h2{
            font-family: Times New Roman;
        }
        .feedescription{
                    font-size:20px;
                    font-weight:bold;
                    text-decoration-line: underline;
                    font-family: Times New Roman;
        }
        h4{
            font-family:Times New Roman;
        }

    </style>
</head>
<body>
    <div class="heading">
         <h2>Civil Engineering</h2>
    </div>
    <div class="container department-overview">
        <div class="row">
            <div class="col-md-6 overview-text">
                <h3>Overview</h3>
                <p>Did you know that the construction industry in India is all poised to become the largest employer of the Nation by 2022, with over 72 million employees? Over the next ten years, the country would need approximately 4 million civil engineers on average to cater to the growing real estate and infrastructure demands. But there has been a huge gap between industry expectations and the quality of engineers churned out every year.</p>
                <p>With practical training, the Department of Civil Engineering at Velammal Engineering College takes this challenge head-on and has been a pioneer in delivering industry-ready civil engineers since 2007. With NBA and NAAC accreditations as well as ISO certification, the department is now part of an Autonomous institution, affiliated to Anna University. As the world steps up to build sustainable and resilient communities, we know that our engineers would be there to lead the change.</p>
           </div>
            <div class="col-md-6 overview-image">
                <img src="${pageContext.request.contextPath}/img/civil.jpg" alt="Image" width="500px">
            </div>
        </div>
    </div>
    <div class="container-fluid hod-section">
        <div class="row">
            <div class="col-md-6 hod-image">
                <img src="${pageContext.request.contextPath}/img/bgg.jpg" alt="Head of Department Image">
            </div>
            <div class="col-md-6 hod-content">
                    <h3>Message from HOD</h3>
                    <%
                                                                    try
                                                                     {
                                                                                            String query="select employee.name as ename from employee join department on employee.employeeid=department.hod where department.name='Civil'";
                                                                                            Connection conn=DatabaseConfig.getConnection();
                                                                                             Statement stat = conn.createStatement();
                                                                                             ResultSet rs = stat.executeQuery(query);
                                                                                             while (rs.next()) {
                                                                                                    String hod = rs.getString("ename");
                                                            %>
                                                                                            <tr>
                                                                                                <h4><td><%= hod %></td></h4>
                                                                                            </tr>
                                                                                            <%
                                                                                                }
                                                                                                rs.close();
                                                                                                stat.close();
                                                                                                conn.close();
                                                                                            } catch (Exception e) {
                                                                                                e.printStackTrace();
                                                                                            }
                                                                                            %>
                    <p>We are extremely proud of our role in providing high quality education and hands-on experience to our students. The Civil Engineering Department has earned tremendous reputation for qualitative teaching-learning process, teacher-student interactions, state-of-the-art laboratories and well qualified faculty members, positively contributing to the community through teaching, research and consultancy activities.</p>
            </div>
        </div>
    </div><br>
    <div class="cont">
                                  <h2><b>Courses and Faculty<b></h2><br>
                                  <div class="center">
                                  <button class="btn btn-primary" onclick="myform()">Courses</button>
                                  <button class="btn btn-danger" onclick="myfaculty()">Faculty</button>
                                  <button class="btn btn-success" onclick="myfee()">Fees</button><br><br>
                                  <div id="form" style="display:none;">
                                              <table class="tb">
                                              <tr class="head">
                                                  <td>CourseName</td>
                                              </tr>
                                              <%
                                                  try
                                                  {
                                                      String query="select name from course where department_id=7";
                                                      Connection conn=DatabaseConfig.getConnection();
                                                      Statement stmt=conn.createStatement();
                                                      ResultSet rs=stmt.executeQuery(query);
                                                      while(rs.next())
                                                      {
                                              %>
                                              <tr>
                                              <td><%=rs.getString("name") %></td>
                                              </tr>
                                               <%

                                              }
                                              %>
                                              </table>
                                              <%
                                                  rs.close();
                                                  stmt.close();
                                                  conn.close();
                                              }
                                              catch(Exception e)
                                              {
                                                  e.printStackTrace();
                                              }
                                              %>
                                  </div>
                                   <div id="faculty" style="display:none;">
                                                          <table border="2" class="tb">
                                                          <tr class="head">
                                                              <td>Name</td>
                                                              <td>Course</td>
                                                          </tr>
                                                          <%
                                                              try
                                                              {

                                                                  String query="select e.name,e.course from employee e where e.department='Civil';";
                                                                  Connection conn=DatabaseConfig.getConnection();
                                                                  Statement stmt=conn.createStatement();
                                                                  ResultSet rs=stmt.executeQuery(query);
                                                                  while(rs.next())
                                                                  {
                                                          %>
                                                          <tr>
                                                          <td><%=rs.getString("name") %></td>
                                                           <td><%=rs.getString("course") %></td>
                                                          </tr>
                                                           <%
                                                          }
                                                          %>
                                                          </table>
                                                          <%
                                                              rs.close();
                                                              stmt.close();
                                                              conn.close();
                                                          }
                                                          catch(Exception e)
                                                          {
                                                              e.printStackTrace();
                                                          }
                                                          %>
                                  </div>
                                  <div id="fees" style="display:none;">
                                                  <table border="2" class="tb">
                                                      <tr class="head">
                                                          <th>Type</th>
                                                          <th>Amount (INR)</th>
                                                      </tr>
                                                      <tr>
                                                          <td>Applicable Entrance Fee</td>
                                                          <td>2500</td>
                                                      </tr>
                                                      <tr>
                                                          <td>Admission Fee (One-time, non-refundable)</td>
                                                          <td>60,000</td>
                                                      </tr>
                                                      <tr>
                                                          <td>Refundable Security Deposit (One-time)</td>
                                                          <td>30,000</td>
                                                      </tr>
                                                  </table>
                                                   <p class="feedescription">Annual Tuition Fees and Living Expenses for First Year batch of 2024</p>
                                                  <table border="2" class="tb">
                                                                      <tr class="head">
                                                                          <th>Programm</th>
                                                                          <th>Tuition Fee(INR)</th>
                                                                          <th>Living Charges (INR)</th>
                                                                          <th>Amount (INR)</th>
                                                                      </tr>
                                                                      <tr>
                                                                          <td>B.E. Civil Engineering</td>
                                                                          <td>5,00,000</td>
                                                                          <td>2,00,000</td>
                                                                          <td>7,00,000</td>
                                                                      </tr>
                                                  </table>
                                  </div>
                                  </div>
                          </div>
    <script>
                function myform() {
                               var x = document.getElementById('form');
                               var y = document.getElementById('faculty');
                               var z = document.getElementById('fees');
                               if (x.style.display === "none") {
                                 x.style.display = "block";
                                 y.style.display="none";
                                 z.style.display="none";
                               } else {
                                 x.style.display = "none";
                               }
                 }
                 function myfaculty() {
                                       var x = document.getElementById('form');
                                       var y = document.getElementById('faculty');
                                       var z = document.getElementById('fees');
                                       if (y.style.display === "none") {
                                         y.style.display = "block";
                                         x.style.display="none";
                                         z.style.display="none";
                                       } else {
                                         y.style.display = "none";
                                       }
                 }
                 function myfee() {
                                       var x = document.getElementById('form');
                                       var y = document.getElementById('faculty');
                                       var z = document.getElementById('fees');
                                       if (z.style.display === "none") {
                                                     z.style.display = "block";
                                                     x.style.display="none";
                                                     y.style.display="none";
                                       } else {
                                                     z.style.display = "none";
                                       }
                 }
    </script>
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs"></script>
</body>
</html>