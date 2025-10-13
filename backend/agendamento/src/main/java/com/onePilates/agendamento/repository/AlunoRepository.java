package com.onePilates.agendamento.repository;

import com.onePilates.agendamento.model.Aluno;
import org.springframework.data.jpa.repository.JpaRepository;

public interface AlunoRepository extends JpaRepository<Aluno, Long> {
}
