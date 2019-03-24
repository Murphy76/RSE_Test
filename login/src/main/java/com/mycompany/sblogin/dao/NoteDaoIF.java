package com.mycompany.sblogin.dao;

import java.util.List;

import com.mycompany.sblogin.entity.Note;

public interface NoteDaoIF {

	public Note save(Note note);
	public void delete(long noteId);
	public Note findNoteByName(String notename);
	public List<Note> findAll();

}
