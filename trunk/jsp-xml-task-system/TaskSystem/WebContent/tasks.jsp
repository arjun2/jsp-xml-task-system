<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.List" %>
<%@ page import="org.w3._1999.xhtml.TaskType" %>
<%@ page import="project.tasksystem.TaskSystemAPI" %>

<%@ include file="header.jsp" %>
<%
if (username.equals("")){
	response.sendRedirect("index.jsp");
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Advanced online task system</title>


<script type="text/javascript">

function editTextBox(oName)
{
		if(oName='Name')
			{
				var oTemp=document.getElementById('txtBoxName');
				document.getElementById('txtBoxName').value='';
			}
		
		
}
</script>
</head>
<body style="background-color:#523127;">
<table cellpadding="0" cellspacing="0" width="80%" align="center" style="background-color:white">
	<tr>
	<td style="background-color:#F26D20;">
		<img src="Images/website_logo_XML.png" />	
	</td>
	<td style="background-color:#F26D20;">
	</td>
</tr>
<tr style="background-color:#AA5500;">
	<td>
		Welcome, <%=username %>
	</td>
	<td align="right">
		<button onClick="window.location='index.jsp'" value="logout" name="logoutbtn" type="button" 
		style="background-color:transparent;border-style: none;cursor:auto;"><u>Logout</u>
		</button>
		
	</td>
</tr>
<tr>
	<td>
		&nbsp;
	</td>
</tr>

<tr>
	<td>&nbsp;</td>
	<td align="right"> 
		Search:
		<input type="text" width="200px" />
		
	</td>
</tr>
<tr>
	<td colspan="3">
		<table width="100%" border="1" style="border-width:2px;">
			<tr>	
				<!-- <td>
					ID
				</td> -->
				<td>
					Actions
				</td>
				<td>
					Task Name
				</td>
				<td>
					Date
				</td>
				<td>
					Priority
				</td>
				<td>
					Depends On
				</td>
				<!-- <td>
					Share
				</td> -->
			</tr>
			<%
			if (!username.equals("")){
			
			List<TaskType> userTasksList = TaskSystemAPI.getUsersTasks(username); 
			for(TaskType t : userTasksList){ %>
			<tr>
			<%-- <td>
				 <%=t.getID() %>
			</td> --%>
			<td align="center">
				<table>
					<tr>
						<td>
							<button value="Edit" name="Editbtn" type="button" 
							style="background-color:transparent;border-style: none;cursor:auto;">
							<u>Edit</u>
						</button>
						</td>
						<td>
							<button value="Delete" name="Deletebtn" type="button" 
							style="background-color:transparent;border-style: none;cursor:auto;">
							<u>Delete</u>
						</button>
						</td>
						
					</tr>
				</table>
			</td>			
			<td><%=t.getName() %></td>
			<td>
				
			</td>
			<td><%=t.getPriority() %></td>
			<td>
				
			</td>
			</tr>
			<%} }%>
			<tr>
				<td align="center">
					<button value="Add" name="Addbtn" type="button"
						style="background-color: transparent; border-style: none; cursor: auto;">
						<u>Add</u>
					</button>
				</td>
				<td>
					<input type="text" id="txtBoxName" value="Give a task name" onclick="editTextBox('Name');" style="color:gray;" />
				</td>
			</tr>
		</table>
	</td>
</tr>
</table>


</body>
</html>