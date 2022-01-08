package com.IMAP.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.IMAP.model.ForgotPasswordModel;
import com.IMAP.model.NewPasswordModel;
import com.IMAP.model.User;

public class DatabaseDAO {
	DbConnection dbcon;
	Connection con;
	
	public DatabaseDAO() throws SQLException {
		super();
		dbcon= new DbConnection();
		con= dbcon.getConnection();
	}
	
	public void registration(User u) throws SQLException
	{
		String sql= "INSERT INTO users (name,email,username,password) VALUES (?,?,?,md5(?))";
		PreparedStatement st= con.prepareStatement(sql);
		st.setString(1, u.getName());
		st.setString(2, u.getEmail());
		st.setString(3, u.getUsername());
		st.setString(4, u.getPassword());
		int i= st.executeUpdate();
		System.out.println(i+" row inserted succesfully.");
		
	}
	public boolean login(User u) throws SQLException
	{
		String sql="SELECT * FROM users WHERE email=? OR username=? AND password=md5(?)";
		PreparedStatement st= con.prepareStatement(sql);
		st.setString(1, u.getEmail());
		st.setString(2, u.getUsername());
		st.setString(3, u.getPassword());
		ResultSet rs= st.executeQuery();
		if(rs.next())
			return true;
		else 
			return false;
	}
	public boolean isExistEmail(ForgotPasswordModel fpm) throws SQLException {
		String sql="SELECT * FROM users WHERE email=?";
		PreparedStatement st= con.prepareStatement(sql);
		st.setString(1, fpm.getEmail());
		ResultSet rs= st.executeQuery();
		if(rs.next())
			return true;
		else 
			return false;
	}
	public int updatePassword(NewPasswordModel npm) throws SQLException
	{
		String sql= "UPDATE users set password=md5(?) where email=?";
		PreparedStatement st= con.prepareStatement(sql);
		st.setString(1, npm.getPassword());
		st.setString(2, npm.getEmail());
		int i= st.executeUpdate();
		System.out.println(i+" row updated succesfully.");
		return i;
	}
	
	public boolean isExistPassword(NewPasswordModel npm) throws SQLException 
	{
		String sql="SELECT * FROM users WHERE email=? and password=md5(?)";
		PreparedStatement st= con.prepareStatement(sql);
		st.setString(1, npm.getEmail());
		st.setString(2, npm.getPassword());
		ResultSet rs= st.executeQuery();
		if(rs.next())
			return true;
		else 
			return false;
	}
	
}
