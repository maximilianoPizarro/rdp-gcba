package com.rdp.springmvc.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.google.gson.Gson;
import com.rdp.springmvc.dao.MovimientoDao;
import com.rdp.springmvc.model.Movimiento;

@Service("movimientoService")
@Transactional
public class MovimientoServiceImpl implements MovimientoService {
	@Autowired
	private MovimientoDao dao;

	public List<Movimiento> traerMovimiento() {
		return dao.traerMovimiento();
	};

	public String traerMovimientoJson() {
		Gson gson = new Gson();
		return  gson.toJson(dao.traerMovimiento());
	}
	
	public String traerMovimientoMacJson(String mac) {
		Gson gson = new Gson();
		return  gson.toJson(dao.traerMovimientoMac(mac));
	}
	
	public void deleteMovimientoByMAC(String mac){
		dao.deleteMovimientoByMAC(mac);
	}


}
