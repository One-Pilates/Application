package com.onePilates.agendamento.repository;

import com.onePilates.agendamento.dto.AgendamentoPorDiaDTO;
import com.onePilates.agendamento.dto.AulaPorEspecialidadeDTO;
import com.onePilates.agendamento.model.Agendamento;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.List;

@Repository
public interface AgendamentoRepository extends JpaRepository<Agendamento, Long> {

    @Query("SELECT NEW com.onePilates.agendamento.dto.AgendamentoPorDiaDTO(" +
            "FUNCTION('DAYNAME', a.dataHora), COUNT(a)) " +
            "FROM Agendamento a " +
            "WHERE a.professor.id = :professorId " +
            "AND a.dataHora BETWEEN :inicio AND :fim " +
            "GROUP BY FUNCTION('DAYNAME', a.dataHora)")
    List<AgendamentoPorDiaDTO> buscarAgendamentosPorDiaSemana(@Param("professorId") Long professorId,
                                                              @Param("inicio") LocalDateTime inicio,
                                                              @Param("fim") LocalDateTime fim);
    @Query(value = """
    SELECT 
        a.professor_id AS professorId,
        e.nome AS especialidade,
        ROUND(COUNT(*) * 100.0 / total.total_geral, 2) AS percentualAulas
    FROM agendamento a
    JOIN especialidade e ON a.especialidade_id = e.id
    JOIN (
        SELECT professor_id, COUNT(*) AS total_geral
        FROM agendamento
        WHERE data_hora BETWEEN DATE_SUB(CURDATE(), INTERVAL :dias DAY) AND DATE_ADD(CURDATE(), INTERVAL 1 DAY)
        GROUP BY professor_id
    ) total ON total.professor_id = a.professor_id
    WHERE a.data_hora BETWEEN DATE_SUB(CURDATE(), INTERVAL :dias DAY) AND DATE_ADD(CURDATE(), INTERVAL 1 DAY)
      AND a.professor_id = :professorId
    GROUP BY a.professor_id, e.nome, total.total_geral
    """, nativeQuery = true)
    List<AulaPorEspecialidadeDTO> buscarDistribuicaoAulasPorEspecialidade(
            @Param("professorId") Long professorId,
            @Param("dias") Integer dias
    );



}