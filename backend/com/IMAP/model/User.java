package com.IMAP.model;

import javax.servlet.http.Part;

public class User {
	private int id;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	private String role;
	private String name;
	private String username;
	private String email;
	private String password;
	private Part profile;

	public Part getProfile() {
		return profile;
	}

	public void setProfile(Part profile) {
		this.profile = profile;
	}

	public String getProfile_name() {
		return profile_name;
	}

	public void setProfile_name(String profile_name) {
		this.profile_name = profile_name;
	}

	public String getProfile_path() {
		return profile_path;
	}

	public void setProfile_path(String profile_path) {
		this.profile_path = profile_path;
	}

	private String profile_name;
	private String profile_path;

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}
}
