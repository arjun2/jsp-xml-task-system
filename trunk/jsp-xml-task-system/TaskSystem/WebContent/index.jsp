<?xml version="1.0" encoding="ISO-8859-1" ?>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
<title>XML Task system login</title>
<style type="text/css">
.auto-style1 {
	text-align: center;
	font-family: Arial, Helvetica, sans-serif;
	font-size: large;
}
</style>

</head>
<body style="background-color: #993300">
<div style="background-color: #FFFF66; font-family: Arial, Helvetica, sans-serif;">
<p class="auto-style1"><strong>XML Online Task System</strong></p>
<% if (request.getParameter("error")!=null){ %>
<p style="color: #FF0000"><%= request.getParameter("error") %></p> <% } %>
<form name="input" action="login.jsp" method="post">
	<table style="width: 300px" align="center">
		<tr>
			<td style="height: 26px">Username:</td>
			<td style="height: 26px"> <input type="text" name="user" /></td>
		</tr>
		<tr>
			<td>Password: </td>
			<td> <input type="password" name="pass" /></td>
		</tr>
		<tr>
			<td>&nbsp;</td>
			<td> <input type="submit" value="Submit" /></td>
		</tr>

	</table>
&nbsp;
</form>
</div>

</body>
</html>