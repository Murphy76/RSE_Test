package com.rse.components.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.rse.domain.User;

public interface UserRepository extends JpaRepository<User, Long> {

	User findByUsername(String username);
	List<User> findAll ();

}
