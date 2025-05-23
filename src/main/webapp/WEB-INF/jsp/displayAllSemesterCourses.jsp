<%@ include file="nav.jsp" %>
<%@ page import="java.sql.*" %>
<%@ page import="org.example.config.DatabaseConfig" %>
<%@ page import="java.util.*" %>
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
    <h2>All Courses Under Semesters of each Department</h2><br>
    <form method="post">
       <table border="2" class="container">
        <tr class="head">
            <td>Department</td>
            <td>Semester</td>
            <td>Course Id</d>
            <td>Courses</td>
        </tr>
        <%

            try
            {
                String query="select department.name as departmentName, semester.name as semesterName,course.id as courseId,course.name as courseName FROM course_semester join semester on semester.id=course_semester.semester_id join department on department.id=semester.department_id join course on course_semester.course_id=course.id group by courseName,semesterName order by departmentName,semesterName";
                System.out.println(query);
                Connection conn=DatabaseConfig.getConnection();
                Statement stmt=conn.createStatement();
                ResultSet rs=stmt.executeQuery(query);

                 // Process the data into a map
                     Map<String, Map<String, List<String[]>>> data = new LinkedHashMap<>();
                     while (rs.next()) {
                         String departmentName = rs.getString("departmentName");
                         String semesterName = rs.getString("semesterName");
                         String courseId = rs.getString("courseId");
                         String courseName = rs.getString("courseName");

                         data.computeIfAbsent(departmentName, k -> new LinkedHashMap<>())
                             .computeIfAbsent(semesterName, k -> new ArrayList<>())
                             .add(new String[]{courseId, courseName});
                     }
                     rs.close();
                     stmt.close();
                     conn.close();
                     // Generate the table rows with rowspan
                     for (Map.Entry<String, Map<String, List<String[]>>> deptEntry : data.entrySet()) {
                         String departmentName = deptEntry.getKey();
                         Map<String, List<String[]>> semesters = deptEntry.getValue();
                         int departmentRowspan = semesters.values().stream().mapToInt(List::size).sum();

                         boolean firstDeptRow = true;
                         for (Map.Entry<String, List<String[]>> semEntry : semesters.entrySet()) {
                             String semesterName = semEntry.getKey();
                             List<String[]> courses = semEntry.getValue();
                             int semesterRowspan = courses.size();

                             boolean firstSemRow = true;
                             for (String[] course : courses) {
                                 out.print("<tr>");
                                 if (firstDeptRow) {
                                     out.print("<td rowspan=\"" + departmentRowspan + "\">" + departmentName + "</td>");
                                     firstDeptRow = false;
                                 }
                                 if (firstSemRow) {
                                     out.print("<td rowspan=\"" + semesterRowspan + "\">" + semesterName + "</td>");
                                     firstSemRow = false;
                                 }
                                 out.print("<td>" + course[0] + "</td>");
                                 out.print("<td>" + course[1] + "</td>");
                                 out.print("</tr>");
                             }
                         }
                     }
                 } catch (Exception e) {
                     e.printStackTrace();
                 }
             %>
</table>
<div style="margin-top:20px;">
<a href="/adminDash">Back</a>
</div>

</form>

</body>
</html>