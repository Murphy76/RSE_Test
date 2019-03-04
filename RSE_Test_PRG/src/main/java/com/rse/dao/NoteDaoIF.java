package com.rse.dao;

import java.util.List;

import com.rse.domain.Note;

public interface NoteDaoIF {

	public Note save(Note note);
	public void delete(long noteId);
	public Note findNoteByName(String notename);
	public List<Note> findAll();

}
