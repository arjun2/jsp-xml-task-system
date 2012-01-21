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
<%@ include file="header.jsp" %>
</head>
<body style="background-color:#523127;">
<table cellpadding="0" cellspacing="0" width="100%">
	<tr>
	<td style="background-color:#F26D20;">
		<img src="Images/new_rit_logo_msg.png" />	
	</td>
	<td style="background-color:#F26D20;">
	</td>
</tr>
<tr syle="background-color:#AA5500;">
	<td>
		Welcome, 
	</td>
</tr>
</table>

<table width="100%" border="1">
<tr>
	<td>
		
	</td>
</tr>
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