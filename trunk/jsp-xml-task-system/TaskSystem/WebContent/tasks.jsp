<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.List" %>
<%@ page import="org.w3._1999.xhtml.TaskType" %>
<%@ page import="project.tasksystem.TaskSystemAPI" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%
//this should go in header under session variables
String username="testuser1";
String password="testpassword";

%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Advanced online task system</title>
</head>
<body>
<table>
<%List<TaskType> userTasksList = TaskSystemAPI.getUsersTasks(username); 
for(TaskType t : userTasksList){ %>
<tr>
<td><%=t.getID() %></td>
<td><%=t.getName() %></td>
<td><%=t.getPriority() %></td>
</tr>
<%} %>
</table>
</body>
</html>