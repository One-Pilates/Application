package com.onePilates.agendamento.repository;


import com.onePilates.agendamento.model.Professor;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ProfessorRepository extends JpaRepository<Professor,Long>  {
}
