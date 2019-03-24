package com.mycompany.sblogin.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.mycompany.sblogin.entity.Note;

public interface NoteRepository extends JpaRepository<Note, Long> {

	Note findByDescr(String notename);

}
