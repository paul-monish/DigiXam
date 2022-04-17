package com.IMAP.DAO;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.IMAP.model.AssignedUserDepartmentSubject;
import com.IMAP.model.Department;
import com.IMAP.model.Examination;
import com.IMAP.model.ForgotPasswordModel;
import com.IMAP.model.NewPasswordModel;
import com.IMAP.model.Subject;
import com.IMAP.model.User;
import com.IMAP.model.UserDepartmentSubject;
import com.google.gson.Gson;

public class DatabaseDAO {
	DbConnection dbcon;
	Connection con;

	public DatabaseDAO() throws SQLException {
		super();
		dbcon = new DbConnection();
		con = dbcon.getConnection();
	}

	public void registration(User u) throws SQLException {
		String sql = "INSERT INTO users (role,name,email,username,password) VALUES (?,?,?,?,md5(?))";
		PreparedStatement st = con.prepareStatement(sql);
		st.setString(1, u.getRole());
		st.setString(2, u.getName());
		st.setString(3, u.getEmail());
		st.setString(4, u.getUsername());
		st.setString(5, u.getPassword());
		int i = st.executeUpdate();
		System.out.println(i + " row inserted succesfully.");

	}

	public boolean login(User u) throws SQLException {
		String sql = "SELECT * FROM users WHERE (email=? OR username=?) AND password=md5(?)";
		PreparedStatement st = con.prepareStatement(sql);
		st.setString(1, u.getEmail());
		st.setString(2, u.getUsername());
		st.setString(3, u.getPassword());
		ResultSet rs = st.executeQuery();
		if (rs.next())
			return true;
		else
			return false;
	}

	public boolean isExistEmail(ForgotPasswordModel fpm) throws SQLException {
		String sql = "SELECT * FROM users WHERE email=?";
		PreparedStatement st = con.prepareStatement(sql);
		st.setString(1, fpm.getEmail());
		ResultSet rs = st.executeQuery();
		if (rs.next())
			return true;
		else
			return false;
	}

	public int updatePassword(NewPasswordModel npm) throws SQLException {
		String sql = "UPDATE users set password=md5(?) where email=?";
		PreparedStatement st = con.prepareStatement(sql);
		st.setString(1, npm.getPassword());
		st.setString(2, npm.getEmail());
		int i = st.executeUpdate();
		System.out.println(i + " row updated succesfully.");
		return i;
	}

	public boolean isExistPassword(NewPasswordModel npm) throws SQLException {
		String sql = "SELECT * FROM users WHERE email=? and password=md5(?)";
		PreparedStatement st = con.prepareStatement(sql);
		st.setString(1, npm.getEmail());
		st.setString(2, npm.getPassword());
		ResultSet rs = st.executeQuery();
		if (rs.next())
			return true;
		else
			return false;
	}

	public int deleteUser(int id) throws SQLException {
		String sql = "DELETE from users where id=?";
		PreparedStatement st = con.prepareStatement(sql);
		st.setInt(1, id);
		int s = st.executeUpdate();
		System.out.println(s);
		try {
			st.close();
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return s;
	}

	public int editUser(User u, InputStream is) throws SQLException {
		String sql = "UPDATE users set name = ?, email = ?,profile_img=?, profile_path=? where id=?";
		PreparedStatement st = con.prepareStatement(sql);
		st.setString(1, u.getName());
		st.setString(2, u.getEmail());
		st.setString(3, u.getProfile_name());
		st.setString(4, u.getProfile_path());
		st.setInt(5, u.getId());
		int s = st.executeUpdate();
		System.out.println(s);
		try {
			st.close();
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return s;
	}

	public void insertDepartment(Department d) throws SQLException {
		String sql = "INSERT INTO Department (name) VALUES (?)";
		PreparedStatement st = con.prepareStatement(sql);
		st.setString(1, d.getName());
		int i = st.executeUpdate();
		System.out.println(i + " row inserted succesfully.");

	}

	public int deleteDepartment(int id) throws SQLException {
		String sql = "DELETE from department where id=?";
		PreparedStatement st = con.prepareStatement(sql);
		st.setInt(1, id);
		int s = st.executeUpdate();
		System.out.println(s);
		try {
			st.close();
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return s;
	}

	public int editDepartment(Department d) throws SQLException {
		String sql = "UPDATE department set name = ? where id=?";
		PreparedStatement st = con.prepareStatement(sql);
		st.setString(1, d.getName());
		st.setInt(2, d.getId());
		int s = st.executeUpdate();
		System.out.println(s);
		try {
			st.close();
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return s;
	}

	public void insertSubject(Subject d) throws SQLException {
		String sql = "INSERT INTO subjects (name) VALUES (?)";
		PreparedStatement st = con.prepareStatement(sql);
		st.setString(1, d.getName());
		int i = st.executeUpdate();
		System.out.println(i + " row inserted succesfully.");

	}

	public int deleteSubject(int id) throws SQLException {
		String sql = "DELETE from subjects where id=?";
		PreparedStatement st = con.prepareStatement(sql);
		st.setInt(1, id);
		int s = st.executeUpdate();
		System.out.println(s);
		try {
			st.close();
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return s;
	}

	public int editSubject(Subject d) throws SQLException {
		String sql = "UPDATE subjects set name = ? where id=?";
		PreparedStatement st = con.prepareStatement(sql);
		st.setString(1, d.getName());
		st.setInt(2, d.getId());
		int s = st.executeUpdate();
		System.out.println(s);
		try {
			st.close();
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return s;
	}

	public void assigned(UserDepartmentSubject uds) throws SQLException {
		String sql = "INSERT INTO user_department_subject (user_id,dept_id,sub_id) VALUES (?,?,?)";
		PreparedStatement st = con.prepareStatement(sql);
		st.setInt(1, uds.getUser_id());
		st.setInt(2, uds.getDept_id());
		st.setInt(3, uds.getSub_id());
		int i = st.executeUpdate();
		System.out.println(i + " row inserted succesfully.");
	}

	public int deleteAssigned(int id) throws SQLException {
		String sql = "DELETE from user_department_subject where id=?";
		PreparedStatement st = con.prepareStatement(sql);
		st.setInt(1, id);
		int s = st.executeUpdate();
		System.out.println(s);
		try {
			st.close();
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return s;
	}

	public int editAssigned(AssignedUserDepartmentSubject uds) throws SQLException {
		String sql = "UPDATE user_department_subject set user_id = ?,dept_id=?,sub_id=? where id=?";
		PreparedStatement st = con.prepareStatement(sql);

		st.setInt(1, uds.getUser_id());
		st.setInt(2, uds.getDept_id());
		st.setInt(3, uds.getSub_id());
		st.setInt(4, uds.getId());
		int s = st.executeUpdate();
		System.out.println(s);
		try {
			st.close();
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return s;
	}

	public void insertExam(Examination e, InputStream is) {
		String sql = "INSERT INTO examination (user_id,dept_id,sub_id,qsn_name,question) VALUES (?,?,?,?,?)";
		try {

//			java.util.Date utilDate = new java.util.Date();
//	        java.sql.Date sqlDate = new java.sql.Date(utilDate.getTime());
//	        java.sql.Time sqlTime = new java.sql.Time(utilDate.getTime());
			PreparedStatement st = con.prepareStatement(sql);
			st.setInt(1, e.getUser_id());
			st.setInt(2, e.getDept_id());
			st.setInt(3, e.getSub_id());

			if (is != null) {
				String j = new Gson().toJson(e.getQsn_name());
				System.out.println(j);
				// Array anArray = con.createArrayOf("VARCHAR", e.getQsn_name());
				st.setString(4, j);
				st.setBinaryStream(5, is, (int) e.getQsn().getSize());

			}

//			st.setDate(5, sqlDate);
//			st.setTime(6, sqlTime);
//			st.setString(7, h.getAuthorName());
			int i = st.executeUpdate();
			System.out.println(i + "row inserted for upload table");
		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}

	public int deleteExamination(int id) throws SQLException {
		String sql = "DELETE from examination where id=?";
		PreparedStatement st = con.prepareStatement(sql);
		st.setInt(1, id);
		int s = st.executeUpdate();
		System.out.println(s);
		try {
			st.close();
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return s;
	}

	public int editExamination(Examination e, InputStream is) throws SQLException {
		String sql = "UPDATE examination set user_id = ?,dept_id=?,sub_id=?,qsn_name=?,question=? where id=?";
		PreparedStatement st = con.prepareStatement(sql);

		st.setInt(1, e.getUser_id());
		st.setInt(2, e.getDept_id());
		st.setInt(3, e.getSub_id());
		if (is != null) {
			String j = new Gson().toJson(e.getQsn_name());
			System.out.println(j);
			// Array anArray = con.createArrayOf("VARCHAR", e.getQsn_name());
			st.setString(4, j);
			st.setBinaryStream(5, is, (int) e.getQsn().getSize());

		}
		st.setInt(6, e.getId());
		int s = st.executeUpdate();
		System.out.println(s);
		try {
			st.close();
			con.close();
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return s;
	}

	public String[] getFileName(int id) throws SQLException {
		String sql = "SELECT * FROM examination WHERE id=?";
		PreparedStatement st = con.prepareStatement(sql);
		st.setInt(1, id);
		ResultSet rs = st.executeQuery();
		if (rs.next()) {
			return new String[] { "true", rs.getString("qsn_name") };
		} else
			return new String[] { "false", null };

	}

	public String getSubjectName(int id) throws SQLException {
		String sql = "SELECT * FROM examination as e inner join subjects as s on e.sub_id=s.id WHERE e.id=?";
		PreparedStatement st = con.prepareStatement(sql);
		st.setInt(1, id);
		ResultSet rs = st.executeQuery();
		if (rs.next()) {
			return rs.getString("s.name");
		} else
			return null;

	}

	public int removeProfile(int id) throws SQLException {
		String sql = "DELETE profile_img,profile_path from users where id=?";
		PreparedStatement st = con.prepareStatement(sql);
		st.setInt(1, id);
		int s = st.executeUpdate();
		System.out.println(s);
		try {
			st.close();
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return s;
	}
}
