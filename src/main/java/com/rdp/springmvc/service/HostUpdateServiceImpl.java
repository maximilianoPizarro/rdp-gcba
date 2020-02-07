package com.rdp.springmvc.service;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.rdp.springmvc.dao.HostUpdateDao;
import com.rdp.springmvc.model.HostUpdate;

@Service("hostUpdateService")
@Transactional
public class HostUpdateServiceImpl implements HostUpdateService{
	@Autowired
	
	private HostUpdateDao dao;
	
	public void saveHost(HostUpdate hostUpdate){
		dao.saveHost(hostUpdate);	
	};
	
}
