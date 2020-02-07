package com.rdp.springmvc.model;

public enum UserProfileType {
	USER("Usuario"),
	COORDINADOR("Coordinador"),
	ADMIN("Administrador"),
	GERENTE("Gerencia");
	
	String userProfileType;
	
	private UserProfileType(String userProfileType){
		this.userProfileType = userProfileType;
	}
	
	public String getUserProfileType(){
		return userProfileType;
	}
	
}
