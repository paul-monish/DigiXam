<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page import= "java.sql.*, com.IMAP.DAO.DbConnection"%>
<%
	if((session.getAttribute("email") == null) && (session.getAttribute("username") == null))
	{
		response.sendRedirect("login");
	}
	else
	{	
%>
<jsp:include page="header.jsp"></jsp:include>
<div class= "container">
	<%
	String sql="SELECT * FROM users order by id desc";
	try{
	DbConnection dbcon = new DbConnection();
	Connection con = dbcon.getConnection();
	PreparedStatement st= con.prepareStatement(sql);
	ResultSet rs= st.executeQuery();
	%>
 <table class="table">
  <thead class="thead-light">
    <tr>
      <th scope="col">Id</th>
      <th scope="col">Name</th>
      <th scope="col">User Name</th>
      <th scope="col">Email ID</th>
      <th scope="col">Edit</th>
      <th scope="col">Delete</th>
    </tr>
  </thead>
  <tbody>
  <%
  	int i=1;
  	while(rs.next())		
	{		
  %>
    <tr>
      <th><%=i%></th>
      <td><%=rs.getString("name")%></td>
      <td><%=rs.getString("username")%></td>
      <td><%=rs.getString("email")%></td>
      <td>
      
      	<form action="EditController" method="post">
      		<input type="hidden" name="id" value='<%=rs.getInt("id")%>'>
      		<input type="submit" class="btn btn-info" value="Edit">
   		</form>
      </td>
      <td>
      	<form method="post">
      		<input type="hidden" id="hid" name="id" value='<%=rs.getInt("id")%>'>
      		<button type="submit" id= "btn" class="btn btn-info" onsubmit="del">Delete</button>
      	</form>
     </td>
    </tr>
    <%
  	i++;
    }
  	rs.close();
	st.close();
	con.close();
	}catch(Exception e){
		e.printStackTrace();
	}
    %>
  </tbody>
</table>
</div>

<script>	
	function del()
	{
		//const id = document.getElementById("hid").value();
		alert();
	}
</script>
<jsp:include page="footer.jsp"></jsp:include>
<%}%>