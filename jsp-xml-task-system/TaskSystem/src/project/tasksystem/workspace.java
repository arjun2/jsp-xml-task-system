package project.tasksystem;

import java.util.List;

import org.w3._1999.xhtml.TaskType;

public class workspace {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		List<TaskType> userTasksList = TaskSystemAPI.getUsersTasks("testuser1");
		for(TaskType t : userTasksList){
			
		}
	}

}
