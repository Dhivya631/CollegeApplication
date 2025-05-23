<%@ include file="nav.jsp" %>
<%@ page import="java.sql.*" %>
<%@ page import="org.example.config.DatabaseConfig" %>
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
    <h2>Display Students</h2><br>
    <form method="post">
        <%Boolean isAdmin = (Boolean)request.getAttribute("isAdmin");%>
        <table border="2" class="container">
        <tr class="head">
            <td>ID</td>
            <td>Name</td>
            <td>Username</td>
            <td>Department</td>
            <td>Email</td>
            <td>Semester</td>
           <% if(isAdmin){%>
                                            <td>Action</td>
           <%}%>
        </tr>
        <%
            try
            {
                String query="select * from student";
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
        <td><%=rs.getString("department") %></td>
        <td><%=rs.getString("email") %></td>
        <td><%=rs.getString("semester") %></td>
        <% if(isAdmin){%>
        <td>
        <a href="/students/edit/<%=rs.getInt("id") %>" class="btn btn-primary">Edit</a>
        <a href="/students/delete/<%=rs.getInt("id") %>" class="btn btn-danger" onclick="return confirm('Are you sure you want to delete this student?')">Delete</a>
                </td>
        </tr>
        <%}%>
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
                                <a href="/adminDash">Back to admin page</a>
                                <%
                                }
                                else {
                                %>

                                <a href="/employee/employeeDashboard?id=${employeeid}" class="btn btn-info" role="button">Back to Employee Dashboard</a>
                                <% } %>
</form>
</body>
</html>