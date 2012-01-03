import java.io.File;
import java.util.List;

import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBException;
import javax.xml.bind.Marshaller;
import javax.xml.bind.PropertyException;
import javax.xml.bind.Unmarshaller;
import javax.xml.bind.Validator;

import org.w3._1999.xhtml.ObjectFactory;
import org.w3._1999.xhtml.TaskType;
import org.w3._1999.xhtml.TasksType;


public class driverunmarshall {

	/**
	 * @param args
	 * @throws JAXBException 
	 */
	public static void main(String[] args) throws JAXBException {
		// TODO Auto-generated method stub
        JAXBContext jc = JAXBContext.newInstance("org.w3._1999.xhtml");
        ObjectFactory objFactory = new ObjectFactory();

        Unmarshaller unmarshaller = jc.createUnmarshaller();

        Marshaller marshaller = jc.createMarshaller();
        marshaller.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT ,
            new Boolean(true));


        TasksType tasks= (TasksType)
                 unmarshaller.unmarshal(new File( "tasksjaxb.xml"));

        List<TaskType> taskList = tasks.getTask();
        System.out.println("First task name: "+ taskList.get(0).getName());
        System.out.println("First task id: "+ taskList.get(0).getID());
        System.out.println("First task priority: "+ taskList.get(0).getPriority());
        System.out.println("First task depends on: "+ taskList.get(0).getDependsOn());
	}

}
