package com.mycompany.sblogin.controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.mycompany.sblogin.entity.Note;
import com.mycompany.sblogin.service.NoteService;
import com.mycompany.sblogin.service.UserService;

@RestController
public class NoteRestController {
	@Autowired
	NoteService noteService;


	@Autowired
	UserService userService;

	@GetMapping("/rest/notes")
	public List<Note> getAll() {
		return noteService.findAll();
	}

	@GetMapping("/rest/notes/{id}")
	public Note getOneNote(@PathVariable Long id) {

		return noteService.findById(id);
	}

	@PostMapping(value = "/rest/notes")
	public Note newNote(@RequestBody Note newNote) {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		System.out.println(auth.getName());
		newNote.setUser(userService.findByName(auth.getName()));
		return noteService.save(newNote);
	}

	@PutMapping(value = "/rest/notes/{id}")
	public Note editNote(@RequestBody Note newNote, @PathVariable Long id) {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		Note tmp = noteService.findById(id);
		tmp.setDescr(newNote.getDescr());
		tmp.setNote(newNote.getNote());
		tmp.setUser(userService.findByName(auth.getName()));
		return noteService.save(tmp);
	}

	@DeleteMapping("/rest/notes/{id}")
	public void deleteNote(@PathVariable Long id) {

		noteService.deleteById(id);
	}

}
