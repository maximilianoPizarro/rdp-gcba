package com.rdp.springmvc.dao;

import java.util.List;

import com.rdp.springmvc.model.HostArea;

public interface HostAreaDao {
	
	
	List<HostArea> traerHostArea();

	HostArea findById(Integer id);

}
