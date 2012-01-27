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
		alert(url);
		$.get(url, function(result) {
			showResult(result);
		});
	} else {
		showResult("Insufficient arguments " + str);
	}
}

function editTask(str) {
	var params = str.split(",");
	if(params.length == 7){
		var url = "modifyTasks.jsp";
		url+= "?action=EDIT" + "&ID=" + params[0];
		url+="&USER=" + params[1] + "&NAME=" + params[2]; 
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

function addTaskResult(str){
	alert(str);
}