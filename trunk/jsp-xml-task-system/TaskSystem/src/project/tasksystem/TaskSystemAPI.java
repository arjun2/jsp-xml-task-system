package project.tasksystem;
import java.io.BufferedReader;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.IOException;
import java.util.List;

import javax.xml.bind.JAXBContext;
import javax.xml.bind.Marshaller;
import javax.xml.bind.Unmarshaller;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerConfigurationException;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.stream.StreamSource;
import javax.xml.xquery.XQConnection;
import javax.xml.xquery.XQDataSource;
import javax.xml.xquery.XQExpression;
import javax.xml.xquery.XQResultSequence;
import javax.xml.xquery.XQSequence;

import net.sf.saxon.s9api.Processor;
import net.sf.saxon.s9api.Serializer;
import net.sf.saxon.s9api.XQueryCompiler;
import net.sf.saxon.s9api.XQueryExecutable;
import net.xqj.sedna.SednaXQDataSource;

import org.w3._1999.xhtml.ObjectFactory;
import org.w3._1999.xhtml.TaskType;
import org.w3._1999.xhtml.TasksType;
import org.w3._1999a.xhtml.UserType;
import org.w3._1999a.xhtml.UsersType;
import org.w3c.dom.Document;
import org.xml.sax.SAXException;


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
		if(username.equals("")){
			return null;
		}
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
		task.setDueDateInString("01/01/2020");
		task.setCompleted(false);
		
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
	public static String getXML(String username){
		try{
		   BufferedReader reader = new BufferedReader( new FileReader (username+"_tasks.xml"));
		    String line  = null;
		    StringBuilder stringBuilder = new StringBuilder();
		    String ls = System.getProperty("line.separator");
		    while( ( line = reader.readLine() ) != null ) {
		        stringBuilder.append( line );
		        stringBuilder.append( ls );
		    }
		    return stringBuilder.toString();
		}catch(Exception e){
			e.printStackTrace();
			return null;
		}

		
	}
	/**
	 * returns xquery results of a task name
	 */
	public static String searchByTaskName(String username, String taskname){
		try{
			taskname=taskname.replaceAll("[^A-Za-z0-9]", "");
	        Processor proc = new Processor(false);
	        XQueryCompiler comp = proc.newXQueryCompiler();
	        XQueryExecutable exp = comp.compile("doc(\" "+username+"_tasks.xml\")//task[@name=\""+taskname +"\"]");
	        ByteArrayOutputStream sos = new ByteArrayOutputStream();
	        Serializer out = proc.newSerializer(sos);
	        out.setOutputProperty(Serializer.Property.METHOD, "xml");
	        out.setOutputProperty(Serializer.Property.INDENT, "yes");
	        out.setOutputProperty(Serializer.Property.OMIT_XML_DECLARATION, "yes");
	        exp.load().run(out);
	        return sos.toString();
		}catch(Exception e){
			e.printStackTrace();
			return null;
		}

		
	}
	/**
	 * returns xquery results of a task date
	 * @param username
	 * @param taskdate
	 * @return
	 */
	public static String searchByTaskDate(String username, String taskdate){
		try{
			taskdate=taskdate.replaceAll("[^A-Za-z0-9/]", "");
	        Processor proc = new Processor(false);
	        XQueryCompiler comp = proc.newXQueryCompiler();
	        XQueryExecutable exp = comp.compile("doc(\" "+username+"_tasks.xml\")//task[@dueDate=\""+taskdate +"\"]");
	        ByteArrayOutputStream sos = new ByteArrayOutputStream();
	        Serializer out = proc.newSerializer(sos);
	        out.setOutputProperty(Serializer.Property.METHOD, "xml");
	        out.setOutputProperty(Serializer.Property.INDENT, "yes");
	        out.setOutputProperty(Serializer.Property.OMIT_XML_DECLARATION, "yes");
	        exp.load().run(out);
	        return sos.toString();
		}catch(Exception e){
			e.printStackTrace();
			return null;
		}
	}
	/*
	 * returns default xsl transformed version of the input xml
	 */
	public static String getTransformedXML(String xml){
        DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();

        //factory.setNamespaceAware(true);
        //factory.setValidating(true);
        try {
            //File stylesheet = new File(argv[0]);
            //File datafile = new File(argv[1]);

            DocumentBuilder builder = factory.newDocumentBuilder();
            Document document = builder.parse(new ByteArrayInputStream(xml.getBytes()));

            // Use a Transformer for output
            TransformerFactory tFactory = TransformerFactory.newInstance();
            StreamSource stylesource = new StreamSource(new File("transform_xquery_results.xsl"));
            Transformer transformer = tFactory.newTransformer(stylesource);

            DOMSource source = new DOMSource(document);
            ByteArrayOutputStream sos = new ByteArrayOutputStream();
            StreamResult result = new StreamResult(sos);
            transformer.transform(source, result);
            return sos.toString();
        } catch (TransformerConfigurationException tce) {
            // Error generated by the parser
            System.out.println("\n** Transformer Factory error");
            System.out.println("   " + tce.getMessage());

            // Use the contained exception, if any
            Throwable x = tce;

            if (tce.getException() != null) {
                x = tce.getException();
            }

            x.printStackTrace();
        } catch (TransformerException te) {
            // Error generated by the parser
            System.out.println("\n** Transformation error");
            System.out.println("   " + te.getMessage());

            // Use the contained exception, if any
            Throwable x = te;

            if (te.getException() != null) {
                x = te.getException();
            }

            x.printStackTrace();
        } catch (SAXException sxe) {
            // Error generated by this application
            // (or a parser-initialization error)
            Exception x = sxe;

            if (sxe.getException() != null) {
                x = sxe.getException();
            }

            x.printStackTrace();
        } catch (ParserConfigurationException pce) {
            // Parser with specified options can't be built
            pce.printStackTrace();
        } catch (IOException ioe) {
            // I/O error
            ioe.printStackTrace();
        }
		return null;
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
		System.out.println(searchByTaskName("user4","test"));
		System.out.println(isAuthValid("testu","testp"));
		System.out.println(isAuthValid("testu","testh"));
	}
}
