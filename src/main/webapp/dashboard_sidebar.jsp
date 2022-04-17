<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import= "java.sql.*, com.IMAP.DAO.DbConnection,com.IMAP.required.UserRole"%>
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
		role=new UserRole().getRole((String)session.getAttribute("email"),(String)session.getAttribute("username"))[0];
		user=new UserRole().getRole((String)session.getAttribute("email"),(String)session.getAttribute("username"))[1];
%>
<style>
[class*=sidebar-dark] .brand-link {
    border-bottom: none;
}
</style>
  <!-- Main Sidebar Container -->
    <aside class="main-sidebar sidebar-dark-primary elevation-4 position-fixed">
      <!-- Brand Logo -->
      <a href="<%=request.getContextPath()%>/login" class="brand-link">
        <img src="Assets/dist/img/Sidebar_logo.png"  alt="DigiXam" class="brand-image" style="max-height: 53px;" > <!-- class="brand-image img-circle elevation-3" style="opacity: .8" -->
        <span class="brand-text text-light" style="font-size:120%">DigiXam</span>
      </a>
  
      <!-- Sidebar -->
      <div class="sidebar">
        <!-- Sidebar user (optional) 
        <div class="user-panel mt-3 pb-3 mb-3 d-flex">
          <div class="image">
            <img src="Assets/dist/img/profile.jpg" class="img-circle elevation-2" alt="User Image">
          </div>
          <div class="info">
            <a href="#" class="d-block text-light">  </a>
          </div>
        </div>
  -->
  
        <!-- Sidebar Menu -->
        <nav class="mt-2">
          <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">
            <!-- Add icons to the links using the .nav-icon class
                 with font-awesome or any other icon font library -->
            <%if(!role.equals("student")){%>
            <li class="nav-item ">
              <a href="<%=request.getContextPath()%>/home" class="nav-link text-light">
                <i class="nav-icon  fas fa-th "></i>
                <p>
                  Dashboard
                </p>
              </a>
            </li>
            <li class="nav-item">
              <a href="<%=request.getContextPath()%>/user" class="nav-link text-light">
                <i class="nav-icon fas fa-user"></i>
                <p>
                  Teacher
                </p>
              </a>
            </li>
             <li class="nav-item">
              <a href="<%=request.getContextPath()%>/student" class="nav-link text-light">
                <i class="nav-icon fas fa-user"></i>
                <p>
                  Student
                </p>
              </a>
            </li>
            <%} %>
            <%if(role.equals("admin") || role.equals("super-admin")){%>
            <li class="nav-item">
              <a href="<%=request.getContextPath()%>/department" class="nav-link text-light">
                <i class="nav-icon fas fa-user"></i>
                <p>
                  Department
                </p>
              </a>
            </li>
            <li class="nav-item">
              <a href="<%=request.getContextPath()%>/subject" class="nav-link text-light">
                <i class="nav-icon fas fa-user"></i>
                <p>
                  Subject
                </p>
              </a>
            </li>
            <li class="nav-item">
              <a href="<%=request.getContextPath()%>/assign" class="nav-link text-light">
                <i class="nav-icon fas fa-user"></i>
                <p>
                  Subject Assigned
                </p>
              </a>
            </li>
            <%} %>
            <li class="nav-item">
              <a href="<%=request.getContextPath()%>/examination" class="nav-link text-light">
                <i class="nav-icon fa fa-graduation-cap"></i>
                <p>
                  Examination
                </p>
              </a>
            </li>
            
          </ul>
        </nav>
        <!-- /.sidebar-menu -->
      </div>
      <!-- /.sidebar -->
    </aside>
<%} %>
  