package com.rse.controller;

import java.net.URI;
import java.net.URISyntaxException;

import javax.servlet.http.HttpServletRequest;

import org.springframework.hateoas.mvc.ControllerLinkBuilder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;

import com.rse.domain.Note;


@Controller
public class MainWebController {





	  @GetMapping("/index")
	    public String greeting(@RequestParam(name="name", required=false, defaultValue="World") String name, Model model, HttpServletRequest request) {
		  RestTemplate restTemplate = new RestTemplate();
		  ControllerLinkBuilder linkBuilder = ControllerLinkBuilder.linkTo(MainWebController.class );
		  linkBuilder.toString();
		  Object[] notes = restTemplate.getForObject(linkBuilder.toString()+"/rest/notes", Object[].class);
	        model.addAttribute("name", name);
	        return "index";
	    }

	  private Class<?> getAll(Class<NoteRestController> class1) {
		// TODO Auto-generated method stub
		return class1;
	}

	@GetMapping("/note")
	    public String notesPage(@RequestParam(name="name", required=false, defaultValue="World") String name, Model model) {
	        model.addAttribute("name", name);
	        return "note";
	    }
	  @PostMapping("/note/{id}")
	    public String editnotesPage(@RequestBody Note newNote) {

	        return "/editnote";
	    }
	  @GetMapping("/editnote/{id}")
	    public String editnotesPage1(@PathVariable Long id, Model model) {


		  System.out.println("GET ID");
	        return "/editnote";
	    }

	  @GetMapping("/registration")
	    public String userPage(@RequestParam(name="name", required=false, defaultValue="World") String name, Model model) {
	        model.addAttribute("name", name);
	        return "registration";
	    }
		@RequestMapping(value = "/login", method = RequestMethod.GET)
	    public String login(Model model, String error, String logout) {
	        if (error != null)
	            model.addAttribute("errorMsg", "Your username and password are invalid.");

	        if (logout != null)
	            model.addAttribute("msg", "You have been logged out successfully.");

	        return "login";
	    }

}
