package com.mycompany.sblogin.controllers;

import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.mycompany.sblogin.model.Employee;
import com.mycompany.sblogin.service.EmployeeService;
import com.mycompany.sblogin.service.NoteService;

@Controller
public class EmployeeController {

	@Autowired
	EmployeeService employeeService;

	@Autowired
	NoteService noteService;

	@RequestMapping({"/","/welcome"})
	public ModelAndView firstPage() {
		return new ModelAndView("welcome");
	}


	@RequestMapping(value = "/registration", method = RequestMethod.GET)
	public ModelAndView resistration(HttpServletRequest request, HttpServletResponse response) {

		ModelAndView model = new ModelAndView("registration");
		model.addObject("emp", new Employee());
		return model;
	}

	@RequestMapping(value = "/registerprocess", method = RequestMethod.POST)
	  public ModelAndView addUser(HttpServletRequest request, HttpServletResponse response,
	  @ModelAttribute("emp") Employee emp) {
		employeeService.insertEmployee(emp);
	  return new ModelAndView("welcome", "firstname", emp.getEmpName());
	  }



	@RequestMapping(value = "/addNewEmployee", method = RequestMethod.GET)
	public ModelAndView show() {
		return new ModelAndView("addEmployee", "emp", new Employee());
	}

	@RequestMapping(value = "/addNewEmployee", method = RequestMethod.POST)
	public ModelAndView processRequest(@ModelAttribute("emp") Employee emp) {

		employeeService.insertEmployee(emp);
		List<Employee> employees = employeeService.getAllEmployees();
		ModelAndView model = new ModelAndView("getEmployees");
		model.addObject("employees", employees);
		return model;
	}

	@RequestMapping("/getEmployees")
	public ModelAndView getEmployees() {
		List<Employee> employees = employeeService.getAllEmployees();
		ModelAndView model = new ModelAndView("getEmployees");
		model.addObject("employees", employees);
		return model;
	}

	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String login(Model model, String error, String logout) {
		if (error != null)
			model.addAttribute("errorMsg", "Your username and password are invalid.");

		if (logout != null)
			model.addAttribute("msg", "You have been logged out successfully.");

		return "login";
	}
	@RequestMapping(value = {"/logout"}, method = RequestMethod.POST)
	public String logoutDo(HttpServletRequest request,HttpServletResponse response){
	HttpSession session= request.getSession(false);
	    SecurityContextHolder.clearContext();
	         session= request.getSession(false);
	        if(session != null) {
	            session.invalidate();
	        }
	        for(Cookie cookie : request.getCookies()) {
	            cookie.setMaxAge(0);
	        }

	    return "logout";
	}

	@GetMapping("/notes")
    public String notesPage( Model model) {

       // model.addAttribute("notes", noteService.findAll());
        return "notes";
    }

}
