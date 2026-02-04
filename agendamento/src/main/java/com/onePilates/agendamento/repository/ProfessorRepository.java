package com.onePilates.agendamento.repository;

import com.onePilates.agendamento.dto.AgendamentoPorDiaDTO;
import com.onePilates.agendamento.dto.response.ProfessorPorEspecialidadeResponseDTO;
import com.onePilates.agendamento.model.Especialidade;
import com.onePilates.agendamento.model.Professor;
import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface ProfessorRepository extends JpaRepository<Professor,Long>  {
    
    @EntityGraph(attributePaths = {"especialidades", "endereco"})
    Optional<Professor> findByEmail(String email);

    @EntityGraph(attributePaths = {"especialidades", "endereco"})
    @Override
    Optional<Professor> findById(Long id);

    @EntityGraph(attributePaths = {"especialidades", "endereco"})
    @Override
    List<Professor> findAll();

    @EntityGraph(attributePaths = {"especialidades", "endereco"})
    List<Professor> findByEspecialidadesId(Long Id);
}
