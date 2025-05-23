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
    <title>Mechanical Department</title>
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
                h3{
                      font-family:Times New Roman;
                      font-weight:bold;
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
                      font-family:Times New Roman;
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
         <h2>Mechanical Engineering</h2>
    </div>
    <div class="container department-overview">
        <div class="row">
            <div class="col-md-6 overview-text">
                <h3>Overview</h3>
                <p>Mechanical Engineering is the only branch of engineering that can fit into any kind of industries, is the oldest engineering disciplines and an extremely diverse profession. Mechanical engineers are inherently multi-disciplinary and having wide range of career choices. Manufacturing has emerged as one of the high growth sectors in India.  Government aims to create 100 million new jobs in the sector in near future.</p>
                <p>The Department of Mechanical Engineering at Velammal Engineering College, Chennai started its journey in the year 1999. We have a strong undergraduate program in mechanical engineering. The Department has a distinguished record in both teaching and research. The Department is committed to provide knowledge creation, innovation and research among the students to meet challenges in Mechanical Engineering Field. The department is one among top 10 colleges offering Mechanical engineering program affiliated to Anna University in terms of academic performance of the students.</p>
                <p>The department is accredited by National Board of Accreditation (NBA), New Delhi. Our Alumni play key role in different industrial, academic and Government organizations. The department providing value based holistic development for each student</p>
            </div>
            <div class="col-md-6 overview-image">
                <img src="${pageContext.request.contextPath}/img/mech.jpg" alt="Image" width="500px">
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
                                                                                            String query="select employee.name as ename from employee join department on employee.employeeid=department.hod where department.name='Mech'";
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
                    <p>The department of Mechanical Engineering is designed to facilitate for teaching and research in the area of Thermal and Energy, Design and Manufacturing, Material Science, Mechatronics, Industrial automation and Industrial Engineering. A highly skilled, well qualified and motivated team of 32 faculty members, including 8 Doctorates and 20 are pursuing Doctorate, imparts quality education to students and support them to reach greater heights. Faculty members support the students to do various industrial projects, innovative projects carried out through funds received from various government agencies like DST New Gen IEDC, Tamilnadu State council for science and technology, Indian Society for Refrigeration and Air Conditioning etc. A separate project lab facility is established to support the students to get various hands on skill, carryout different project work in the curriculum and support to participate various student events. The department regularly organizes events to promote higher studies and entrepreneurship among the students.</p>
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
                                                                String query="select name from course where department_id=5";
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
                                                                            String query="select e.name,e.course from employee e where e.department='Mech';";
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
                                                                                    <td>B.E. Mechanical Engineering</td>
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