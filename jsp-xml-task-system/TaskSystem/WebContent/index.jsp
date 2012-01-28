<?xml version="1.0" encoding="ISO-8859-1" ?>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%
session.setAttribute("user","");

%>
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
<body style="background-color:#523127;font-family: Arial, Helvetica, sans-serif;">
<table cellpadding="0"  cellspacing="0" width="100%" align="center" style="background-color:white;vertical-align:top;">
	<tr>
	<td style="background-color:#F26D20;">
		<img src="Images/website_logo_XML.png" />	
	</td>
	<td style="background-color:#F26D20;">
	</td>
</tr>

</table>
&nbsp;
<table align="center" width="50%" cellpadding="0" cellspacing="0">
	<tr style="background-color:#AA5500;">
		<td>
			&nbsp;
		</td>
	</tr>
	<tr>
		<td align="center">
			<div style="background-color: #FFFF66;">
				<table  width="100%">
					<tr align="center">
						<td height="5%">
							<p><strong>Welcome users</strong></p>
						</td>
					</tr>
					
					<tr>
						<td align="center">
						
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
											<td align="center" colspan="2">
												
												<label style="color:red;">
												
												<% if (request.getParameter("error")!=null){ %>
												<%= request.getParameter("error") %> <% } %>
												</label>		
											</td>
									</tr>
									<tr>
										<td>&nbsp;</td>
										<td> <input type="submit" name="submit" value="Login" />&nbsp;&nbsp;&nbsp;<input type="submit" name="submit" value="Register" /></td>
							
									</tr>
							
								</table>
									
							</form>
						
						
						</td>
					</tr>
					
				</table>
				
			</div>
		
		</td>
	</tr>
	<tr style="background-color:#AA5500;">
		<td>
			&nbsp;
		</td>
	</tr>


</table>


</body>
</html>