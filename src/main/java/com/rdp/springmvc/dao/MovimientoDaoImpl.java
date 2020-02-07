package com.rdp.springmvc.dao;

import java.util.GregorianCalendar;
import java.util.List;

import javax.persistence.NoResultException;

import org.springframework.stereotype.Repository;

import com.rdp.springmvc.model.Host;
import com.rdp.springmvc.model.Movimiento;

@Repository("movimientoDao")

public class MovimientoDaoImpl extends AbstractDao<Integer, Movimiento> implements MovimientoDao {

	@SuppressWarnings("unchecked")
		public List<Movimiento> traerMovimiento() {
			List<Movimiento> objetos = null;
				String hql="FROM Movimiento m";
				
				objetos=(List<Movimiento>)getEntityManager()
						.createQuery(hql).getResultList();
				
				//System.out.println("AA : "+objetos.get(1));
		
			return objetos;
			}
	
		@SuppressWarnings("unchecked")
		public List<Movimiento> traerMovimientoMac(String mac) {
		List<Movimiento> objetos = null;
			String hql="FROM Movimiento m WHERE m.fkhost LIKE :mac";
			
			objetos=(List<Movimiento>)getEntityManager()
					.createQuery(hql).setParameter("mac", mac).getResultList();
			
			//System.out.println("AA : "+objetos.get(1));
	
		return objetos;
			}
		
		@SuppressWarnings("unchecked")
		public void deleteMovimientoByMAC(String mac){
			System.out.println("MAC : "+mac);
			
			List<Movimiento> mov = (List<Movimiento>) getEntityManager()
					.createQuery("FROM Movimiento m WHERE m.fkhost LIKE :mac")
					.setParameter("mac", mac).getResultList();			
			for(Movimiento elemento:mov)
				delete(elemento);
		}
	
		

	}

