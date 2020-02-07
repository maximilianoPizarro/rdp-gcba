package com.rdp.springmvc.model;

public enum HostAreaType {
	RRHH("RRHH"),
	RRMM("RRMM"),
	LEGALES("LEGALES");
	
	String areaType;
	
	private HostAreaType(String areaType){
		this.areaType = areaType;
	}
	
	public String getHostAreaType(){
		return areaType;
	}
	
}
