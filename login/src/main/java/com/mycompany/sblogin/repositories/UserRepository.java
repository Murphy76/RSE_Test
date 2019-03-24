package com.mycompany.sblogin.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.mycompany.sblogin.entity.User;

public interface UserRepository extends JpaRepository<User, String> {

	User findByUsername(String username);
	List<User> findAll ();

}
