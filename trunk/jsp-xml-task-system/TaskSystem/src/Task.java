import java.util.Date;


public class Task {
private int id;
private String name;
private String priority;
private String dueDate;
private Integer dependsOn;

public Task(int id, String name, String priority, String date, int dependsOnID){
	
}
public int getID(){
	return id;
}
public String getName(){
	return name;
}
public String getPriority(){
	return priority;
}
public String getDueDate(){
	return dueDate;
}
public Task getDependsOn(){
	return XMLFunctions.getAllTasks().get(dependsOn);
}
}
