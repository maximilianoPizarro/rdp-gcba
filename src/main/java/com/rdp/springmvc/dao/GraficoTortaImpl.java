package com.rdp.springmvc.dao;


import org.springframework.stereotype.Service;


@Service("graficoService")
public class GraficoTortaImpl extends AbstractDao<Integer, String> implements GraficoTortaService {

	public String pcPorArea() {
		String resultado=(String)getEntityManager().createStoredProcedureQuery("pc_por_area").getSingleResult();			
		return  "["+resultado+"]";
	}
	
	public String activosHoy() {
		String resultado=(String)getEntityManager().createStoredProcedureQuery("activos_hoy").getSingleResult();			
		return  "["+resultado+"]";
	}
	

	

}
