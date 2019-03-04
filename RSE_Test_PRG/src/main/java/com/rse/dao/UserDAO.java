package com.rse.dao;

import java.util.List;

import com.rse.components.repositories.UserRepository;
import com.rse.domain.User;


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
	public void delete(long userId) {
		userRepository.deleteById(userId);

	}

	@Override
	public List<User> findAll() {
		return userRepository.findAll();
	}

	public User findUserByName(String username) {
		return userRepository.findByUsername(username);
	}

	public User findById(long id) {

		return userRepository.getOne(id);
	}



}
