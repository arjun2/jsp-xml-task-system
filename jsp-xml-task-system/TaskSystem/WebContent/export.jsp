<%@ page import="project.tasksystem.TaskSystemAPI" %>



<%=TaskSystemAPI.getXML((String) session.getAttribute("user"))%>
