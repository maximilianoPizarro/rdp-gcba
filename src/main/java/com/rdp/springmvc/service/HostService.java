package com.rdp.springmvc.service;

import java.util.List;

import com.rdp.springmvc.model.Host;
import com.rdp.springmvc.model.User;

public interface HostService {
	
	void saveHost(Host host);
	
	void updateHost(Host host);
	
	void observacionesHost(Host host,String observacion,int iduser);
	
	void deleteHostByMAC(String mac);

	Host findByMAC(String mac);
	
	Host findById(int id);
	
	List<Host> traerHost();
	
	String traerHostJson();
	
}
