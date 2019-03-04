package com.rse.components.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.rse.domain.Role;

public interface RoleRepository extends JpaRepository<Role, String> {

}
