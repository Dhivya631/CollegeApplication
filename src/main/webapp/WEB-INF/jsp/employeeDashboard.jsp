<%@ include file="nav.jsp" %>
<%@ page import="java.sql.*" %>
<%@ page import="org.example.config.DatabaseConfig" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" varStatus="status">
    <title>Staff Details</title>
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
    <h2>Staff Personal Details</h2><br>
    <form action="/employeedetails/${employee.employeeid}" method="get">
    <input type="hidden" name="id" value="${employee.employeeid}">
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
            <td>Action</td>

        </tr>
        <%
            try
            {
                Long employeeId = (Long)request.getAttribute("id");
                System.out.println(employeeId);
                String query="select * from employee where employeeid =?" ;
                Connection conn=DatabaseConfig.getConnection();
                PreparedStatement stmt=conn.prepareStatement(query);
                stmt.setLong(1,employeeId);
                ResultSet rs=stmt.executeQuery();
                while(rs.next())
                {
        %>
        <tr><td><%=rs.getInt("employeeid") %></td>
        <td><%=rs.getString("name") %></td>
        <td><%=rs.getString("username") %></td>
        <td><%=rs.getLong("phoneno") %></td>
        <td><%=rs.getString("email") %></td>
        <td><%=rs.getInt("age") %></td>
        <td><%=rs.getString("course") %></td>
        <td><%=rs.getString("department") %></td>
        <td><a href="/employee/update/<%=rs.getInt("employeeid")%>" class="btn btn-primary">Edit</a></td>


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
       <a href="/students?isAdmin=false&id=${employee.employeeid}" class="btn btn-info" role="button">View all Students</a>
       <a href="/departments/display?isAdmin=false&id=${employee.employeeid}" class="btn btn-info" role="button">View all Departments</a>
       <a href="/courses/display?isAdmin=false&id=${employee.employeeid}" class="btn btn-info" role="button">View all Courses</a>
       <a href="${pageContext.request.contextPath}/employee/login" class="btn btn-info" role="button">Back to login Page</a>



</form>

</body>
</html>