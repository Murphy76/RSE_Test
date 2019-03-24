package com.mycompany.sblogin.dao;

import java.util.List;

import org.hibernate.Hibernate;

import com.mycompany.sblogin.entity.User;
import com.mycompany.sblogin.repositories.UserRepository;


public class UserDAO implements UserDaoIF {


	//UserRepository userRepository;


	private UserRepository userRepository;


	public UserDAO(UserRepository repository) {
		this.userRepository = repository;
		System.out.println("Yes");
	}

	@Override
	public User save(User user) {
		return userRepository.saveAndFlush(user);

	}

	@Override
	public void delete(String userId) {
		userRepository.deleteById(userId);

	}

	@Override
	public List<User> findAll() {
		return userRepository.findAll();
	}

	public User findUserByName(String username) {
		return userRepository.findByUsername(username);
	}

	public User findByUsername(String id) {
		//Object unproxiedEntity = Hibernate.unproxy( proxy );
		return (User) Hibernate.unproxy( userRepository.getOne(id));
	}




}
