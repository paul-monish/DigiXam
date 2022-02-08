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
<!-- CSS for Navbar & Sidebar -->
<style>
/* Googlefont Poppins CDN Link */
@import url('https://fonts.googleapis.com/css2?family=Poppins:wght@200;300;400;500;600;700&display=swap');
*{
  margin: 0;
  padding: 0;
  box-sizing: border-box;
  font-family: 'Poppins', sans-serif;
}

#id{
  float: left;
}
.sidebar{
  position: fixed;
  height: 100%;
  width: 240px;
  background: #ec2829;
  transition: all 0.5s ease;
}
.sidebar.active{
  width: 60px;
}
.sidebar .logo-details{
  height: 80px;
  display: flex;
  align-items: center;
}
.sidebar .logo-details i{
  font-size: 28px;
  font-weight: 500;
  color: #fff;
  min-width: 60px;
  text-align: center
}
.sidebar .logo-details .logo_name{
  color: #fff;
  font-size: 24px;
  font-weight: 500;
}
.sidebar .nav-links{
  margin-top: 10px;
}
.sidebar .nav-links li{
  position: relative;
  list-style: none;
  height: 50px;
}
.sidebar .nav-links li a{
  height: 100%;
  width: 100%;
  display: flex;
  align-items: center;
  text-decoration: none;
  transition: all 0.4s ease;
}
.sidebar .nav-links li a.active{
  background: #a51c1c;
}
.sidebar .nav-links li a:hover{
  background: #a51c1c;
}
.sidebar .nav-links li i{
  min-width: 60px;
  text-align: center;
  font-size: 18px;
  color: #fff;
}
.sidebar .nav-links li a .links_name{
  color: #fff;
  font-size: 15px;
  font-weight: 400;
  white-space: nowrap;
}
.sidebar .nav-links .log_out{
  position: absolute;
  bottom: 0;
  width: 100%;
}
.home-section{
  position: relative;
  background: #f5f5f5;
  min-height: 100vh;
  width: calc(100% - 240px);
  left: 240px;
  transition: all 0.5s ease;
}
.sidebar.active ~ .home-section{
  width: calc(100% - 60px);
  left: 60px;
}
.home-section nav{
  display: flex;
  justify-content: space-between;
  height: 80px;
  background: #fff;
  display: flex;
  align-items: center;
  position: fixed;
  width: calc(100% - 240px);
  left: 240px;
  z-index: 100;
  padding: 0 20px;
  box-shadow: 0 1px 1px rgba(0, 0, 0, 0.1);
  transition: all 0.5s ease;
}
.sidebar.active ~ .home-section nav{
  left: 60px;
  width: calc(100% - 60px);
}
.home-section nav .sidebar-button{
  display: flex;
  align-items: center;
  font-size: 24px;
  font-weight: 500;
}
nav .sidebar-button i{
  font-size: 35px;
  margin-right: 10px;
}
.home-section nav .search-box{
  position: relative;
  height: 50px;
  max-width: 550px;
  width: 100%;
  margin: 0 20px;
}
nav .search-box input{
  height: 100%;
  width: 100%;
  outline: none;
  background: #F5F6FA;
  border: 2px solid #EFEEF1;
  border-radius: 6px;
  font-size: 18px;
  padding: 0 15px;
}
nav .search-box .bx-search{
  position: absolute;
  height: 40px;
  width: 40px;
  background: #ef5253;
  right: 5px;
  top: 50%;
  transform: translateY(-50%);
  border-radius: 4px;
  line-height: 40px;
  text-align: center;
  color: #fff;
  font-size: 22px;
  transition: all 0.4 ease;
}
.home-section nav .profile-details{
  display: flex;
  align-items: center;
  background: #F5F6FA;
  border: 2px solid #EFEEF1;
  border-radius: 6px;
  height: 50px;
  min-width: 190px;
  padding: 0 15px 0 2px;
}
nav .profile-details img{
  height: 40px;
  width: 40px;
  border-radius: 6px;
  object-fit: cover;
}
nav .profile-details .admin_name{
  font-size: 15px;
  font-weight: 500;
  color: #333;
  margin: 0 10px;
  white-space: nowrap;
}
nav .profile-details i{
  font-size: 25px;
  color: #333;
}
.home-section .home-content{
  position: relative;
  padding-top: 104px;
}
.home-content .overview-boxes{
  display: flex;
  align-items: center;
  justify-content: space-between;
  flex-wrap: wrap;
  padding: 0 20px;
  margin-bottom: 26px;
}
.overview-boxes .box{
  display: flex;
  align-items: center;
  justify-content: center;
  width: calc(100% / 4 - 15px);
  background: #fff;
  padding: 15px 14px;
  border-radius: 12px;
  box-shadow: 0 5px 10px rgba(0,0,0,0.1);
}
.overview-boxes .box-topic{
  font-size: 20px;
  font-weight: 500;
}
.home-content .box .number{
  display: inline-block;
  font-size: 35px;
  margin-top: -6px;
  font-weight: 500;
}
.home-content .box .indicator{
  display: flex;
  align-items: center;
}
.home-content .box .indicator i{
  height: 20px;
  width: 20px;
  background: #8FDACB;
  line-height: 20px;
  text-align: center;
  border-radius: 50%;
  color: #fff;
  font-size: 20px;
  margin-right: 5px;
}
.box .indicator i.down{
  background: #e87d88;
}
.home-content .box .indicator .text{
  font-size: 12px;
}
.home-content .box .cart{
  display: inline-block;
  font-size: 32px;
  height: 50px;
  width: 50px;
  background: #cce5ff;
  line-height: 50px;
  text-align: center;
  color: #66b0ff;
  border-radius: 12px;
  margin: -15px 0 0 6px;
}
.home-content .box .cart.two{
   color: #2BD47D;
   background: #C0F2D8;
 }
.home-content .box .cart.three{
   color: #ffc233;
   background: #ffe8b3;
 }
.home-content .box .cart.four{
   color: #e05260;
   background: #f7d4d7;
 }
.home-content .total-order{
  font-size: 20px;
  font-weight: 500;
}
.home-content .sales-boxes{
  display: flex;
  justify-content: space-between;
  /* padding: 0 20px; */
}

/* left box */
.home-content .sales-boxes .recent-sales{
  width: 65%;
  background: #fff;
  padding: 20px 30px;
  margin: 0 20px;
  border-radius: 12px;
  box-shadow: 0 5px 10px rgba(0, 0, 0, 0.1);
}
.home-content .sales-boxes .sales-details{
  display: flex;
  align-items: center;
  justify-content: space-between;
}
.sales-boxes .box .title{
  font-size: 24px;
  font-weight: 500;
  /* margin-bottom: 10px; */
}
.sales-boxes .sales-details li.topic{
  font-size: 20px;
  font-weight: 500;
}
.sales-boxes .sales-details li{
  list-style: none;
  margin: 8px 0;
}
.sales-boxes .sales-details li a{
  font-size: 18px;
  color: #333;
  font-size: 400;
  text-decoration: none;
}
.sales-boxes .box .button{
  width: 100%;
  display: flex;
  justify-content: flex-end;
}
.sales-boxes .box .button a{
  color: #fff;
  background: #0A2558;
  padding: 4px 12px;
  font-size: 15px;
  font-weight: 400;
  border-radius: 4px;
  text-decoration: none;
  transition: all 0.3s ease;
}
.sales-boxes .box .button a:hover{
  background:  #0d3073;
}

/* Right box */
.home-content .sales-boxes .top-sales{
  width: 35%;
  background: #fff;
  padding: 20px 30px;
  margin: 0 20px 0 0;
  border-radius: 12px;
  box-shadow: 0 5px 10px rgba(0, 0, 0, 0.1);
}
.sales-boxes .top-sales li{
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin: 10px 0;
}
.sales-boxes .top-sales li a img{
  height: 40px;
  width: 40px;
  object-fit: cover;
  border-radius: 12px;
  margin-right: 10px;
  background: #333;
}
.sales-boxes .top-sales li a{
  display: flex;
  align-items: center;
  text-decoration: none;
}
.sales-boxes .top-sales li .product,
.price{
  font-size: 17px;
  font-weight: 400;
  color: #333;
}
/* Responsive Media Query */
@media (max-width: 1240px) {
  .sidebar{
    width: 60px;
  }
  .sidebar.active{
    width: 220px;
  }
  .home-section{
    width: calc(100% - 60px);
    left: 60px;
  }
  .sidebar.active ~ .home-section{
    /* width: calc(100% - 220px); */
    overflow: hidden;
    left: 220px;
  }
  .home-section nav{
    width: calc(100% - 60px);
    left: 60px;
  }
  .sidebar.active ~ .home-section nav{
    width: calc(100% - 220px);
    left: 220px;
  }
}
@media (max-width: 1150px) {
  .home-content .sales-boxes{
    flex-direction: column;
  }
  .home-content .sales-boxes .box{
    width: 100%;
    overflow-x: scroll;
    margin-bottom: 30px;
  }
  .home-content .sales-boxes .top-sales{
    margin: 0;
  }
}
@media (max-width: 1000px) {
  .overview-boxes .box{
    width: calc(100% / 2 - 15px);
    margin-bottom: 15px;
  }
}
@media (max-width: 700px) {
  nav .sidebar-button .dashboard,
  nav .profile-details .admin_name,
  nav .profile-details i{
    display: none;
  }
  .home-section nav .profile-details{
    height: 50px;
    min-width: 40px;
  }
  .home-content .sales-boxes .sales-details{
    width: 560px;
  }
}
@media (max-width: 550px) {
  .overview-boxes .box{
    width: 100%;
    margin-bottom: 15px;
  }
  .sidebar.active ~ .home-section nav .profile-details{
    display: none;
  }
}
</style>
<!-- CSS for Datatable -->
<style>
body{
    font-family: 'Raleway', sans-serif;
    background: #f9f9f9;
}
.p-30{
    padding:30px;
}
.main-datatable {
    padding: 0px; 
    border: 1px solid #f3f2f2;
    border-bottom: 0;
    box-shadow: 0px 2px 10px rgba(0,0,0,.05);
}
.d-flex{
    display: flex;
    align-items: center;
    justify-content: space-between;
}
.card_body{ 
    background-color: white;
    border: 1px solid transparent;
    border-radius: 2px;
    -webkit-box-shadow: 0 1px 1px rgba(0, 0, 0, 0.05);
    box-shadow: 0 1px 1px rgba(0, 0, 0, 0.05);
}
.main-datatable .row {
    margin: 0;
} 
.searchInput {
    width: 50%;
    display: flex;
    align-items: center;
    position: relative;
    justify-content: flex-end;
    margin: 20px 0px;
    padding: 0px 4px;
}
.searchInput input {
    border: 1px solid #e5e5e5;
    border-radius: 50px;
    margin-left: 8px;
    height: 34px;
    width: 100%;
    padding: 0px 25px 0px 10px;
    transition: all .6s ease;
}
.searchInput label {
    color: #767676;
    font-weight: normal;
}
.searchInput input:placeholder-shown {
    width: 13%;
}
.searchInput:hover input:placeholder-shown {
    width: 100%;
    cursor: pointer;
}
.searchInput:after {
    font-family: 'FontAwesome';
    color: #d4d4d4;
    position: relative;
    content: "\f002";
    right: 25px;
}

.dim_button {
    display: inline-block;
    color: #fff;
    text-decoration: none;
    text-transform: uppercase;
    text-align: center;
    padding-top: 6px;
    background: rgb(57, 85, 136);
    margin-right: 10px;
    position: relative;
    cursor: pointer;
    font-weight: 600;
    margin-bottom: 20px;
} 
.createSegment a { 
    margin-bottom: 0px;
    border-radius: 50px;
    background: #ffffff;
    border: 1px solid #007bff;
    color: #007bff;
    transition: all .4s ease;
}
.createSegment a:hover, .createSegment a:focus {
    transition: all .4s ease;
    background: #007bff;
    color: #fff;
}
.add_flex{
    display: flex;
    justify-content: flex-end;
    padding-right:0px;
}
.main-datatable .dataTable.no-footer {
    border-bottom: 1px solid #eee;
}
.main-datatable .cust-datatable thead {
    background-color: #f9f9f9;
}
.main-datatable .cust-datatable>thead>tr>th {
    border-bottom-width: 0;
    color: #443f3f;
    font-weight: 600;
    padding: 16px 15px;
    vertical-align: middle;
    padding-left: 18px;
    text-align: center;
}
.main-datatable .cust-datatable>tbody td {
    padding: 10px 15px 10px 18px;
    color: #333232;
    font-size: 13px;
    font-weight: 500;
    word-break: break-word;
    border-color: #eee;
    text-align: center;
    vertical-align: middle;
}
.main-datatable .cust-datatable>tbody tr {
    border-top: none;
}
.main-datatable .table > tbody > tr:nth-child(even) {
    background: #f9f9f9;
}
.btn-group.open .dropdown-toggle {
    box-shadow: none;
}
.main-datatable .dropdown_icon {
    display: inline-block;
    color: #8a8a8a;
    font-size: 12px;
    border: 1px solid #d4d4d4;
    padding: 10px 11px;
    border-radius: 50%;
    cursor: pointer;
}
.btn-group i{
    color: #8e8e8e; 
    margin: 2px;
}
.main-datatable .actionCust a {
    display: inline-block;
    color: #8a8a8a;
    font-size: 12px;
    border: 1px solid #d4d4d4;
    padding: 10px 11px;
    margin: -9px 3px;
    border-radius: 50%;
    cursor: pointer;
}
.main-datatable .actionCust a i{
    color: #8e8e8e;
    margin: 2px;
}
.main-datatable .dropdown-menu {
    padding: 0;
    border-radius: 4px;
    box-shadow: 10px 10px 20px #c8c8c8;
    margin-top: 10px;
    left: -65px;
    top: 32px;
}
.main-datatable .dropdown-menu > li > a {
    display: block;
    padding: 12px 20px;
    clear: both;
    font-weight: normal;
    line-height: 1.42857;
    color: #333333;
    white-space: nowrap;
    border-bottom: 1px solid #d4d4d4;
}
.main-datatable .dropdown-menu > li > a:hover, 
.main-datatable .dropdown-menu > li > a:focus {
    color: #fff;
    background: #007bff;
}
.main-datatable .dropdown-menu > li > a:hover i{
    color: #fff; 
}
.main-datatable .dropdown-menu:before {
    position: absolute;
    top: -7px;
    left: 78px;
    display: inline-block;
    border-right: 7px solid transparent;
    border-bottom: 7px solid #d4d4d4;
    border-left: 7px solid transparent;
    border-bottom-color: #d4d4d4;
    content: '';
}
.main-datatable .dropdown-menu:after {
    position: absolute;
    top: -6px;
    left: 78px;
    display: inline-block;
    border-right: 6px solid transparent;
    border-bottom: 6px solid #ffffff;
    border-left: 6px solid transparent;
    content: '';
}
.dropdown-menu i {
    margin-right: 8px;
}
.main-datatable .dataTables_wrapper .dataTables_paginate .paginate_button {
    color: #999999 !important;
    background-color: #f6f6f6 !important;
    border-color: #d4d4d4 !important;
    border-radius: 40px;
    margin: 5px 3px;
}
.main-datatable .dataTables_wrapper .dataTables_paginate .paginate_button:hover {
    color: #fff !important;
    border: 1px solid #3d96f5 !important;
    background: #4da3ff !important;
    box-shadow: none;
}
.main-datatable .dataTables_wrapper .dataTables_paginate .paginate_button.current, 
.main-datatable .dataTables_wrapper .dataTables_paginate .paginate_button.current:hover {
    color: #fff !important;
    border-color: transparent !important;
    background: #007bff !important;
}
.main-datatable .dataTables_paginate {
    padding-top: 0 !important;
    margin: 15px 10px;
    float: right !important;
}
.mode{
    padding:4px 10px;
    line-height: 13px;
    color:#fff;
    font-weight: 400;
    border-radius: 1rem;
    -webkit-border-radius: 1rem;
    -moz-border-radius: 1rem;
    -ms-border-radius: 1rem;
    -o-border-radius: 1rem;
    font-size:11px;
    letter-spacing: 0.4px;
}
.mode_on{
    background-color: #09922d;
}
.mode_off{
    background-color: #8b9096;
}
.mode_process{
    background-color: #ff8000;
}
.mode_done{
    background-color: #03a9f3;
}
@media only screen and (max-width:1200px){
    .overflow-x{
        overflow-x:scroll;
    }
    .overflow-x::-webkit-scrollbar{
        width:5px;
        height:6px;
    }
    .overflow-x::-webkit-scrollbar-thumb{
        background-color: #888;
    }
    .overflow-x::-webkit-scrollbar-track{
         background-color: #f1f1f1;
    }
}

</style>

<jsp:include page="dashboard_sidebar.jsp"></jsp:include>
  <section class="home-section">
	<jsp:include page="dashboard_navbar.jsp"></jsp:include>
    <div class="home-content">
    <div class="container p-30">
    <div class="row">
        <div class="col-md-12 main-datatable">
            <div class="card_body">
                <div class="row d-flex">
                    <div class="col-sm-4 createSegment"> 
                    <a class="btn dim_button create_new" data-toggle="modal" data-target="#exampleModalCenter1"><span class="glyphicon glyphicon-plus"></span>Add User</a>
                    </div>
					<!-- Modal -->
					<div class="modal fade" id="exampleModalCenter1" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle1" aria-hidden="true">
					  <div class="modal-dialog modal-dialog-centered" role="document">
					    <div class="modal-content">
					    <form action="RegistrationController" method="post">
					      <div class="modal-header">
					        <h5 class="modal-title" id="exampleModalCenterTitle1">Users</h5>
					        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
					          <span aria-hidden="true">&times;</span>
					        </button>
					      </div>
					      <div class="modal-body">

				      			  <div class="form-group row">
							      <label for="staticEmail" class="col-sm-2 col-form-label">Name</label>
							      <div class="col-sm-10">
							      	<input type="text" class="form-control" id="name" name= "name" placeholder="Name">
							      </div>
								  </div>

								  <div class="form-group row">
							      <label for="staticEmail" class="col-sm-2 col-form-label">Email</label>
							      <div class="col-sm-10">
							      	<input type="text" class="form-control" id="email" name= "email" placeholder="Email Id">
							      </div>
								  </div>	
								  
								  <div class="form-group row">
							      <label for="staticEmail" class="col-sm-2 col-form-label">Role</label>
							      <div class="col-sm-10">
							      	<select class="form-control" name="role">
									  	<option value="admin">Admin</option>
									  	<option value="teacher">Teacher</option>
									  	<option value="student">Student</option>
								  	</select>		
							      </div>
								  </div>				 
					      </div>
					      <div class="modal-footer">
					        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
					      
					      <input type="submit" class="btn btn-info" value="Add">
					      </div>
					      </form>
					    </div>
					  </div>
					</div>
                    
                    <div class="col-sm-8 add_flex">
                        <div class="form-group searchInput">
                            <label for="email">Search:</label>
                            <input type="search" class="form-control" id="filterbox" placeholder=" ">
                        </div>
                    </div> 
                </div>
                <div class="overflow-x">
	<%
	switch(role)
	{
		case "super-admin":
			sql="SELECT * FROM users where role in ('admin', 'teacher', 'student') order by id desc";
			break;
		case "admin":
			sql="SELECT * FROM users where role in ('teacher', 'student') order by id desc";
			break;
		case "teacher":
			sql="SELECT * FROM users where role in ('student') order by id desc";
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

 <table style="width:100%;" id="filtertable" class="table cust-datatable dataTable no-footer">
  <thead>
    <tr>
      <th style="min-width:50px;">ID</th>
      <th style="min-width:150px;">Role</th>
      <th style="min-width:150px;">Name</th>
      <th style="min-width:100px;">User Name</th>
      <th style="min-width:100px;">Email ID</th>
      <th style="min-width:150px;">Action</th>
    </tr>
  </thead>
  <tbody>
  <%
  	int i=1;
  	while(rs.next())		
	{		
  %>
    <tr>
      <td><%=i%></td>
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
		<span class="actionCust" data-toggle="modal" data-target="#exampleModalCenter<%=rs.getInt("id")%>">
		  <a href="#"><i class="fa fa-pencil-square-o" aria-hidden="true"></i></a>
		</span>
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
					    <label for="inputPassword" class="col-sm-2 col-form-label">Email</label>
					    <div class="col-sm-10">
					    	<input type="text" class="form-control-plaintext" id="staticEmail" value='<%=rs1.getString("email")%>' name = "email" placeholder="email@example.com">
					    </div>
					  </div>
					  
	      			  <div class="form-group row">
				      <label for="staticEmail" class="col-sm-2 col-form-label">Name</label>
				      <div class="col-sm-10">
				      	<input type="text" class="form-control" id="inputPassword" value='<%=rs1.getString("name")%>' name= "name" placeholder="Name">
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
   		<span class="actionCust">
   			<a href="<%=request.getContextPath()%>/DeleteController?id=<%=rs.getInt("id")%>">
   				<i class="fa fa-trash-o" aria-hidden="true"></i>
   			</a>
   		</span>
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
</div>
</div>
</div>
</div>
</div>
</section>
<jsp:include page="footer.jsp"></jsp:include>
<script src="https://cdn.datatables.net/1.10.14/js/jquery.dataTables.min.js"></script>
<script type=text/javascript>
let sidebar = document.querySelector(".sidebar");
let sidebarBtn = document.querySelector(".sidebarBtn");
sidebarBtn.onclick = function() {
  sidebar.classList.toggle("active");
  if(sidebar.classList.contains("active")){
  sidebarBtn.classList.replace("bx-menu" ,"bx-menu-alt-right");
}else
  sidebarBtn.classList.replace("bx-menu-alt-right", "bx-menu");
}

$(document).ready(function() {
    var dataTable = $('#filtertable').DataTable({
        "pageLength":5,
        'aoColumnDefs':[{
            'bSortable':false,
            'aTargets':['nosort'],
        }],
        columnDefs:[
            {type:'date-dd-mm-yyyy',aTargets:[5]}
        ],
        "aoColumns":[
            null,
            null,
            null,
            null,
            null,
            null,
            null
        ],
        "order":false,
        "bLengthChange":false,
        "dom":'<"top">ct<"top"p><"clear">'
    });
    $("#filterbox").keyup(function(){
        dataTable.search(this.value).draw();
    });
} );
</script>
<%}%>