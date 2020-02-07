package com.rdp.springmvc.dao;

import java.util.List;

import com.google.gson.JsonElement;
import com.rdp.springmvc.model.Movimiento;

public interface MovimientoDao {
	
	List<Movimiento> traerMovimiento();

	List<Movimiento> traerMovimientoMac(String mac);
	
	void deleteMovimientoByMAC(String mac);
	

}
