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
import org.w3._1999a.xhtml.UserType;
import org.w3._1999a.xhtml.UsersType;


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


        TasksType tasks= (TasksType)       unmarshaller.unmarshal(new File( username+"_tasks.xml"));

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
	/**
	 * Writes given task objects to the given user's xml file
	 * @param username
	 * @param taskList
	 */
	public static void setInitialUsersTasks(String username){
		try{
        JAXBContext jaxbContext = JAXBContext.newInstance("org.w3._1999.xhtml");
        Marshaller marshaller = jaxbContext.createMarshaller();
        marshaller.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT , new Boolean(true));
        org.w3._1999.xhtml.ObjectFactory objFactory = new org.w3._1999.xhtml.ObjectFactory();
		TasksType tasks = objFactory.createTasksType();
		List<TaskType> taskList = tasks.getTask();
		
		TaskType task = objFactory.createTaskType();
		task.setID(1);
		task.setName("Sample Task");
		task.setPriority("Low");
		
		taskList.add(task);
        marshaller.marshal(tasks,new FileOutputStream(username+"_tasks.xml"));
		}catch (Exception e){
			e.printStackTrace();
		}
		
	}
	public static boolean isAuthValid(String username, String password){
		try{
	        JAXBContext jc = JAXBContext.newInstance("org.w3._1999a.xhtml");

	        Unmarshaller unmarshaller = jc.createUnmarshaller();

	        Marshaller marshaller = jc.createMarshaller();
	        marshaller.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT ,
	            new Boolean(true));


	        UsersType users= (UsersType)
	                 unmarshaller.unmarshal(new File( "users.xml"));

	        List<UserType> userList = users.getUser();
	        for(UserType user : userList){
	        	if(user.getUsername().equals(username) && user.getPassword().equals(password)){
	        		return true;
	        	}
	        }
			return false;
			}catch (Exception e){
				e.printStackTrace();
				return false;
			}
	}
	public static boolean createUser(String username, String password){
		//check if user and username_tasks.xml already exists. if not create username_tasks.xml and return true if successful
		try{
	        JAXBContext jc = JAXBContext.newInstance("org.w3._1999a.xhtml");

	        Unmarshaller unmarshaller = jc.createUnmarshaller();

	        Marshaller marshaller = jc.createMarshaller();
	        marshaller.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT ,
	            new Boolean(true));


	        UsersType users=  (UsersType)unmarshaller.unmarshal(new File( "users.xml"));

	        List<UserType> userList = users.getUser();
	        for(UserType user : userList){
	        	if(user.getUsername().equals(username)){
	        		return false;//username already exists
	        	}
	        }
			UserType newUser = new UserType();
			newUser.setUsername(username);
			newUser.setPassword(password);
			userList.add(newUser);

	        marshaller.marshal(users,new FileOutputStream("users.xml"));
	        setInitialUsersTasks(username);
	        return true;
			}catch (Exception e){
				e.printStackTrace();
				return false;
			}
	}
	public static void main(String[] args) throws Exception{
      /*initial file creator
		JAXBContext jc = JAXBContext.newInstance("org.w3._1999a.xhtml");
        Marshaller marshaller = jc.createMarshaller();
        marshaller.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT ,new Boolean(true));
		UserType newUser = new UserType();
		newUser.setUsername("testuser1");
		newUser.setPassword("testpassword1");
		UsersType users= new UsersType();
		users.getUser().add(newUser);
		marshaller.marshal(users,new FileOutputStream("users.xml"));
		*/
		//getUsersTasks("testuser1");
		//createUser ("testu","testp");
		System.out.println(isAuthValid("testu","testp"));
		System.out.println(isAuthValid("testu","testh"));
	}
}
