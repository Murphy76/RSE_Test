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

import com.rse.components.services.NoteService;
import com.rse.components.services.UserService;
import com.rse.domain.Note;
import com.rse.domain.User;

@RestController
public class NoteRestController {
	@Autowired
	NoteService noteService;

	@GetMapping("/rest/notes")
	public List<Note> getAll() {
		return noteService.findAll();
	}

	@GetMapping("/rest/notes/{id}")
	public Note getOneNote(@PathVariable Long id) {
		return noteService.findById(id);
	}

	@RequestMapping(value = "/rest/notes", method = RequestMethod.POST)
	@ResponseBody
	Note newNote(@RequestBody Note newNote) {
		return noteService.save(newNote);
	}

	@RequestMapping(value = "/rest/notes/", method = RequestMethod.PUT)
	@ResponseBody
	Note editNote(@RequestBody Note newNote) {
		return noteService.save(newNote);
	}

	@DeleteMapping("/rest/notes/{id}")
	void deleteNote(@PathVariable Long id) {

		noteService.deleteById(id);
	}

}
