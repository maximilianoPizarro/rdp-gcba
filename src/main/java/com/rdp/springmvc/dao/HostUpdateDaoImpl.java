package com.rdp.springmvc.dao;

import org.springframework.stereotype.Repository;

import com.rdp.springmvc.model.HostUpdate;

@Repository("hostUpdate")

public class HostUpdateDaoImpl extends  AbstractDao<Integer, HostUpdate> implements HostUpdateDao {
	
	public void saveHost(HostUpdate hostUpdate){
		persist(hostUpdate);		
	}	
	


}
