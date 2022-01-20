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
<jsp:include page="header.jsp"></jsp:include>
<div class= "container">
<h4>Hello <%=user.split(" ")[0]%>!</h4>
	<%
	switch(role)
	{
		case "super-admin":
			sql="SELECT * FROM users where role in ('admin', 'teacher', 'student') order by id desc";
			break;
		case "admin":
			sql="SELECT * FROM users where role in ('teacher', 'student') order by id desc";
			break;
		default: 
			out.println("Wrong Entry");
	}
	
	try{
	DbConnection dbcon = new DbConnection();
	Connection con = dbcon.getConnection();
	PreparedStatement st= con.prepareStatement(sql);
	ResultSet rs= st.executeQuery();
	%>
 <table class="table" id="myTable">
  <thead class="thead-light">
    <tr>
      <th scope="col">Id</th>
      <th scope="col">Role</th>
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
      <td><%=rs.getString("role").substring(0, 1).toUpperCase()+rs.getString("role").substring(1)%></td>
      <td><%=rs.getString("name")%></td>
      <td><%=rs.getString("username")%></td>
      <td><%=rs.getString("email")%></td>
      <td>
      <%
	    String sql1="SELECT * FROM users where id = ?";
	  	try{
	  	DbConnection dbcon1 = new DbConnection();
	  	Connection con1 = dbcon1.getConnection();
	  	PreparedStatement st1= con1.prepareStatement(sql1);
	  	st1.setInt(1, rs.getInt("id"));
	  	ResultSet rs1= st1.executeQuery();
      %>
      <!-- Button trigger modal -->
		<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModalCenter<%=rs.getInt("id")%>">
		  Edit
		</button>
		<!-- Modal -->
		<div class="modal fade" id="exampleModalCenter<%=rs.getInt("id")%>" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle<%=rs.getInt("id")%>" aria-hidden="true">
		  <div class="modal-dialog modal-dialog-centered" role="document">
		    <div class="modal-content">
		    <%
		      	if(rs1.next())
		      	{  		
		    %>
		    <form action="EditController" method="post">
		      <div class="modal-header">
		        <h5 class="modal-title" id="exampleModalCenterTitle">Users</h5>
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
		          <span aria-hidden="true">&times;</span>
		        </button>
		      </div>
		      <div class="modal-body">
		      		<input type="hidden" name="id" value='<%=rs.getInt("id")%>'>
	      			  <div class="form-group row">
				      <label for="staticEmail" class="col-sm-2 col-form-label">Email</label>
				      <div class="col-sm-10">
				      	<input type="text" class="form-control" id="inputPassword" value='<%=rs1.getString("name")%>' name= "name" placeholder="Name">
				      </div>
					  </div>
					  <div class="form-group row">
					    <label for="inputPassword" class="col-sm-2 col-form-label">Name</label>
					    <div class="col-sm-10">
					    	<input type="text" class="form-control-plaintext" id="staticEmail" value='<%=rs1.getString("email")%>' name = "email" placeholder="email@example.com">
					    </div>
					  </div>
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
		        <!--<button type="button" class="btn btn-primary">Save changes</button>  -->
		      <input type="submit" class="btn btn-info" value="Update">
		      </div>
		      </form>
		      <%}%>
		    </div>
		  </div>
		</div>
	<%
		rs1.close();
   		st1.close();
   		con1.close();
   		}catch(Exception e){
   			e.printStackTrace();
   		}
	%>
      </td>
      <td>
      	<form action="DeleteController" method="post">
      		<input type="hidden" id="hid<%=rs.getInt("id")%>" name="id" value='<%=rs.getInt("id")%>'>
      		<button type="submit" id= "btn<%=rs.getInt("id")%>" class="btn btn-danger" >Delete</button>
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

<jsp:include page="footer.jsp"></jsp:include>
<script type= "text/javascript">	
	$(document).ready(function(){
	 $('#myTable').DataTable( {
	        dom: 'Bfrtip',
	        buttons: [
	            'copy', 'csv', 'excel', 'pdf', 'print'
	        ]
	    } );
	});
	
	
</script>
<%}%>