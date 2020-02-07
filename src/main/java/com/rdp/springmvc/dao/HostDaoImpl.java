package com.rdp.springmvc.dao;

import java.util.List;

import javax.persistence.NoResultException;

import org.hibernate.Query;
import org.springframework.stereotype.Repository;

import com.rdp.springmvc.model.Host;
import com.rdp.springmvc.model.User;

@Repository("hostDao")

public class HostDaoImpl extends AbstractDao<Integer, Host> implements HostDao {

	@SuppressWarnings("unchecked")
		public List<Host> traerHost() {
			List<Host> objetos = null;
				String hql="FROM HostView h";
				
				objetos=(List<Host>)getEntityManager()
						.createQuery(hql).getResultList();
				
				//System.out.println("AA : "+objetos.get(1));
		
			return objetos;
			}
	
	@SuppressWarnings("unchecked")
	public List<Host> traerHostTwoWeek() {
		List<Host> objetos = null;
			String hql="FROM HostViewTwoWeek h";
			
			objetos=(List<Host>)getEntityManager()
					.createQuery(hql).getResultList();
			
			//System.out.println("AA : "+objetos.get(1));
	
		return objetos;
		}
	
	
	public void saveHost(Host host){
		persist(host);		
	}
	
	public void  updateHost(Host host){
		update(host);
	};
	
	
	public void deleteHostByMAC(String mac){
		System.out.println("MAC : "+mac);
		Host host = (Host) getEntityManager()
				.createQuery("SELECT h FROM Host h WHERE h.mac LIKE :mac")
				.setParameter("mac", mac)
				.getSingleResult();
		delete(host);
		
	}

	public Host findByMAC(String mac){
		System.out.println("mac : "+mac);
		try{
			Host host = (Host) getEntityManager()
					.createQuery("SELECT h FROM Host h WHERE h.mac LIKE :mac")
					.setParameter("mac", mac)
					.getSingleResult();
			return host; 
		}catch(NoResultException ex){
			return null;
		}	
		
	}
	
	public Host findById(int id){
			Host host = getByKey(id);
			return host; 
	}		
		
}

