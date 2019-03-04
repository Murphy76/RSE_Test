package com.rse.components.services;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.rse.components.repositories.UserRepository;
import com.rse.dao.UserDAO;
import com.rse.domain.User;

@Service
public class UserService {

	private final Logger log = LoggerFactory.getLogger(NoteService.class);

	@Autowired
	private PasswordEncoder passwordEncoder;

	UserRepository userRepository;
	UserDAO userDao;

	@Autowired
	public UserService(UserRepository userRepository) {
		userDao = new UserDAO(userRepository);
	}

	public List<User> findAll() {
		return userDao.findAll();
	}

	public User findById(long id) {

		return userDao.findById(id);
	}

	public User save(User user) {
		user.setPassword(passwordEncoder.encode( user.getPassword()));
		try {
			return userDao.save(user);
		} catch (Exception e) {
			log.error(e.getStackTrace().toString());
		}
		return new User();
	}

	public void deleteById(Long id) {
		try {
			userDao.delete(id);
		} catch (IllegalArgumentException e) {
			log.error(e.getStackTrace().toString());
		}


	}

}
