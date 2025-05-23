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
    <title>EEE Department</title>
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
            background-image: url('${pageContext.request.contextPath}/img/eee.jpg');
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
       h2,h4{
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
         <h2>Electrical and Electronics Engineering</h2>
    </div>
    <div class="container department-overview">
        <div class="row">
            <div class="col-md-6 overview-text">
                <h3>Overview</h3>
                <p>The department of Electrical and Electronics Engineering at Velammal Engineering College with its rich and traditional academic ambiance targets both the theory and the practical applications of engineering and technology to handle global challenges of the present and future scenarios. The department is celebrating 25 years of academic excellence since 1995. All the departmental activities are NBA Accredited since 2002 and also ISO certified. With academic autonomy, it offers variety of courses across a wide spectrum of specialized topics in UG, PG and PhD level under choice-based credit system in concurrence with the modern technological advancements and industrial requirements. The teaching and learning activities are enriched by the highly qualified and well-experienced team of faculty members. The state-of-the-art laboratories and exclusive workstations for students-projects facilitate and support to carry out multi-disciplinary innovative projects. The department is committed to providing the students with the environment to learn, practice and strengthen skills as well as social behaviour to achieve greater success in both their professional and personal life.</p>
            </div>
            <div class="col-md-6 overview-image">
                <img src="${pageContext.request.contextPath}/img/eee2.jpg" alt="Image" width="500px">
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
                    String query="select employee.name as ename from employee join department on employee.employeeid=department.hod where department.name='EEE'";
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
                    <p>In the era of engineering and technology, the role of electrical student engineers is not only to pursue academic excellence but also to motivate and empower to be lifelong learners, critical thinkers, and productive members of an ever-changing global society. In this direction, the department provides an excellent environment for our students and faculties to work with zeal and enthusiasm with an aim to give their best. The department also provides facilities to carry out research in the emerging technology areas. The commitment and passion for learning and teaching by the students as well as faculties will definitely lead our future budding engineers to be industry ready.</p>
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
                                            String query="select name from course where department_id=6";
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
                                                        String query="select e.name,e.course from employee e where e.department='EEE';";
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
                                                                <td>B.E. Electrical and Electronics Engineering</td>
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