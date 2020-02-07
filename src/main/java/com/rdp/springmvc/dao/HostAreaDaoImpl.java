package com.rdp.springmvc.dao;

import java.util.List;

import javax.persistence.NoResultException;

import org.springframework.stereotype.Repository;

import com.rdp.springmvc.model.Host;
import com.rdp.springmvc.model.HostArea;
import com.rdp.springmvc.model.User;
import com.rdp.springmvc.model.UserProfile;

@Repository("hostAreaDao")

public class HostAreaDaoImpl extends AbstractDao<Integer, HostArea> implements HostAreaDao {

	
	@SuppressWarnings("unchecked")
	public List<HostArea> traerHostArea() {
		List<HostArea> objetos = null;
			String hql="FROM HostArea h";
			
			objetos=(List<HostArea>)getEntityManager()
					.createQuery(hql).getResultList();			
	
		return objetos;
		}
	
	public HostArea findById(Integer id){
		return getByKey(id);
	}


	}

