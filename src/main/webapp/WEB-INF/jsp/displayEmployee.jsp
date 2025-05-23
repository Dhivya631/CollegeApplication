<%@ include file="nav.jsp" %>
<%@ page import="java.sql.*" %>
<%@ page import="org.example.config.DatabaseConfig" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" varStatus="status">
    <title>Employee List</title>
    <style>
        h2{
            font-family: Times New roman;
        }
        table, th, td {
            border: 1px solid;
            font-family: Times New roman;
            font-size: 18px;
            width: 300px;
            height:20px;
            padding:8px;

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
        }
    </style>
 </head>
 <body>
    <br>
    <h2>Staff List</h2><br>
    <form method="post" action="/setDesignation">
        <%Boolean isAdmin = (Boolean)request.getAttribute("isAdmin");%>
        <table border="2" class="container">
        <tr class="head">
            <td>Staff ID</td>
            <td>Name</td>
            <td>Username</td>
            <td>Phone No.</td>
            <td>Email</td>
            <td>Age</td>
            <td>Course</td>
            <td>Department</td>
            <td>Designation</td>
             <% if(isAdmin){%>
                                                <td>Action</td>
             <%}%>

        </tr>
        <%
            try
            {
                String query="select * from employee";
                Connection conn=DatabaseConfig.getConnection();
                Statement stmt=conn.createStatement();
                ResultSet rs=stmt.executeQuery(query);
                while(rs.next())
                {
        %>
        <tr>
        <td><%=rs.getInt("employeeid") %></td>
        <td><%=rs.getString("name") %></td>
        <td><%=rs.getString("username") %></td>
        <td><%=rs.getLong("phoneno") %></td>
        <td><%=rs.getString("email") %></td>
        <td><%=rs.getInt("age") %></td>
        <td><%=rs.getString("course") %></td>
        <td><%=rs.getString("department") %></td>

        <td>
        <%=rs.getString("designation") %>
        </td>
        <% if(isAdmin){%>
        <td>
            <a href="/employee/update/<%=rs.getInt("employeeid")%>" class="btn btn-primary ">Edit</a>
            <a href="/employee/delete/<%=rs.getInt("employeeid")%>" class="btn btn-danger">Delete</a>
        </td>
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
                    <a href="/adminDash" class="btn btn-info" role="button">Back to admin page</a>
                    <%
                    }
                    else {
                    %>
                    <a href="/employee/employeeDashboard" class="btn btn-info" role="button">Back to Employee Dashboard</a>
                    <% } %>
</form>

</body>
</html>