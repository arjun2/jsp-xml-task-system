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

</style>
<link href="style.css" rel="stylesheet" type="text/css" />
<link href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/themes/base/jquery-ui.css" rel="stylesheet" type="text/css"/>
  <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.5/jquery.min.js"></script>
  <script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/jquery-ui.min.js"></script> 
<script type="text/javascript" src="jquery.tablesorter.js"></script>

  <script type="text/javascript" src="jquery.tablesorter.staticrow.min.js"></script>
 <script src="modifyTasks.js" type="text/javascript"></script>
<script>


function bodyLoad()
{
	
	var oTempDropList=(document.getElementById('drpDependsOn'));
	//alert(oTempDropList.options.length);
	var oBTable=document.getElementById('tblData');
	var rowCount=oBTable.rows.length;
	for(var q=0;q<rowCount-1;q++)
		{
		
			var oCellDepends=oBTable.rows[q].cells[4];
			
			for(var x=0;x<oTempDropList.options.length;x++)
				{
					if(oTempDropList.options[x].value == oCellDepends.innerText)
						{
							oCellDepends.innerText=oTempDropList.options[x].text;
						
						}
					
					if(oCellDepends.innerText == "0" || oCellDepends.innerText == ""||oCellDepends.innerText == "null")
						oCellDepends.innerText="";
				
				}
		
		}
	
	}

$(document).ready(function(){
	//$('#tblData').tablesorter();
	 //$("#tblData").tablesorter(); 
	 //$('#tblData').tablesorter({ widgets: ['zebra','staticRow'] })
	$('#txtDate').datepicker({minDate: '+1d'});
	$('#txtBoxName').focus(function(){
		
		$('#txtBoxName').val('');
	});
	$('#txtBoxName').blur(function(){
		if($('#txtBoxName').val() == '')
			$('#txtBoxName').val('Enter Task name');
	});
//    $('#txtSearch').focus(function(){
		
// 		$('#txtSearch').val('');
// 	});
// 	$('#txtSearch').blur(function(){
		
// 		$('#txtSearch').val('Enter Task name');
// 	});
	$('#Addbtn').click(function(){
		
		var oSendMsg= $('#lblUserName').text() + ',' + $('#txtBoxName').val() + ',';
		oSendMsg+=$('#drpPriority option:selected').text() + ',';
		oSendMsg+= $('#txtDate').val() + ',';
		//oSendMsg+= '01-02-2012' + ',';
		oSendMsg+= $('#drpDependsOn option:selected').val() + ',';
		
		//if($('#drpDependsOn option:selected').text() != '')
			
		oSendMsg+= $('#drpStatus option:selected').val();
		
		//alert(oSendMsg+= $('#txtDate').val() );
		
		var oCheck=$('#txtDate').val();
		if( $('#txtBoxName').val() != "Enter a Task name" || $('#txtBoxName').val() !="")
			{
				if(oCheck!="")
				{
			
					addTask(oSendMsg);
					document.getElementById('txtDate').value="";
					document.getElementById('txtBoxName').value="";
					document.getElementById('drpPriority').selectedIndex=0;
					document.getElementById('drpDependsOn').selectedIndex=0;
					document.getElementById('drpStatus').selectedIndex=0;
					document.getElementById('txtBoxName').focus();
				}
				else
				{
				
					alert('Please provide all details of a task');
					
				}
			}
		else
			{
				alert('Please provide all details of a task');
				//search($('#lblUserName').text() + ",buy a car" );
			}
		
	});
	
// 	$('#Addbtn').live('click',function(){
		
// 		var oTempObject=($('this').parent().parent().clone());
// 		$('tr:last').after(oTempObject);			
// 	});



$('#Editbtn').live('click',function()
{
	alert($(this).closest('tr'));
	});
	
	
});



$.tablesorter.addParser({ 
    // set a unique id 
    id: 'status', 
    is: function(s) { 
        // return false so this parser is not auto detected 
        return false; 
    }, 
    format: function(s) { 
        // format your data for normalization 
        return s.toLowerCase().replace(/complete/,1).replace(/inccomplete/,0); 
    }, 
    // set type, either numeric or text 
    type: 'text' 
}); 
 
$(function() { 
    $("table").tablesorter({ 
        headers: { 
            6: { 
                sorter:'status' 
            } 
        } 
    }); 
});              



function deleteTasks(oID)
{
	//alert('Delete');
	//alert(oID);
	var oDeleteMsg= $('#lblUserName').text() + ','+  oID;
	//alert(oDeleteMsg);
	removeTask(oDeleteMsg);
}
	
function updateTasks()
{
	
	var oSendMsg= $('#lblUserName').text() + ',' + $('#txtBoxName').val() + ',';
	oSendMsg+=$('#drpPriority option:selected').text() + ',';
	oSendMsg+= $('#txtDate').val() + ',';
	//oSendMsg+= '01-02-2012' + ',';
	oSendMsg+= $('#drpDependsOn option:selected').val() + ',';
	
	//if($('#drpDependsOn option:selected').text() != '')
		
	oSendMsg+= $('#drpStatus option:selected').val();
	
	//alert(oSendMsg+= $('#txtDate').val() );
	
	addTask(oSendMsg);
	document.getElementById('txtDate').value="";
	document.getElementById('txtBoxName').value="";
	document.getElementById('drpPriority').selectedIndex=0;
	document.getElementById('drpDependsOn').selectedIndex=0;
	document.getElementById('drpStatus').selectedIndex=0;
	document.getElementById('txtBoxName').focus();	
}
	
function editTasks(id,oTaskID)
{
	//alert('Edit');
	var oTempTable=document.getElementById('tblData');
	var oRowLength=oTempTable.rows.length;
	//alert(id);
	
	
	
	for(var i=0;i<oRowLength;i++)
	{
		var oTRowLength=oTempTable.rows[i].cells.length;
		for(var l=0;l<oTRowLength;l++)
			{
				var oTRow=oTempTable.rows[i];
				var oCell=oTRow.cells[l];
				if(oTRow.cells[l].hasChildNodes())
					{
						var oChecker=oTRow.cells[l].childNodes[0];
						if(oChecker!= undefined)
							if(oChecker.data!= undefined)
								if(oChecker.data.replace(/^\s+|\s+$/g,"") == id)
								{
									var oRowIndexNew=i;
									var oTRow=oTempTable.rows[i];
									var oCell=oTRow.cells[0];
									var element=document.createElement("input");
									 element.type="button";
									 element.value="Update";
									 element.className="buttonClass";
									 
									 element.onclick=function() {
										 
										 updateTasks(oRowIndexNew);
									 };
									 
									 while(oCell.childNodes.length >= 1)
										 {
										   
										 	oCell.removeChild(oCell.firstChild);
										 	
										 }
										 
									 oCell.align="center";
									 oCell.appendChild(element);
									 
									var oCell=oTRow.cells[1];
									
									
									var element=document.createElement("input");
									element.type="text";
									element.value=oCell.innerText;
									var TaskName=oCell.innerText;
									//TaskName=TaskName.split('');
									
									var oLabel=document.createElement("label");
									oLabel.innerText=oTaskID;
									oLabel.style.display="none";
									
									oCell.innerText="";
									oCell.appendChild(element);
									oCell.appendChild(oLabel);
									
									
									var oCell=oTRow.cells[2];
									var element=document.createElement("input");
									element.type="text";
									element.value=oCell.innerText;
									element.setAttribute("class", "DateClass");
									element.setAttribute("onclick","checker()");
									
									
									
									oCell.innerText="";
									oCell.appendChild(element);
									
									
									var oCell=oTRow.cells[3];
									var element=document.createElement("select");
									var elementOption=document.createElement("option");
									elementOption.setAttribute("value","High");
									elementOption.innerText="High";
									var elementOption1=document.createElement("option");
									elementOption1.setAttribute("value","Medium");
									elementOption1.innerText="Medium";
									//("Medium");
									var elementOption2=document.createElement("option");
									elementOption2.setAttribute("value","Low");
									elementOption2.innerText="Low";
									
									
									
									
									
									element.appendChild(elementOption);
									element.appendChild(elementOption1);
									element.appendChild(elementOption2);
									
									
									for(var k=0;k<3;k++)
										{
											if(element.options[k].value == oCell.innerText)
												element.options[k].selected=true;
										}
									
									oCell.innerText="";
									oCell.appendChild(element);
									
									
									var oCell=oTRow.cells[4];
									
									var DependsOnList=document.getElementById("drpDependsOn");
									var element=document.createElement("select");
									
									var oVal= oCell.innerText;
									if(oVal == "null")
										oVal="";
									var oIndex;
									
									
									for(var m=0;m<DependsOnList.options.length;m++)
									{
										
										elementOption1=document.createElement("option");
										elementOption1.setAttribute("value",DependsOnList.options[m].value);
										elementOption1.text=DependsOnList.options[m].text;
										element.appendChild(elementOption1);
									}
									
									for(k=0;k<DependsOnList.options.length;k++)
										{
											if(element.options[k].value == oVal || element.options[k].text == oVal)
												oIndex=k;
											
											if(element.options[k].text == TaskName)
											{							
												
												element.options[k].style.display="none";
											}	
										}
									
									element.selectedIndex=oIndex;
								
									oCell.innerText="";
									oCell.appendChild(element);
									
									var oCell=oTRow.cells[5];
									element=document.createElement("select");
									var oList=document.getElementById("drpStatus");
									for(k=0;k<oList.options.length;k++)
									{
										var elementOption=document.createElement("option");
										elementOption.setAttribute("value",oList.options[k].value);
										elementOption.text=oList.options[k].text;
										element.appendChild(elementOption);
									}
									
									for(k=0;k<oList.options.length;k++)
									{
										if(element.options[k].text == oCell.innerText)
										{	element.selectedIndex=k;
										     break;
										}
									}
									
									
									oCell.innerText="";
									oCell.appendChild(element);	
									break;
									break;
									
								}
					}
				
			}
		
		
	}
	
	//var oRow=oTempTable.get
}

function updateTasks(orowID)
{
	//alert('update');
	var oTempTable=document.getElementById('tblData');
	 oTRow=oTempTable.rows[orowID];
	
	   var oCell=oTRow.cells[1];
		
		var oID=oCell.childNodes[1].innerText;
		var oTaskName=oCell.childNodes[0].value;
		
	  oCell=oTRow.cells[2];
	  var oDate=oCell.childNodes[0].value;
	  var onewDate=oDate;
	  if(oDate.indexOf('-')!=-1)
	  {
		  if(oDate.indexOf('-')!=-1)
			  	oDate=oDate.replace('-','/');
			  if(oDate.indexOf('-')!=-1)
				  	oDate=oDate.replace('-','/');
		  
		  var oDateSplit=oDate.split('/');
		  var oYear=oDateSplit[0];
		  var oMonth=oDateSplit[1];
		  var oDay=oDateSplit[2];
		   onewDate=oMonth + "/" + oDay + "/" + oYear;
		   //alert(onewDate);
	  }
	  
	
	 
	  
	  oCell=oTRow.cells[3];
	  var oPriority=oCell.childNodes[0].value;
	  
	  oCell=oTRow.cells[4];
	  
	  var oDepends=oCell.childNodes[0].value;
	  
	  
	  
	  if(oDepends=="")
		  oDepends="0";
	  
	  oCell=oTRow.cells[5];
	  var oStatus=oCell.childNodes[0].value;
	  
		
	var oEditMsg=oID  + ','+  $('#lblUserName').text();
	oEditMsg += ',' + oTaskName + ',';
	oEditMsg+=oPriority + ',';
	oEditMsg+= onewDate + ',' + oDepends + ',' + oStatus;
	editTask(oEditMsg);
	}

function checker()
{
	
	$('.DateClass').datepicker({minDate: '+1d'});
	}

function Datechecker()
{
	
	
	$('.DatNew').datepicker({minDate: '+1d'});
	
	$('.DatNew').datepicker({
		   onSelect: function(dateText, inst) { 
			   
			   //alert(inst);
			   ///alert(document.getElementById('txtSearchStatus').value);
			   
		   }
		});
	
	if(document.getElementById('txtSearchStatus').value != "")
		{
			//alert(document.getElementById('txtSearchStatus').value);
			displaySearchResults('D');
		}
}



function displaySearchResults(oFlag)
{
	//alert('hi');
	//alert(document.getElementById('txtSearch').value);
	//alert(oText.value);
	if(oFlag == 'N')
		{
			if(document.getElementById('txtSearch').value != "")
				search($('#lblUserName').text() + "," +  document.getElementById('txtSearch').value);
			else
				{
					
					document.getElementById('tblData').className="tablesorter";
					document.getElementById('SearchDiv').className="HideDiv";
				}
		}
	else if(oFlag=='D')
		{
		
			if(document.getElementById('txtSearchStatus').value != "")
				search($('#lblUserName').text() + "," +  document.getElementById('txtSearchStatus').value);
			else
				{
					
					document.getElementById('tblData').className="tablesorter";
					document.getElementById('SearchDiv').className="HideDiv";
				}
		
		}
		
}
	
</script>
</head>
<body style="background-color:#523127;" onload="bodyLoad()">
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
					Search by task name:
				</td>
				<td>
					<input type="text" width="200px" id="txtSearch" onkeyup="displaySearchResults('N')" />
				</td>
				
				<td align="right">
					Search by date:
				</td>
				<td>
					<input type="text" width="200px" id="txtSearchStatus" class="DatNew"    onkeyup="displaySearchResults('D')" />
				</td>
				
			</tr>
		</table>	
	</td>
</tr>
<tr>
	<td colspan="3">
	<% if(username != null && !username.equals(""))
	{ %>
		<table width="100%" border="0" style="border-width:2px;" id="tblData" class="tablesorter">
			<thead>
			<tr>	
				<!-- <td>
					ID
				</td> -->
				<th>
					Actions
				</th>
				<th>
					Task Name
				</th>
				<th>
					Date
				</th>
				<th>
					Priority
				</th>
				<th>
					Depends On
				</th>
				<th>
					Status
				</th>
				<!-- <td>
					Share
				</td> -->
			</tr>
			</thead>
			<%
			List<TaskType> userTasksList = TaskSystemAPI.getUsersTasks(username); 
			int i=1;
			for(TaskType t : userTasksList){ %>
			<tbody>
			<tr>
			<%-- <td>
				 
			</td> --%>
				<td align="center">
					<table>
						<tr>
							<td>
								<button value="Edit" name="Editbtn" type="button" onclick="editTasks('<%=t.getName() %>','<%=t.getID() %>')"
								style="background-color:transparent;border-style: none;cursor:auto;">
									<u>Edit</u>
								</button>
							</td>
							<td>
								<input type="button" name="Delete" onclick="deleteTasks(<%=t.getID() %>)" class="buttonClass" value="Delete" />
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
			<% i++;} %>
			<tr id="static">
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
					<input type="text" id="txtDate" class="DateClass"   	/>
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
		</tbody>
	</table>
		
		<%} %>
	</td>
</tr>
<tr>
	<td colspan="3">
		<div id="SearchDiv" class="">

		</div>
	</td>
	
</tr>

</table>



</body>
</html>