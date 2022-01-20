<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<jsp:include page="header.jsp"></jsp:include>
<h1>404 Not Found</h1>
<p>
	<%=session.getAttribute("msg")%>
</p>
<jsp:include page="footer.jsp"></jsp:include>