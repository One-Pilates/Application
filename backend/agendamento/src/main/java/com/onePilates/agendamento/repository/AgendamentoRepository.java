package com.onePilates.agendamento.repository;

import com.onePilates.agendamento.dto.AgendamentoPorDiaDTO;
import com.onePilates.agendamento.dto.AulaPorEspecialidadeDTO;
import com.onePilates.agendamento.model.Agendamento;
import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.List;

@Repository
public interface AgendamentoRepository extends JpaRepository<Agendamento, Long> {

    // Query 1: Agendamentos agrupados por dia da semana
    @Query(value = """
        SELECT 
            DAYNAME(a.data_hora) AS diaSemana,
            CAST(COUNT(*) AS UNSIGNED) AS totalAgendamentos
        FROM agendamento a
        WHERE a.professor_id = :professorId
          AND a.data_hora >= :inicio
          AND a.data_hora < :fim
        GROUP BY DAYNAME(a.data_hora), DAYOFWEEK(a.data_hora)
        ORDER BY DAYOFWEEK(a.data_hora)
        """, nativeQuery = true)
    List<Object[]> buscarAgendamentosPorDiaSemanaRaw(@Param("professorId") Long professorId,
                                                      @Param("inicio") LocalDateTime inicio,
                                                      @Param("fim") LocalDateTime fim);



    @Query(value = """
    SELECT 
        DAYNAME(a.data_hora) AS diaSemana,
        CAST(COUNT(*) AS UNSIGNED) AS totalAgendamentos
    FROM agendamento a
    WHERE a.data_hora >= :inicio
      AND a.data_hora < :fim
    GROUP BY DAYNAME(a.data_hora), DAYOFWEEK(a.data_hora)
    ORDER BY DAYOFWEEK(a.data_hora)
    """, nativeQuery = true)
    List<Object[]> buscarAgendamentosPorDiaSemana(@Param("inicio") LocalDateTime inicio,
                                                                 @Param("fim") LocalDateTime fim);


    @Query("""
    SELECT a
    FROM Agendamento a
    WHERE a.dataHora >= :inicio
      AND a.dataHora < :fim
""")
    List<Agendamento> buscarAgendamentosPorIntervalo(@Param("inicio") LocalDateTime inicio,
                                                     @Param("fim") LocalDateTime fim);


    // Query 2: Distribuição de aulas por especialidade (percentual)
    // Otimizada: calcula total uma vez e usa como parâmetro
    @Query(value = """
        SELECT 
            e.nome AS especialidade,
            CAST(ROUND((COUNT(*) * 100.0 / NULLIF(:totalGeral, 0)), 2) AS DECIMAL(10,2)) AS percentualAulas
        FROM agendamento a
        INNER JOIN especialidade e ON a.especialidade_id = e.id
        WHERE a.professor_id = :professorId
          AND a.data_hora >= :inicio
          AND a.data_hora < :fim
        GROUP BY e.nome
        ORDER BY percentualAulas DESC
        """, nativeQuery = true)
    List<Object[]> buscarDistribuicaoAulasPorEspecialidadeRaw(
            @Param("professorId") Long professorId,
            @Param("inicio") LocalDateTime inicio,
            @Param("fim") LocalDateTime fim,
            @Param("totalGeral") Long totalGeral
    );
    
    // Query para contar total de agendamentos no período (usado na Query 2)
    @Query(value = """
        SELECT CAST(COUNT(*) AS UNSIGNED)
        FROM agendamento
        WHERE professor_id = :professorId
          AND data_hora >= :inicio
          AND data_hora < :fim
        """, nativeQuery = true)
    Long countByProfessorIdAndPeriod(
            @Param("professorId") Long professorId,
            @Param("inicio") LocalDateTime inicio,
            @Param("fim") LocalDateTime fim
    );

    @EntityGraph(attributePaths = {"agendamentoAlunos", "agendamentoAlunos.aluno", "professor", "sala", "especialidade"})
    List<Agendamento> findByProfessorId(Long professorId);


    @EntityGraph(attributePaths = {
            "agendamentoAlunos",
            "agendamentoAlunos.aluno",
            "professor",
            "sala",
            "especialidade"
    })
    List<Agendamento> findBySalaId(Long salaId);






    // Query 3: Buscar agendamentos por professor e período
    @Query("SELECT a FROM Agendamento a " +
            "WHERE a.professor.id = :professorId " +
            "AND a.dataHora >= :inicio " +
            "AND a.dataHora < :fim")
    List<Agendamento> findAgendamentosByProfessorAndPeriod(
            @Param("professorId") Long professorId,
            @Param("inicio") LocalDateTime inicio,
            @Param("fim") LocalDateTime fim
    );

    @EntityGraph(attributePaths = {"agendamentoAlunos", "agendamentoAlunos.aluno", "professor", "sala", "especialidade"})
    @Override
    java.util.Optional<Agendamento> findById(Long id);
    
    @EntityGraph(attributePaths = {"agendamentoAlunos", "agendamentoAlunos.aluno", "professor", "sala", "especialidade"})
    @Override
    List<Agendamento> findAll();

//    Validação de agendamento
    boolean existsByProfessorIdAndDataHora(Long professorId, LocalDateTime dataHora);

    boolean existsBySalaIdAndDataHora(Long salaId, LocalDateTime dataHora);

    @Query("SELECT DISTINCT a FROM Agendamento a JOIN FETCH a.agendamentoAlunos aa JOIN FETCH aa.aluno WHERE aa.aluno = :aluno AND a.dataHora = :dataHora")
    List<Agendamento> findAgendamentosByAlunoAndDataHora(@Param("aluno") com.onePilates.agendamento.model.Aluno aluno,
                                                         @Param("dataHora") LocalDateTime dataHora);

}