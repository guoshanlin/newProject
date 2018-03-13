package com.net.bean;

import java.util.UUID;

public class User {
	private String userName;
	private String password;
	private String id;
	private Integer age;
	
	public User(){
		super();
	}
	
	public User(String userName, String password,Integer age){
		super();
		this.userName = userName;
		this.password = password;
		this.age = age;
		this.id= getUUID();
	}
	
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getId() {
		return id;
	}
	public void setId() {
		this.id = getUUID();
	}
	
	public Integer getAge() {
		return age;
	}

	public void setAge(Integer age) {
		this.age = age;
	}

	public static String getUUID() {
		return UUID.randomUUID().toString().replace("-", "").toUpperCase();
	};
}
