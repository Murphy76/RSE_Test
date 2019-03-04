package com.rse.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.rse.components.services.UserService;
import com.rse.domain.User;

@RestController
public class UserRestController {
	@Autowired
	UserService userService;

	@GetMapping("/rest/users")
	public List<User> all() {
		System.out.println(userService.findAll().size());
		return userService.findAll();
	}

	@GetMapping("/rest/users/{id}")
	public User getOneUser(@PathVariable Long id) {
		System.out.println("YES????");
		return userService.findById(1L);
	}

	@RequestMapping(value = "/rest/users", method = RequestMethod.POST)
	@ResponseBody
	User newUser(@RequestBody User newUser) {
		System.out.println("Post!!!");
		return userService.save(newUser);
	}

//		@PutMapping("/employees/{id}")
//		User replaceUser(@RequestBody User user, @PathVariable Long id) {
//
//			return userService.findById(id)
//				.map(employee -> {
//					employee.setName(newEmployee.getName());
//					employee.setRole(newEmployee.getRole());
//					return userService.save(employee);
//				})
//				.orElseGet(() -> {
//					newEmployee.setId(id);
//					return userService.save(newEmployee);
//				});
//		}

		@DeleteMapping("/rest/users/{id}")
		void deleteEmployee(@PathVariable Long id) {
			userService.deleteById(id);
		}

}
