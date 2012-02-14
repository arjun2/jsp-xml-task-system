$(document).ready(function() {
	$("#add").click(function() {
		var str = "testuser1," +
				  document.getElementById("name").value + "," +
			      document.getElementById("priority").value + "," +
			      document.getElementById("dueDate").value + "," + 
			      document.getElementById("dependsOn").value + "," +
			      document.getElementById("completed").value;
		addTask(str);
		
	});

	$("#remove").click(function() {
		removeTask("testuser1," + document.getElementById("taskId").value);
	});
	
	$("#edit").click(function() {
		var str = "23," + "testuser1," + 
		  		  document.getElementById("name").value + "," +
		  		  document.getElementById("priority").value + "," +
		  		  document.getElementById("dueDate").value + "," + 
		  		  document.getElementById("dependsOn").value + "," +
		  		  document.getElementById("completed").value;
		editTask(str);
	});
});

function addTask(str) {
	
	var params = str.split(",");
	if(params.length == 6){
		var url = "modifyTasks.jsp";
		url+= "?action=ADD";
		url+="&USER=" + params[0] + "&NAME=" + params[1]; 
		url+="&PRIORITY=" + params[2] + "&DUE_DATE=" + params[3];
		url+="&DEPENDS_ON=" + params[4] + "&COMPLETED=FALSE";
		url+= "&sid=" + Math.random();
		$.get(url, function(result) {
			addTaskResult(result);
		});
	} else {
		addTaskResult("not all parameters mentioned");
	}
}

function removeTask(str) {
	var params = str.split(",");
	if( params.length == 2){
		var url = "modifyTasks.jsp";
		url+= "?action=REMOVE";
		url+="&USER=" + params[0] + "&ID=" + params[1];
		url+= "&sid=" + Math.random();
		
		$.get(url, function(result) {
			deleteResult('1',params[0]);
		});
	} else {
		deleteResult("Insufficient arguments " + str,params[1]);
	}
}

function editTask(str) {
	alert(str);
	var params = str.split(",");
	if(params.length == 7){
		var url = "modifyTasks.jsp";
		url+= "?action=EDIT" + "&ID=" + params[1];
		url+="&USER=" + params[0] + "&NAME=" + params[2]; 
		url+="&PRIORITY=" + params[3] + "&DUE_DATE=" + params[4];
		url+="&DEPENDS_ON=" + params[5] + "&COMPLETED=" + params[6];
		url+= "&sid=" + Math.random();
		$.get(url, function(result) {
			showResult(result);
		});
	} else {
		showResult("not all parameters mentioned: " + str);
	}
}

function showResult(str){
	if(str.valueOf() != 0)
		alert("printing " + str);
	else 
		alert("result is 0");
}

function deleteResult(str,id)
{
	alert('in delete method');
	if(str != '1')
		alert('Cannot Delete');
	else
		{
		
			alert('Hi');
			//var oTempData=str.split(',');
			var oTable=document.getElementById('tblData');
			var oRowsCount=oTable.rows.length;
			alert(oTable.rows.length);
			for(var i=0;i<oTable.rows.length;i++)
				{
				 alert(oTable.rows[i].cells[1].childNodes[0]);
					if(oTable.rows[i].cells[1].childen[0] == id)
						oTable.deleteRow(i);
				}
		}
}

function addTaskResult(str){
	
	var oVals=str.split(',');
	//var oRow="<tr><td><button>Edit</button></td></tr>";
	var oTempTable=document.getElementById('tblData');
	
	var element1=document.createElement("input");
	 element1.type="button";
	 element1.value="Edit";
	 element1.className="buttonClass";
	 
	 var element2=document.createElement("input");
	 element2.type="button";
	 element2.value="Delete";
	 element2.className="buttonClass";
	
	var oRowCount=oTempTable.rows.length;
	
	var oRow=oTempTable.insertRow(oRowCount-1);
	
	 
	oRow.id="newRow-" + oRowCount;
	

	var oCell1=oRow.insertCell(0);
	var oCell2=oRow.insertCell(1);
	var oCell3=oRow.insertCell(2);
	var oCell4=oRow.insertCell(3);
	var oCell5=oRow.insertCell(4);
	var oCell6=oRow.insertCell(5);
	
	oCell2.innerHTML=oVals[1];	 
	oCell3.innerHTML=oVals[3];
	oCell4.innerHTML=oVals[2];
	oCell5.innerHTML=oVals[4];
	oCell6.innerHTML=oVals[5].toLowerCase();
	
	
	 element2.onclick=function() {
		 
		 deleteTasks();
	 };
	
	 element1.onclick=function() {
		 
		 editTasks();
	 };
	
	 oCell1.align="center";
	 oCell1.appendChild(element1);
	 oCell1.appendChild(element2);
	
}