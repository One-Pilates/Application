package com.onePilates.agendamento.repository;

import com.onePilates.agendamento.model.Professor;
import com.onePilates.agendamento.model.Sala;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface SalaRepository extends JpaRepository<Sala, Long> {

    List<Sala> findByEspecialidadesId(Long Id);
}
