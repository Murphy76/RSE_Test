package com.rse.dao;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.rse.components.repositories.NoteRepository;
import com.rse.domain.Note;

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
