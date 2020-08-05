package com.rdp.springmvc.service;

import java.util.List;

import com.rdp.springmvc.model.User;


public interface UserService {
	
	User findById(int id);
	
	User findBySSO(String sso);
	
	void saveUser(User user);
	
	void updateUser(User user);
	
	void actualizarUsuario(User user);
	
	void deleteUserBySSO(String sso);

	List<User> findAllUsers(); 
	
	String findAllUsersJson(); 
	
	boolean isUserSSOUnique(Integer id, String sso);
	
	User usuarioExiste(String user, String password);
	
	User findByEmail(String email);
	
	String traerEmailGerencia();


}