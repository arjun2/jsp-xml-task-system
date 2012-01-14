package project.tasksystem;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.xml.XMLConstants;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.Source;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamSource;
import javax.xml.validation.Schema;
import javax.xml.validation.SchemaFactory;
import javax.xml.validation.Validator;

import org.w3c.dom.Document;
import org.xml.sax.SAXException;


public class XMLFunctions_deprecated {
	public static HashMap<Integer,Task_deprecated> getAllTasks(){
		return null;
	}
	public void StoreAllTasksToXML(HashMap<Integer,Task_deprecated> tasks){
		
	}
	public static Document xmlDocument(String filename) throws ParserConfigurationException, SAXException, IOException{
	    // parse an XML document into a DOM tree
	    DocumentBuilderFactory parserFactory = DocumentBuilderFactory.newInstance();
	    parserFactory.setNamespaceAware(true);
	    DocumentBuilder parser = parserFactory.newDocumentBuilder();
	    Document document = parser.parse(new File(filename));
	    return document;
	}

	public static boolean isValid(Document document, String schemaFileName){
		
		return false;
	}
	public static boolean sample() throws ParserConfigurationException, SAXException, IOException{
	    // parse an XML document into a DOM tree
	    DocumentBuilderFactory parserFactory = DocumentBuilderFactory.newInstance();
	    parserFactory.setNamespaceAware(true);
	    DocumentBuilder parser = parserFactory.newDocumentBuilder();
	    Document document = parser.parse(new File("instance.xml"));

	    // create a SchemaFactory capable of understanding WXS schemas
	    SchemaFactory factory = SchemaFactory.newInstance(XMLConstants.W3C_XML_SCHEMA_NS_URI);

	    // load a WXS schema, represented by a Schema instance
	    Source schemaFile = new StreamSource(new File("mySchema.xsd"));
	    Schema schema = factory.newSchema(schemaFile);

	    // create a Validator instance, which can be used to validate an instance document
	    Validator validator = schema.newValidator();

	    // validate the DOM tree
	    try {
	        validator.validate(new DOMSource(document));
	    } catch (SAXException e) {
	        // instance document is invalid!
	    }
	    return true;
	}
}
