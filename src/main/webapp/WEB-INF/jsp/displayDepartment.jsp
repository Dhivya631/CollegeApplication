<%@ include file="nav.jsp" %>
<%@ page import="java.sql.*" %>
<%@ page import="org.example.config.DatabaseConfig" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" varStatus="status">
    <title>Display Departments</title>
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
    <h2>Display Departments</h2><br>
    <form method="post">
        <%Boolean isAdmin = (Boolean)request.getAttribute("isAdmin");%>
        <table border="2" class="container">
        <tr class="head">
            <td>ID</td>
            <td>Name</td>
            <td>Description</td>
            <% if(isAdmin && isAdmin != null){%>
                    <td>Action</td>
            <%}%>
        </tr>
        <%
            try
            {
                String query="select * from department";
                Connection conn=DatabaseConfig.getConnection();
                Statement stmt=conn.createStatement();
                ResultSet rs=stmt.executeQuery(query);
                while(rs.next())
                {
        %>
        <tr>
        <td><%=rs.getInt("ID") %></td>
        <td><a href="/departments/<%=rs.getString("name").toLowerCase() %>"><%=rs.getString("name") %></a></td>
         <td><%=rs.getString("Description") %></td>
                        <% if(isAdmin && isAdmin != null){%>

        <td>
            <a href="/departments/edit/<%=rs.getInt("ID")%>" class="btn btn-primary">Edit</a>
            <a href="/departments/delete/<%=rs.getInt("ID")%>" class="btn btn-danger">Delete</a>
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
        <% if(isAdmin && isAdmin != null) {
        %>
        <a href="/adminDash" class="btn btn-info" role="button">Back to admin page</a>
        <%
        }
        else if(request.getAttribute("employeeid")!=null){
        %>
        <a href="/employee/employeeDashboard?id=${employeeid}" class="btn btn-info" role="button">Back to Employee Dashboard</a>
        <% }
        else{
        %>
        <a href="/departments" class="btn btn-info" role="button">Back to home</a>
        <%}%>
</form>
</body>
</html>