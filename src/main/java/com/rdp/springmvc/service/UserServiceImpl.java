package com.rdp.springmvc.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.google.gson.Gson;
import com.rdp.springmvc.dao.UserDao;
import com.rdp.springmvc.model.User;


@Service("userService")
@Transactional
public class UserServiceImpl implements UserService{

	@Autowired
	private UserDao dao;

	public User findById(int id) {
		return dao.findById(id);
	}

	public User findBySSO(String sso) {
		User user = dao.findBySSO(sso);
		return user;
	}

	public void saveUser(User user) {
		dao.save(user);
	}

	/*
	 * Since the method is running with Transaction, No need to call hibernate update explicitly.
	 * Just fetch the entity from db and update it with proper values within transaction.
	 * It will be updated in db once transaction ends. 
	 */
	public void updateUser(User user) {
		User entity = dao.findById(user.getId());
		if(entity!=null){
			entity.setSsoId(user.getSsoId());
			entity.setPassword(user.getPassword());
			entity.setFirstName(user.getFirstName());
			entity.setLastName(user.getLastName());
			entity.setEmail(user.getEmail());
			entity.setUserProfiles(user.getUserProfiles());
		}
	}
	
	public void actualizarUsuario(User user) {
		User entity = dao.findById(user.getId());
		if(entity!=null){
			entity.setSsoId(user.getSsoId());
			entity.setPassword(user.getPassword());
			entity.setEmail(user.getEmail());
		}
	}

	
	public void deleteUserBySSO(String sso) {
		dao.deleteBySSO(sso);
	}

	public List<User> findAllUsers() {
		return dao.findAllUsers();
	}
	
	public String findAllUsersJson() {
		Gson gson = new Gson();
		return gson.toJson(dao.findAllUsers());
	}

	public boolean isUserSSOUnique(Integer id, String sso) {
		User user = findBySSO(sso);
		return ( user == null || ((id != null) && (user.getId() == id)));
	}
	
	public User usuarioExiste(String user, String password) {
		User respuesta=null;
		respuesta=dao.existeUsuario(user,password);
		return respuesta;
	}
	
	public User findByEmail(String email) {
		User respuesta=null;
		respuesta=dao.findByEmail(email);
		return respuesta;
	}
	
	public String traerEmailGerencia(){
		String respuesta = "";
		List<User> objetos=dao.findAllUsers();
		
		for(User elemento:objetos){
			if(elemento.esAdmin() || elemento.esGerente() )
				respuesta=respuesta+","+elemento.getEmail();
		}
		
		return respuesta.substring(1);}
	
}
