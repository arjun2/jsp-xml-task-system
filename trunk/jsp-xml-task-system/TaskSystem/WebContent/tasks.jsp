<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%
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

%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Advanced online task system</title>
</head>
<body>

</body>
</html>