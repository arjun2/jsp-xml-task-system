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
		var str = "21," + "testuser1," + 
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
		alert(params[3]);
		$.get(url, function(result) {
			alert("task added successfully: " + result);
		});
	} else {
		alert("not all parameters mentioned: " + str);
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
			alert(result);
		});
	} else {
		alert("Insufficient arguments " + str);
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
		alert(url);
		$.get(url, function(result) {
			alert(result);
		});
	} else {
		alert("not all parameters mentioned: " + str);
	}
}
