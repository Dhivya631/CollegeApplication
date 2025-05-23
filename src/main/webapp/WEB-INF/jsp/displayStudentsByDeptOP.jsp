<%@ include file="nav.jsp" %>
<%@ page import="java.sql.*" %>
<%@ page import="org.example.config.DatabaseConfig" %>
<%@ page import="org.example.entity.Department" %>

<!DOCTYPE html>
<html>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" varStatus="status">
    <title>Display Students</title>
    <style>
        h2{
            font-family: Times New roman;
        }
        table, th, td {
            border: 1px solid;
            font-family: Times New roman;
            font-size: 19px;
            width: 300px;
            height:20px;
        }
        body{
            text-align: center;
            margin-top:50px;
        }
        .container{
            justify-content: center;
        }
        .head{
            font-weight: bold;
            background-color: #949494;
        }
    </style>
</head>

<body>
    <br>
    <h2>Students Under ${departmentName} Department</h2><br>
    <form method="post">
        <table border="2" class="container">
        <tr class="head">
            <td>ID</td>
            <td>Name</td>
            <td>Username</td>
            <td>Email</td>
            <td>Semester</td>
           <td>Action</td>
        </tr>
        <%

            try
            {
                String dept = (String) request.getAttribute("departmentName");
                String query="select student.id as id,student.name as name,student.email as email,student.username as username,student.semester as semester from student join department on student.department = department.name where department.name = '" + dept +"'";
                Connection conn=DatabaseConfig.getConnection();
                Statement stmt=conn.createStatement();
                ResultSet rs=stmt.executeQuery(query);
                while(rs.next())
                {
        %>
        <tr>
        <td><%=rs.getInt("id") %></td>
        <td><%=rs.getString("name") %></td>
        <td><%=rs.getString("username") %></td>
        <td><%=rs.getString("email") %></td>
        <td><%=rs.getString("semester") %></td>
        <td>
        <a href="/students/edit/<%=rs.getInt("id") %>" class="btn btn-primary">Edit</a>
        <a href="/students/delete/<%=rs.getInt("id") %>" class="btn btn-danger" onclick="return confirm('Are you sure you want to delete this student?')">Delete</a>
        </td>
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
        <br>
        <a href="/displayStudentsByDept">Back</a>
</form>
</body>
</html>