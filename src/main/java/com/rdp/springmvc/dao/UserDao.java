package com.rdp.springmvc.dao;

import java.util.List;

import com.rdp.springmvc.model.User;


public interface UserDao {

	User findById(int id);
	
	User findBySSO(String sso);
	
	void save(User user);
	
	void deleteBySSO(String sso);
	
	List<User> findAllUsers();
	
	User existeUsuario(String user, String pass);
	
	User findByEmail(String email);

}

