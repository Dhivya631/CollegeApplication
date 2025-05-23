<%@ include file="nav.jsp" %>
<%@ page import="java.sql.*" %>
<%@ page import="org.example.config.DatabaseConfig" %>
<%@ page import="org.example.entity.Course" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" varStatus="status">
    <title>Display Courses</title>
    <style>
        h2{
            font-family: Times New roman;
        }
        table, th, td {
            border: 1px solid;
            font-family: Times New roman;
            font-size: 20px;
            width: 300px;
            height:20px;
        }
        body{
            text-align: center;
        }
        .container{
            justify-content: center;
        }
        .head{
            font-weight: bold;
            background-color: #949494;
        }
        body{
            margin-top:50px;
        }
    </style>
 </head>
 <body>
    <br>
    <h2>Display Courses</h2><br>
    <form method="post">
        <%Boolean isAdmin = (Boolean)request.getAttribute("isAdmin");%>
        <table border="2" class="container">
        <tr class="head">
            <td>ID</td>
            <td>Course Name</td>
            <td>Description</td>
            <td>Credit</td>
            <td>Department</td>
            <% if(isAdmin){%>
            <td>Action</td>
            <%}%>
        </tr>
        <%
            try
            {

                String query="select course.rno as rno, course.id as crid,course.name as crname,course.description as crdescription,course.credit as crcredit,department.name as dname from course join department on course.department_id=department.id";
                Connection conn=DatabaseConfig.getConnection();
                Statement stmt=conn.createStatement();
                ResultSet rs=stmt.executeQuery(query);

                while(rs.next())
                {
        %>
        <tr>
        <td><%=rs.getInt("crid") %></td>
        <td><%=rs.getString("crname") %></td>
        <td><%=rs.getString("crdescription") %></td>
        <td><%=rs.getString("crcredit") %></td>
        <td><a href="/departments/<%=rs.getString("dname").toLowerCase() %>"><%=rs.getString("dname") %></a></td>
        <% if(isAdmin){%>
        <td>
            <a href="/courses/edit/<%=rs.getInt("rno")%>" class="btn btn-primary">Edit</a>
            <a href="/courses/delete/<%=rs.getInt("rno")%>" class="btn btn-danger">Delete</a>
        </td>
        <%}%>
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
          <% if(isAdmin) {
                                        %>
                                        <a href="/adminDash" class="btn btn-info" role="button">Back to admin page</a>
                                        <%
                                        }
                                        else {
                                        %>
                                        <a href="/employee/employeeDashboard?id=${employeeid}" class="btn btn-info" role="button">Back to Employee Dashboard</a>
                                        <% } %>
</form>
</body>
</html>