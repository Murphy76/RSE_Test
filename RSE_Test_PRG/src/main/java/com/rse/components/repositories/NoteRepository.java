package com.rse.components.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.rse.domain.Note;

public interface NoteRepository extends JpaRepository<Note, Long> {

	Note findByDescr(String notename);

}
