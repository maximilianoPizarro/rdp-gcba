package com.rdp.springmvc.service;

import java.util.List;

import com.rdp.springmvc.model.Movimiento;

public interface MovimientoService {
	
	List<Movimiento> traerMovimiento();
	
	String traerMovimientoJson();
	
	String traerMovimientoMacJson(String mac);
	
	void deleteMovimientoByMAC(String mac);

	
}
