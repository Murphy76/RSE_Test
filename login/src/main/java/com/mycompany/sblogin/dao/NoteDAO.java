package com.mycompany.sblogin.dao;

import java.util.List;

import com.mycompany.sblogin.entity.Note;
import com.mycompany.sblogin.repositories.NoteRepository;

public class NoteDAO implements NoteDaoIF {


	private NoteRepository noteRepository;

	public NoteDAO(NoteRepository repository) {
		this.noteRepository = repository;
	}

	@Override
	public Note save(Note note) {
		return noteRepository.saveAndFlush(note);

	}

	@Override
	public void delete(long noteId) {
		noteRepository.deleteById(noteId);

	}

	@Override
	public List<Note> findAll() {
		return noteRepository.findAll();
	}

	public Note findNoteByName(String descr) {
		return noteRepository.findByDescr(descr);
	}

	public Note findById(long id) {

		return noteRepository.getOne(id);
	}

}
