package com.onePilates.agendamento.repository;

import com.onePilates.agendamento.model.Ausencia;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface AusenciaRepository extends JpaRepository<Ausencia, Integer> {
    List<Ausencia> findByProfessorId(Long professorId);
}