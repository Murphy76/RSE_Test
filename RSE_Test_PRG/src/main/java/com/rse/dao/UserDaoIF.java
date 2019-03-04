package com.rse.dao;

import java.util.List;

import com.rse.domain.User;

public interface UserDaoIF {

	public User save(User user);
	public void delete(long userId);
	public User findUserByName(String username);
	public List<User> findAll();

}
