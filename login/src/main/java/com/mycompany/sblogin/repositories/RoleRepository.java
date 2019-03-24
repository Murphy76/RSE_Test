package com.mycompany.sblogin.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.mycompany.sblogin.entity.Role;

public interface RoleRepository extends JpaRepository<Role, String> {

}
