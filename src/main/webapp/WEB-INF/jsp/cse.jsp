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
    <title>Department Overview</title>
    <!-- Include Bootstrap CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        .department-overview {
            display: flex;
            align-items: center;
            height: 100vh;
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
          font-weight: bold;
        }
        .heading{
           font-family:Times New Roman;
           margin-top:80px;
        }
        h3{
           font-family:Times New Roman;
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
       h4{
            font-family:Times New Roman;
       }
       .cont{
        font-family: Times New Roman;
        padding:20px;
        font-size:18px;
       }
       .center{
            text-align:center;
       }
       .buttondef{
            text-align:center;
            background-color: #e9ecef;
            padding:50px;
       }
       .table-container{
            display:none;
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
    </style>
</head>
<body>
    <div class="heading">
             <h2>Computer Science Engineering</h2>
    </div>
    <div class="container department-overview">
        <div class="row">
            <div class="col-md-6 overview-text">
                <h3>Overview</h3>
                <p>Department of Computer Science and Engineering aims to produce computing graduates with high potency, apply, design and develop systems to pertain and to integrate both software and hardware devices, utilize modern approaches in programming and problem solving techniques.</p>
                <p>The Department was established in the year 1995 with the main objective of providing quality education in the field of Engineering. It is recognized as nodal centre under Anna University. The Department has proved to be a centre of excellence in Academic, Sponsored research and Continuing Education Programme.</p>
            </div>
            <div class="col-md-6 overview-image">
                <img src="${pageContext.request.contextPath}/img/csebg.jpg" alt="Image" width="500px">
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
                                                     String query="select employee.name as ename from employee join department on employee.employeeid=department.hod where department.name='CSE'";
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
                    <p>Professor and Head, Dept of Computer Science & Engg</p>
                    <p>Department of Computer Science and Engineering established in 1995 with an intake of 100 to impart quality education with stated vision and mission. We train and educate engineers of outstanding ability who can become leaders in their profession.</p>
            </div>
        </div>
    </div><br>
    <div class="cont">
        <ul><h2>Programme Overview</h2></ul><br>
        <li>The Department of Computer Science and Engineering was established in the year of 1995 with the main objective of providing quality education in the field of Engineering.</li>
        <li>Recognized as nodal centre under Anna University.</li>
        <li>Proved to be a centre of excellence in Academic, Sponsored research and Continuing Education Programmes.</li>
        <li>Offers course on Under Graduate and Post Graduate Programme in Engineering.</li>
         <li>Equipped with the state-of-the art laboratories. It has a dedicated team of faculty
            members with 4 professors, 5 Associate Professors and 30 Assistant Professors.
            Accredited by NBA-AICTE in the year 2019 for 3 years (2002 for 3 years, 2007 for 3 years,2012 for 2 years, 2016 for 3 years).</li>
        </ul>
    </div>
    <div class="container-fluid hod-section">
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
                                String query="select name from course where department_id=1";
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
                                            String query="select e.name,e.course from employee e where e.department='CSE';";
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
                                        <td>B.E. Computer Science & Engineering</td>
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