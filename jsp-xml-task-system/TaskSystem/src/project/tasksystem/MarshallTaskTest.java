package project.tasksystem;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.util.List;

import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBException;
import javax.xml.bind.Marshaller;

import org.w3._1999.xhtml.ObjectFactory;
import org.w3._1999.xhtml.TaskType;
import org.w3._1999.xhtml.TasksType;


public class MarshallTaskTest {

	/**
	 * @param args
	 * @throws JAXBException 
	 * @throws FileNotFoundException 
	 */
	public static void main(String[] args) throws FileNotFoundException, JAXBException {
		// TODO Auto-generated method stub
        JAXBContext jaxbContext = JAXBContext.newInstance("org.w3._1999.xhtml");
        Marshaller marshaller = jaxbContext.createMarshaller();
        marshaller.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT , new Boolean(true));
		ObjectFactory objFactory = new ObjectFactory();
		
		TasksType tasks = objFactory.createTasksType();
		List<TaskType> taskList = tasks.getTask();
		
		TaskType task = objFactory.createTaskType();
		task.setID(2);
		task.setDependsOn(0);
		task.setName("test");
		task.setPriority("High");
		
		taskList.add(task);
        marshaller.marshal(tasks,new FileOutputStream("tasksjaxb.xml"));
	}

}
