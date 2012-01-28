<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.List" %>
<%@ page import="org.w3._1999.xhtml.TaskType" %>
<%@ page import="project.tasksystem.TaskSystemAPI" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@ include file="header.jsp" %>
<%
if (username == null|| username.equals("")){
	response.sendRedirect("index.jsp");
}
%>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Advanced online task system</title>
<%-- <%@ include file="header.jsp" %> --%>
<style>
.buttonClass{background-color:transparent;border-style:none;text-decoration: underline;}
</style>
<link href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/themes/base/jquery-ui.css" rel="stylesheet" type="text/css"/>
  <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.5/jquery.min.js"></script>
  <script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/jquery-ui.min.js"></script>
 <script src="modifyTasks.js" type="text/javascript"></script>
<script>

$(document).ready(function(){
	$('#txtDate').datepicker({minDate: '+1d'});
	$('#txtBoxName').focus(function(){
		
		$('#txtBoxName').val('');
	});
	$('#txtBoxName').blur(function(){
		if($('#txtBoxName').val() == '')
			$('#txtBoxName').val('Enter Task name');
	});
   $('#txtSearch').focus(function(){
		
		$('#txtSearch').val('');
	});
	$('#txtSearch').blur(function(){
		
		$('#txtSearch').val('Enter Task name');
	});
	$('#Addbtn').click(function(){
		
		var oSendMsg= $('#lblUserName').text() + ',' + $('#txtBoxName').val() + ',';
		oSendMsg+=$('#drpPriority option:selected').text() + ',';
		oSendMsg+= $('#txtDate').val() + ',';
		//oSendMsg+= '01-02-2012' + ',';
		oSendMsg+= $('#drpDependsOn option:selected').val() + ',';
		
		//if($('#drpDependsOn option:selected').text() != '')
			
		oSendMsg+= $('#drpStatus option:selected').val();
		
		//alert(oSendMsg+= $('#txtDate').val() );
		addTask(oSendMsg);
		
		
		
	});
	$('#Addbtn').live('click',function(){
		
		var oTempObject=($('this').parent().parent().clone());
		$('tr:last').after(oTempObject);			
	});
});



	
</script>
</head>
<body style="background-color:#523127;">
<table cellpadding="0"  cellspacing="0" width="80%" align="center" style="background-color:white">
	<tr>
	<td style="background-color:#F26D20;">
		<img src="Images/website_logo_XML.png" />	
	</td>
	<td style="background-color:#F26D20;">
	</td>
</tr>
<tr style="background-color:#AA5500;">
	<td>
		Welcome, <label id="lblUserName"><%= username %></label> 
	</td>
	<td align="right">
		<button value="logout" name="logoutbtn" type="button" onclick="window.location='index.jsp'" 
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
	
	<td align="right" colspan="2"> 
		<table>
			<tr>
				<td align="right">
					Search:
				</td>
				<td>
					<input type="text" width="200px" id="txtSearch" />
				</td>
				
			</tr>
		</table>	
	</td>
</tr>
<tr>
	<td colspan="3">
	<% if(!username.equals("") && username != null)
	{ %>
		<table width="100%" border="1" style="border-width:2px;" id="tblData">
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
				<td>
					Status
				</td>
				<!-- <td>
					Share
				</td> -->
			</tr>
			<%
			List<TaskType> userTasksList = TaskSystemAPI.getUsersTasks(username); 
			for(TaskType t : userTasksList){ %>
			<tr>
			<%-- <td>
				 
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
			<td><%=t.getName() %>
				<label id="lblID" style="display:none;"><%=t.getID() %></label>
			
			</td>
			<td>
				<%=t.getDueDate() %>
			</td>
			<td><%=t.getPriority() %></td>
			<td>
				<%=
				t.getDependsOn()	
				 %>
			</td>
			<td>
			
				<%  if(t.isCompleted()){	 %>
				Completed
				<%}else{ %>
				Incomplete 
				<%} %>
			</td>
			
			</tr>
			<%} %>
			<tr id="trNewRow">
				<td align="center">
					<button value="Add" name="Addbtn" type="button" id="Addbtn"
						style="background-color: transparent; border-style: none; cursor: auto;">
						<u>Add</u>
					</button>
				</td>
				<td>
					<input type="text" id="txtBoxName" value="Enter a Task name"  style="color:gray;" />
				</td>
				<td>
					<input type="text" id="txtDate" 	/>
				</td>
				<td>
					<select id="drpPriority">
						<option>High</option>
						<option>Medium</option>
						<option>Low</option>
					</select>
				</td>
				<td>
					<select id="drpDependsOn">
					<option></option>
					<%List<TaskType> usrTask = TaskSystemAPI.getUsersTasks(username); 
					for(TaskType t : userTasksList){ %>
						<option value='<%=t.getID() %>'><%=t.getName() %></option> 
					<%} %>
					
					</select>
				</td>
				<td>
					<select id="drpStatus">
						<option value='false'>Incomplete</option>
						<option value='true'>Complete</option>
					</select>
					
				</td>
			</tr>
		</table>
		<%} %>
	</td>
</tr>
</table>



</body>
</html>