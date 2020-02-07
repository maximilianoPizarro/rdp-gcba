package com.rdp.springmvc.dao;

import java.util.List;

import com.google.gson.JsonElement;
import com.rdp.springmvc.model.Host;

public interface HostDao {
	
	void saveHost(Host host);
	
	void updateHost(Host host);
	
	
	void deleteHostByMAC(String mac);

	Host findByMAC(String mac);
	
	Host findById(int id);
	
	List<Host> traerHost();


}
