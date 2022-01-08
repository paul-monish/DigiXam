package com.IMAP.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.IMAP.DAO.DatabaseDAO;
import com.IMAP.model.User;
import com.IMAP.required.RandomUsername;

public class RegistrationController extends HttpServlet {
	private static final long serialVersionUID = 1L;
     
    public RegistrationController() {
        super();
        
    }
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		String name =request.getParameter("name");
		String email =request.getParameter("email");
		String password =request.getParameter("password");
		String username = name.split(" ", 2)[0].toLowerCase()+new RandomUsername().generateUsername(3);
		User u= new User();
		u.setName(name);
		u.setUsername(username);
		u.setEmail(email);
		u.setPassword(password);
		//out.println(u.getUsername());
		DatabaseDAO dao;
		try {
			dao = new DatabaseDAO();
			dao.registration(u);
			HttpSession session= request.getSession();
			session.setAttribute("username", u.getUsername());
			session.setAttribute("email", u.getEmail());
			response.sendRedirect("home");
		} catch (SQLException e) {
			e.printStackTrace();
			
		}
		
	}

}
