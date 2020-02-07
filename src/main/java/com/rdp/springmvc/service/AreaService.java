package com.rdp.springmvc.service;

import java.util.List;

import com.rdp.springmvc.model.Host;
import com.rdp.springmvc.model.HostArea;
import com.rdp.springmvc.model.User;

public interface AreaService {

	String traerAreaJson();
	
	List<HostArea> traerAreas();

	HostArea findById(Integer id);
}
