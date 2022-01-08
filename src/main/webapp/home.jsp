<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%
	if((session.getAttribute("email") == null) && (session.getAttribute("username") == null))
	{
		response.sendRedirect("login");
	}
	else
	{	
%>
<jsp:include page="header.jsp"></jsp:include>
	<h1>Welcome <%if(session.getAttribute("username")==null){
		out.println(session.getAttribute("email"));}
	else {
		out.println(session.getAttribute("username"));}
	%></h1>
<jsp:include page="footer.jsp"></jsp:include>
<%} %>