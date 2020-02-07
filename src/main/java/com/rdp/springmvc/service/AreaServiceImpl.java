package com.rdp.springmvc.service;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.google.gson.Gson;
import com.rdp.springmvc.dao.HostAreaDao;
import com.rdp.springmvc.model.HostArea;

@Service("areaService")
@Transactional
public class AreaServiceImpl implements AreaService {
	@Autowired
	private HostAreaDao dao;

	public String traerAreaJson() {
		Gson gson = new Gson();
		return  gson.toJson(dao.traerHostArea());
	}
	
	public List<HostArea> traerAreas(){
		return dao.traerHostArea();
	}
	
	
	public HostArea findById(Integer id){
		return dao.findById(id);
	};
	

}
