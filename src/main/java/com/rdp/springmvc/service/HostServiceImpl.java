package com.rdp.springmvc.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.google.gson.Gson;
import com.rdp.springmvc.dao.HostDao;
import com.rdp.springmvc.model.Host;
import com.rdp.springmvc.model.User;

@Service("hostService")
@Transactional
public class HostServiceImpl implements HostService {
	@Autowired
	private HostDao dao;

	public List<Host> traerHost() {
		return dao.traerHost();
	};

	public String traerHostJson() {
		Gson gson = new Gson();
		return  gson.toJson(dao.traerHost());
	}
	

	public void saveHost(Host host){
		dao.saveHost(host);		
	};
	
	public void updateHost(Host host){
		Host entity = dao.findByMAC(host.getMac());
		if(entity!=null){
		host.setIdhost(entity.getIdhost());
		dao.updateHost(host);
		}
	};
	
	public void observacionesHost(Host host,String observacion,int iduser){
		Host entity = dao.findByMAC(host.getMac());
		if(entity!=null){
		host.setIdhost(entity.getIdhost());
		host.setObservacion(observacion);
		host.setLoginultimomov(iduser);
		dao.updateHost(host);
		}
	};
	
	public void deleteHostByMAC(String mac){		
		dao.deleteHostByMAC(mac);		
	};

	public Host findByMAC(String mac){		
		Host host=dao.findByMAC(mac);
		return host;		
	};
	
	public Host findById(int id){		
		Host host=dao.findById(id);
		return host;		
	};
	
	


}
