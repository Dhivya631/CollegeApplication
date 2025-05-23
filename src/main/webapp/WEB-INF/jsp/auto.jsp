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
    <title>Auto Department</title>
    <!-- Include Bootstrap CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        .department-overview {
            display: flex;
            align-items: center;
            height: 100vh;
        }
        .overview-image img {
            max-width: 100%;
            height: auto;
        }
        .hod-image img{
            margin-left:100px;
            max-width:100%;
            height:auto;
        }
        .hod-content{
            padding:8px;
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
            background-image: url('${pageContext.request.contextPath}/img/cse.jpg');
            background-repeat: no-repeat;
            background-size: cover;
            padding:20px;
            color:white;
            height:90px;
            margin-top:55px;
        }
        h3{
            font-family:Times New Roman;
            font-weight:bold;
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
                              font-weight: bold;
                              background-color: #949494;
        }
        .center{
                              text-align:center;
         }
         table, th, td {
                               margin-left: auto;
                               margin-right: auto;
                               border: 0px;
                               font-family: Times New roman;
                               font-size: 20px;
                               width: 500px;
                               height:20px;
         }
         .cont{
                              padding:10px;
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
            font-family: Times New Roman;
         }
    </style>
</head>
<body>
    <div class="heading">
         <h2>Automobile Engineering</h2>
    </div>
    <div class="container department-overview">
        <div class="row">
            <div class="col-md-6 overview-text">
                <h3>Overview</h3>
                <p>The department Automobile Engineering was established in the year 2012 with NBA & NAAC accreditations and ISO certification. The focus is to consistently pursue in providing innovative and quality training to the talented and dedicated students, to empower them in engineering the development of national economy, specialized in transport sector. The department has well qualified and well experienced faculty members to meet the present day curriculum requirements both in theory and practical.</p>
            </div>
            <div class="col-md-6 overview-image">
                <img src="${pageContext.request.contextPath}/img/auto.jpg" alt="Image" width="500px">
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
                                                                        String query="select employee.name as ename from employee join department on employee.employeeid=department.hod where department.name='Auto'";
                                                                        Connection conn=DatabaseConfig.getConnection();
                                                                        Statement stmt=conn.createStatement();
                                                                        ResultSet rs=stmt.executeQuery(query);
                                                                         while (rs.next()) {
                                                                                String hod = rs.getString("ename");
                                        %>
                                                                        <tr>
                                                                            <h4><td><%= hod %></td></h4>
                                                                        </tr>
                                                                        <%
                                                                            }
                                                                            rs.close();
                                                                            stmt.close();
                                                                            conn.close();
                                                                        } catch (Exception e) {
                                                                            e.printStackTrace();
                                                                        }
                                                                        %>
                    <p>Our department was established to provide well qualified industry ready engineers in the field of Automobile Engineering. The Department has a team of highly qualified, experienced and dedicated faculty members in diversified streams to cater for all-round development of students. Indian automotive industry is growing at a very fast rate with newer designs of automobiles and change in technologies. This will be a way for moulding our students for a bright future.</p>
            </div>
        </div>
    </div><br>
    <div class="cont">
                                                      <h2>Courses and Faculty</h2><br>
                                                      <div class="center">
                                                      <button class="btn btn-primary" onclick="myform()">Courses</button>
                                                      <button class="btn btn-danger" onclick="myfaculty()">Faculty</button>
                                                      <button class="btn btn-success" onclick="myfee()">Fees</button><br><br>
                                                      <div id="form" style="display:none;">
                                                                  <table border="2" class="tb">
                                                                  <tr class="head">
                                                                      <td>CourseName</td>
                                                                  </tr>
                                                                  <%
                                                                      try
                                                                      {
                                                                          String query="select name from course where department_id=4";
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
                                                                                      String query="select e.name,e.course from employee e where e.department='Auto'";
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
                                                                                              <td>B.E. Automobile Engineering</td>
                                                                                              <td>3,50,000</td>
                                                                                              <td>2,00,000</td>
                                                                                              <td>5,50,000</td>
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