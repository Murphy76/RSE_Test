package com.mycompany.sblogin.service;

import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mycompany.sblogin.dao.NoteDAO;
import com.mycompany.sblogin.entity.Note;
import com.mycompany.sblogin.repositories.NoteRepository;

@Service
public class NoteService {

	private final Logger log = LoggerFactory.getLogger(NoteService.class);

	NoteRepository noteRepository;
	NoteDAO noteDao;

	@Autowired
	public NoteService(NoteRepository noteRepository) {
		noteDao = new NoteDAO(noteRepository);
	}

	public List<Note> findAll() {

		try {
			return noteDao.findAll();
		} catch (Exception e) {
			log.error(e.getStackTrace().toString());
		}
		return new ArrayList<Note>();

	}

	public Note findById(long id) {

		return noteDao.findById(id);
	}

	public Note save(Note newNote) {

		try {
			return noteDao.save(newNote);
		} catch (Exception e) {
			log.error(e.getStackTrace().toString());
		}
		return new Note();


	}

	public void deleteById(Long id) {
		try {
			noteDao.delete(id);
		} catch (Exception e) {
			log.error(e.getStackTrace().toString());
		}

	}

}
