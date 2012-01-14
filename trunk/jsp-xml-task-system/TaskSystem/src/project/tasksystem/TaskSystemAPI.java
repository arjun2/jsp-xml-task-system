package project.tasksystem;
import java.io.File;
import java.io.FileOutputStream;
import java.util.List;

import javax.xml.bind.JAXBContext;
import javax.xml.bind.Marshaller;
import javax.xml.bind.Unmarshaller;

import org.w3._1999.xhtml.ObjectFactory;
import org.w3._1999.xhtml.TaskType;
import org.w3._1999.xhtml.TasksType;

/** 
 * Each user gets their own xml file of the tasks username_tasks.xml
 * All the usernames and passwords are stored in users.xml
 *
 */
public class TaskSystemAPI {

	/**
	 * 
	 * @param username
	 * @returns a list of task objects that belong to the username
	 */
	public static List<TaskType> getUsersTasks(String username){
		try{
        JAXBContext jc = JAXBContext.newInstance("org.w3._1999.xhtml");

        Unmarshaller unmarshaller = jc.createUnmarshaller();

        Marshaller marshaller = jc.createMarshaller();
        marshaller.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT ,
            new Boolean(true));


        TasksType tasks= (TasksType)
                 unmarshaller.unmarshal(new File( username+"_tasks.xml"));

        List<TaskType> taskList = tasks.getTask();
		return taskList;
		}catch (Exception e){
			e.printStackTrace();
			return null;
		}
		
	}
	/**
	 * Writes given task objects to the given user's xml file
	 * @param username
	 * @param taskList
	 */
	public static void setUsersTasks(String username,List<TaskType> taskList){
		try{
        JAXBContext jaxbContext = JAXBContext.newInstance("org.w3._1999.xhtml");
        Marshaller marshaller = jaxbContext.createMarshaller();
        marshaller.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT , new Boolean(true));
		TasksType tasks = new TasksType();
		tasks.getTask().addAll(taskList);
        marshaller.marshal(tasks,new FileOutputStream(username+"_tasks.xml"));
		}catch (Exception e){
			e.printStackTrace();
		}
		
	}
	public static boolean isAuthValid(String username, String password){
		return false;
	}
	public static boolean createUser(String username, String password){
		//check if user and username_tasks.xml already exists. if not create username_tasks.xml and return true if successful
		return false;
	}
}
