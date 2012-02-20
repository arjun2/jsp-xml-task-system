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
	alert(str);
	var params = str.split(",");
	if(params.length == 6){
		var url = "modifyTasks.jsp";
		url+= "?action=ADD";
		url+="&USER=" + params[0] + "&NAME=" + params[1]; 
		url+="&PRIORITY=" + params[2] + "&DUE_DATE=" + params[3];
		url+="&DEPENDS_ON=" + params[4] + "&COMPLETED=FALSE";
		url+= "&sid=" + Math.random();
		$.get(url, function(result) {
			alert(result);
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
			deleteResult('1',params[1]);
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
		url+= "?action=EDIT" + "&ID=" + params[0];
		url+="&USER=" + params[1] + "&NAME=" + params[2]; 
		url+="&PRIORITY=" + params[3] + "&DUE_DATE=" + params[4];
		url+="&DEPENDS_ON=" + params[5] + "&COMPLETED=" + params[6];
		url+= "&sid=" + Math.random();
		$.get(url, function(result) {
			showResult(result,str);
		});
	} else {
		showResult("not all parameters mentioned: " + str);
	}
}

function showResult(str,result){
	if(str.valueOf() != 0)
		alert("printing " + str);
	else 
		{
			alert("result is 0");
			
			editCells(result);
		}
		
}

function search(str){
	var params = str.split(",");
	if(str == "")
		alert("Error");
	else
		{
			var url = "modifyTasks.jsp";
			url+= "?action=SEARCH";
			url+="&USER=" + params[0] + "&NAME=" + params[1]; 
			url+= "&sid=" + Math.random();
			$.get(url, function(result) {
				
				document.getElementById('SearchDiv').innerHTML=result;
				document.getElementById('SearchDiv').className="";
				document.getElementById('tblData').className="HideDiv";
			});
		}
}


function deleteResult(str,id)
{
	alert('in delete method');
	if(str != '1')
		alert('Cannot Delete');
	else
		{
		
			alert('Hi-in delete method');
			//var oTempData=str.split(',');
			var oTable=document.getElementById('tblData');
			var oRowsCount=oTable.rows.length;
			alert(oTable.rows.length);
			for(var i=0;i<oTable.rows.length;i++)
				{
					for(var z=0;z<2;z++)
						{
							var oTester=oTable.rows[i].cells[z].childNodes[1];
							if(oTester!=undefined)
							{
								alert(oTable.rows[i].cells[z].childNodes[1]);
								if(oTable.rows[i].cells[z].childNodes[1].textContent == id.replace(/^\s+|\s+$/g,""))
									{
										oTable.deleteRow(i);
										break;
									}
							}
							
						}
						
				}
		}
}

function addTaskResult(str){
	alert(str);
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
	 
	 var elementLabel=document.createElement("label");
	 elementLabel.innerText=str.split(',')[0];
	 elementLabel.style.display="none";
	
	 var elementLabelName=document.createElement("label");
	 elementLabelName.innerText=str.split(',')[1];
	 
	var oRowCount=oTempTable.rows.length;
	
	var oRow=oTempTable.insertRow(oRowCount-1);
	
	 alert(str);
	oRow.id="newRow-" + oRowCount;
	
	
	//elementLabel.style.display="none";

	var oCell1=oRow.insertCell(0);
	var oCell2=oRow.insertCell(1);
	var oCell3=oRow.insertCell(2);
	var oCell4=oRow.insertCell(3);
	var oCell5=oRow.insertCell(4);
	var oCell6=oRow.insertCell(5);
	
		 
	oCell3.innerHTML=oVals[3];
	oCell4.innerHTML=oVals[2];
	oCell5.innerHTML=oVals[4];
	
	if(oVals[5] == "false" || oVals[5] == "FALSE")
		oCell6.innerHTML="Incomplete";
	else
		oCell6.innerHTML="Complete";
	
	
	 element2.onclick=function() {
		 
		 deleteTasks(oVals[0]);
	 };
	
	 element1.onclick=function() {
		 
		 editTasks(str.split(',')[1],str.split(',')[0]);
	 };
	
	 oCell1.align="center";
	 oCell1.appendChild(element1);
	 oCell1.appendChild(elementLabel);
	 oCell1.appendChild(element2);
	 
	 //oCell2.appendChild(elementLabelName);
	 //oCell2.valign="middle";
	 oCell2.innerHTML=oVals[1];
	
}

function editCells(str)
{
	var oTemp=false;
	var oTempTable=document.getElementById('tblData');
	var oRowLength=oTempTable.rows.length;
	for(var j=0;j<oRowLength;j++)
		{
			var oTRowLength=oTempTable.rows[j].cells.length;
			for(var k=1;k<2;k++)
				{
					var oTRow=oTempTable.rows[j];
					var oCell=oTRow.cells[k];
					
					if(oTRow.cells[k].hasChildNodes())
						{
							var oChecker=oTRow.cells[k].childNodes[1];
							if(oChecker!= undefined)
								if(oChecker.innerText == str.split(',')[0])
									{
										alert('matched');
										oTemp=true;
										var oCell1=oTRow.cells[0];
										var oCell2=oTRow.cells[1];
										var oCell3=oTRow.cells[2];
										var oCell4=oTRow.cells[3];
										var oCell5=oTRow.cells[4];
										var oCell6=oTRow.cells[5];
										
										var element4=document.createElement("label");
										
										element4.innerText=str.split(',')[0];
										element4.style.display="none";
										
										
										
											
										var element1=document.createElement("input");
										 element1.type="button";
										 element1.value="Edit";
										 element1.className="buttonClass";
										 
										 var element2=document.createElement("input");
										 element2.type="button";
										 element2.value="Delete";
										 element2.className="buttonClass";
										 
										 
										 
										 while(oCell1.childNodes.length >= 1)
										 {
										   
										 	oCell1.removeChild(oCell1.firstChild);
										 	oCell2.removeChild(oCell2.firstChild);
										 	oCell3.removeChild(oCell3.firstChild);
										 	oCell4.removeChild(oCell4.firstChild);
										 	oCell5.removeChild(oCell5.firstChild);
										 	oCell6.removeChild(oCell6.firstChild);
										 	
										 }
										 
										 	
										 	oCell2.innerHTML=str.split(',')[2];	 
											oCell3.innerHTML=str.split(',')[4];
											oCell4.innerHTML=str.split(',')[3];
											oCell5.innerHTML=str.split(',')[5];
											oCell6.innerHTML=str.split(',')[6];
											if(oCell6.innerHTML == "false")
												oCell6.innerHTML="Incomplete";
											else
												oCell6.innerHTML="Complete";
											
										 element2.onclick=function() {
											 
											 deleteTasks(str.split(',')[0]);
										 };
										
										 element1.onclick=function() {
											 
											 editTasks(str.split(',')[2],str.split(',')[0]);
										 };
										
										 oCell1.align="center";
										 oCell1.appendChild(element1);
										 oCell1.appendChild(element4);
										 oCell1.appendChild(element2);
										break;
										
										
									}
						}
					
					
				}
		
		}
	
	}