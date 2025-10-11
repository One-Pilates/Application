package com.onePilates.agendamento.repository;

import com.onePilates.agendamento.model.Funcionario;
import com.onePilates.agendamento.model.Professor;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

public interface ProfessorRepository extends JpaRepository<Professor,Long>  {
}
