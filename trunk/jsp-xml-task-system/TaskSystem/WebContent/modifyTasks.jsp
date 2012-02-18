<%@ page 
import="org.w3._1999.xhtml.TaskType" 
import="project.tasksystem.TaskSystemAPI"
import="java.util.*"
import="javax.xml.datatype.DatatypeFactory"
import="java.text.DateFormat"
import="java.text.SimpleDateFormat"
import="javax.xml.datatype.XMLGregorianCalendar"
%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%

String responseText=new String("No action specified");
String action = (String) request.getParameter("action");
String user = (String) request.getParameter("USER");
ArrayList<TaskType> taskList= 
	(ArrayList<TaskType>)TaskSystemAPI.getUsersTasks(user);
try{
	if(action.equals("ADD") || action.equals("EDIT")){
	 	String name = (String) request.getParameter("NAME");
	 	String priority = (String) request.getParameter("PRIORITY");
	 	String dueDate = (String) request.getParameter("DUE_DATE");
	 	String dependsOn = (String) request.getParameter("DEPENDS_ON");
	 	String completed = (String) request.getParameter("COMPLETED");
		//GregorianCalendar c = new GregorianCalendar();
		//DateFormat d = new SimpleDateFormat("mm-dd-yy");;
		//c.setTime(d.parse(dueDate));
		//XMLGregorianCalendar date = 
			//DatatypeFactory.newInstance().newXMLGregorianCalendar(c);
		if(action.equals("ADD")){
			TaskType tsk = new TaskType();
			int[] id = new int[taskList.size()];
			for(int i=0; i<taskList.size() ; i++)
				id[i] = taskList.get(i).getID();
				
			
			Arrays.sort(id);
			tsk.setID(id[id.length-1] + 1);
			tsk.setName(name); 
			tsk.setPriority(priority);
			//tsk.setDueDate(date);
			tsk.setDueDateInString(dueDate);
			String dependsOnName="";
			if(dependsOn.length()!=0){
				tsk.setDependsOn(Integer.parseInt(dependsOn));
				for(int i=0; i<taskList.size() ; i++)
					if(taskList.get(i).getID()==Integer.parseInt(dependsOn))
						dependsOnName = taskList.get(i).getName();
			}
			tsk.setCompleted(Boolean.parseBoolean(completed));
			taskList.add(tsk);
			TaskSystemAPI.setUsersTasks(user,taskList);
			String newTask = Integer.toString(id[id.length-1] + 1) + "," + 
			name + "," + priority + "," + dueDate + "," + dependsOnName + "," +
			completed;
			out.print(newTask);
		} else {
			int taskIndex=-1;
			boolean allowEdit=false;
			int id = Integer.parseInt((String) request.getParameter("ID"));
			Boolean t_completed = Boolean.parseBoolean(completed);
			for(int i=0; i<taskList.size() ; i++){
				//System.out.println("task name " + taskList.get(i).getName());
				//System.out.println("task ID " + taskList.get(i).getID());
				if( id==taskList.get(i).getID()){
					taskIndex=i;
					//break;
				}
			}
			if(t_completed.booleanValue()){
				//Integer dependsOntaskId = 
				//					taskList.get(taskIndex).getDependsOn();
				if(dependsOn.length() != 0){
					int _t=Integer.parseInt(dependsOn);
					int dependsOnIndex=-1;
					for(int i=0; i<taskList.size() ; i++)
						if(_t==taskList.get(i).getID())
							dependsOnIndex=i;
					System.out.println("dependsOn: "+dependsOn);
					System.out.println("test completed " + taskList.get(dependsOnIndex).isCompleted()); 
					System.out.println(""+ taskList.get(dependsOnIndex).getName());
							
					if( taskList.get(dependsOnIndex).isCompleted() )
						allowEdit=true;
					else
						out.print("This task cannot be completed as " + 
						"dependent task is not completed yet");
				} else
					allowEdit=true;
						
			} else
				allowEdit=true;
			
			if(allowEdit){
				System.out.println("Allow edit");
				TaskType tsk = taskList.get(taskIndex);
				tsk.setName(name);
				tsk.setPriority(priority);
				tsk.setDueDateInString(dueDate);
				if(dependsOn.length()!=0)
					tsk.setDependsOn(Integer.parseInt(dependsOn));
				tsk.setCompleted(t_completed);
				taskList.remove(taskIndex);
				taskList.add(tsk);
				TaskSystemAPI.setUsersTasks(user,taskList);
				out.print("0");
			}
		}
 	} else if(action.equals("REMOVE")){
		 int id = Integer.parseInt((String) request.getParameter("ID"));
		 int taskToRemove=-1;
		 boolean dependent = false;
		 for(int i=0; i<taskList.size() ; i++){
			 if( id==taskList.get(i).getID())
				 taskToRemove=i;
			 Integer dependsOnValue = taskList.get(i).getDependsOn();
			 if( dependsOnValue!=null){
				if(dependsOnValue.intValue()==id){ 
					dependent=true;
					out.print("This task cannot be deleted as other tasks are " + 
						"depend on this task");
				}
			 }
		 }
		 if(!dependent){
			 if(taskToRemove != -1){
				 taskList.remove(taskToRemove);
				 TaskSystemAPI.setUsersTasks(user,taskList);
				 out.print("0");
			 } else
				 out.print("No task found");
		 }
 	} else if(action.equals("TASKLIST")){
 		String taskIdValue="";
 		for(int i=0; i<taskList.size() ; i++)
 			if(!taskList.get(i).isCompleted()){
 				if(taskIdValue.length()!=0)
 					taskIdValue+=",";
 				taskIdValue+=taskList.get(i).getID() + ":" + 
 							 taskList.get(i).getName();
 			}
 		out.print(action);
 	} else
		out.print(action);
} catch (Exception e){
	e.printStackTrace();
}
  
%>
