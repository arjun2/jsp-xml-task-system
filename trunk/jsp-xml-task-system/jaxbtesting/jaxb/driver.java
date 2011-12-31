import org.w3._1999.xhtml.ObjectFactory;
import org.w3._1999.xhtml.TaskType;
import org.w3._1999.xhtml.TasksType;


public class driver {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		ObjectFactory objFactory = new ObjectFactory();
		TasksType tasks = objFactory.createTasksType();   
		TaskType task = objFactory.createTaskType();
		task.setID(2);
		task.setDependsOn(0);
		task.setName("test");
		task.setPriority("High");
	

	}

}
