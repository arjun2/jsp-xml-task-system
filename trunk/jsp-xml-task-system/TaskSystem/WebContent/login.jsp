<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="project.tasksystem.TaskSystemAPI" %>  
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="header.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Login processing</title>
<%
String username = request.getParameter("user");
String password = request.getParameter("pass");
if(TaskSystemAPI.isAuthValid(username,password)){
	session.setAttribute("user",username);
	String redirectURL = "tasks.jsp";
	response.sendRedirect(redirectURL);
}else{
	String invalidAuthentication ="The authentication credentials are invalid";
	response.sendRedirect("index.jsp?error="+invalidAuthentication);
}



%>
</head>
<body>
<% %>
</body>
</html>