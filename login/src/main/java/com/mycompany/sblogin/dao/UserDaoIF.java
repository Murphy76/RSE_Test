package com.mycompany.sblogin.dao;

import java.util.List;

import com.mycompany.sblogin.entity.User;

public interface UserDaoIF {

	public User save(User user);
	public void delete(String userId);
	public User findUserByName(String username);
	public List<User> findAll();

}
