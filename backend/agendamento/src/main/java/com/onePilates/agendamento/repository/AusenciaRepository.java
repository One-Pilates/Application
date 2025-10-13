package com.onePilates.agendamento.repository;

import com.onePilates.agendamento.model.Ausencia;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface AusenciaRepository extends JpaRepository<Ausencia, Integer> {
    List<Ausencia> findByProfessorId(Long professorId);
}