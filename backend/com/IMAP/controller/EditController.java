package com.IMAP.controller;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.IMAP.DAO.DatabaseDAO;
import com.IMAP.model.User;


public class EditController extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
    public EditController() {
        super();
        
    }
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String id= request.getParameter("id");
		String name= request.getParameter("name");
		String email= request.getParameter("email");
		User u= new User();
		u.setId(Integer.parseInt(id));
		u.setName(name);
		u.setEmail(email);
		DatabaseDAO dao;
		try {
			dao = new DatabaseDAO();
			if(dao.editUser(u)>=1)
			{
				response.sendRedirect("home");
			}	
			else
			{
				request.getSession().setAttribute("msg", "Server Error!");
				response.sendRedirect("error.jsp");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}	
	}

}
