<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import= "java.sql.*, com.IMAP.DAO.DbConnection"%>
    <%!
       String role;
       String sql;
       String user;
    %>
<%
	if((session.getAttribute("email") == null) && (session.getAttribute("username") == null))
	{
		response.sendRedirect("login");
	}
	else
	{	
		String sql2="SELECT role, name FROM users where email = ? OR username = ?";
		try{
		DbConnection dbcon2 = new DbConnection();
		Connection con2 = dbcon2.getConnection();
		PreparedStatement st2= con2.prepareStatement(sql2);
		st2.setString(1, (String)session.getAttribute("email"));
		st2.setString(2, (String)session.getAttribute("username"));
		ResultSet rs2= st2.executeQuery();
		if(rs2.next())
		{
			role = rs2.getString("role");
			user = rs2.getString("name");
		}
		rs2.close();
   		st2.close();
   		con2.close();
   		}catch(Exception e){
   			e.printStackTrace();
   		}
%>
<nav>
    <div class="sidebar-button">
      <i class='bx bx-menu sidebarBtn'></i>
      <span class="dashboard"><%=request.getRequestURI().split("/")[request.getRequestURI().split("/").length-1].substring(0, 1).toUpperCase()+request.getRequestURI().split("/")[request.getRequestURI().split("/").length-1].substring(1)%></span>
    </div>
    <div class="search-box">
      <input type="text" placeholder="Search...">
      <i class='bx bx-search' ></i>
    </div>
    <div class="profile-details" id="dropdownMenuButton" data-toggle="dropdown" aria-expanded="false">
      <img src="Assets/img/dashboard/face-1.jpg" alt="">
      <span class="admin_name"><%=user%></span>
      <i class='bx bx-chevron-down'></i>
      <div class="dropdown-menu" style= "margin-left: 1.95rem;" aria-labelledby="dropdownMenuButton">
		   <a class="dropdown-item" href="#">Profile</a>
		   <form action="LogoutController" method="post">
       			<button class="btn btn-danger dropdown-item">Logout</button>
	       </form>   
	  </div>
    </div>
 </nav>
 <%
}
 %>