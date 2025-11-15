package com.onePilates.agendamento.validator;

import com.onePilates.agendamento.dto.AgendamentoDTO;
import com.onePilates.agendamento.exception.*;
import com.onePilates.agendamento.model.*;
import com.onePilates.agendamento.repository.*;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.time.LocalDateTime;
import java.util.*;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class AgendamentoValidatorTest {

    @Mock
    private SalaRepository salaRepository;

    @Mock
    private ProfessorRepository professorRepository;

    @Mock
    private EspecialidadeRepository especialidadeRepository;

    @Mock
    private AlunoRepository alunoRepository;

    @Mock
    private AusenciaRepository ausenciaRepository;

    @Mock
    private AgendamentoRepository agendamentoRepository;

    @InjectMocks
    private AgendamentoValidator validator;

    private AgendamentoDTO dto;
    private Sala sala;
    private Professor professor;
    private Especialidade especialidade;
    private List<Aluno> alunos;

    @BeforeEach
    void setUp() {
        dto = new AgendamentoDTO();
        dto.setDataHora(LocalDateTime.now().plusDays(1));
        dto.setSalaId(1L);
        dto.setProfessorId(1L);
        dto.setEspecialidadeId(1L);
        dto.setAlunoIds(Set.of(1L, 2L));

        sala = new Sala();
        sala.setId(1L);
        sala.setNome("Sala 1");
        sala.setQuantidadeMaximaAlunos(5);
        sala.setQuantidadeEquipamentosPCD(2);
        sala.setEspecialidades(Set.of(new Especialidade()));

        professor = new Professor();
        professor.setId(1L);
        professor.setNome("Professor Teste");
        professor.setStatus(true);
        professor.setEspecialidades(Set.of(new Especialidade()));

        especialidade = new Especialidade();
        especialidade.setId(1L);
        especialidade.setNome("Pilates Clássico");

        Aluno aluno1 = new Aluno();
        aluno1.setId(1L);
        aluno1.setNome("Aluno 1");
        aluno1.setStatus(true);
        aluno1.setAlunoComLimitacoesFisicas(false);

        Aluno aluno2 = new Aluno();
        aluno2.setId(2L);
        aluno2.setNome("Aluno 2");
        aluno2.setStatus(true);
        aluno2.setAlunoComLimitacoesFisicas(false);

        alunos = new ArrayList<>(Arrays.asList(aluno1, aluno2));
    }

    @Test
    void validar_DevePassar_QuandoTodosOsDadosSaoValidos() {
        when(salaRepository.findById(1L)).thenReturn(Optional.of(sala));
        when(professorRepository.findById(1L)).thenReturn(Optional.of(professor));
        when(especialidadeRepository.findById(1L)).thenReturn(Optional.of(especialidade));
        when(alunoRepository.findAllById(any())).thenReturn(alunos);
        when(agendamentoRepository.existsBySalaIdAndDataHora(any(), any())).thenReturn(false);
        when(agendamentoRepository.existsByProfessorIdAndDataHora(any(), any())).thenReturn(false);
        when(agendamentoRepository.findAgendamentosByAlunoAndDataHora(any(), any())).thenReturn(Collections.emptyList());
        when(ausenciaRepository.findByProfessorId(any())).thenReturn(Collections.emptyList());

        // Configurar especialidades para validação
        Especialidade esp = new Especialidade();
        esp.setId(1L);
        esp.setNome("Pilates Clássico");
        sala.setEspecialidades(Set.of(esp));
        professor.setEspecialidades(Set.of(esp));

        assertDoesNotThrow(() -> validator.validar(dto));
    }

    @Test
    void validar_DeveLancarSalaLotadaException_QuandoQuantidadeAlunosExcedeCapacidade() {
        sala.setQuantidadeMaximaAlunos(1);
        dto.setAlunoIds(Set.of(1L, 2L, 3L));
        
        // Adicionar terceiro aluno à lista
        Aluno aluno3 = new Aluno();
        aluno3.setId(3L);
        aluno3.setNome("Aluno 3");
        aluno3.setStatus(true);
        aluno3.setAlunoComLimitacoesFisicas(false);
        alunos.add(aluno3);

        // Configurar especialidades para validação
        Especialidade esp = new Especialidade();
        esp.setId(1L);
        esp.setNome("Pilates Clássico");
        sala.setEspecialidades(Set.of(esp));
        professor.setEspecialidades(Set.of(esp));

        when(salaRepository.findById(1L)).thenReturn(Optional.of(sala));
        when(professorRepository.findById(1L)).thenReturn(Optional.of(professor));
        when(especialidadeRepository.findById(1L)).thenReturn(Optional.of(especialidade));
        when(alunoRepository.findAllById(any())).thenReturn(alunos);
        when(agendamentoRepository.existsBySalaIdAndDataHora(any(), any())).thenReturn(false);
        when(agendamentoRepository.existsByProfessorIdAndDataHora(any(), any())).thenReturn(false);
        when(agendamentoRepository.findAgendamentosByAlunoAndDataHora(any(), any())).thenReturn(Collections.emptyList());
        // Nota: ausenciaRepository não é mockado aqui porque a exceção é lançada antes de chegar à validação de ausência

        assertThrows(SalaLotadaException.class, () -> validator.validar(dto));
    }

    @Test
    void validar_DeveLancarEquipamentoPCDInsuficienteException_QuandoAlunosComLimitacoesExcedemEquipamentos() {
        Aluno alunoComLimitacao = new Aluno();
        alunoComLimitacao.setId(3L);
        alunoComLimitacao.setNome("Aluno com Limitação");
        alunoComLimitacao.setStatus(true);
        alunoComLimitacao.setAlunoComLimitacoesFisicas(true);
        alunos.add(alunoComLimitacao);
        dto.setAlunoIds(Set.of(1L, 2L, 3L));
        sala.setQuantidadeEquipamentosPCD(0);

        // Configurar especialidades para validação
        Especialidade esp = new Especialidade();
        esp.setId(1L);
        esp.setNome("Pilates Clássico");
        sala.setEspecialidades(Set.of(esp));
        professor.setEspecialidades(Set.of(esp));

        when(salaRepository.findById(1L)).thenReturn(Optional.of(sala));
        when(professorRepository.findById(1L)).thenReturn(Optional.of(professor));
        when(especialidadeRepository.findById(1L)).thenReturn(Optional.of(especialidade));
        when(alunoRepository.findAllById(any())).thenReturn(alunos);
        when(agendamentoRepository.existsBySalaIdAndDataHora(any(), any())).thenReturn(false);
        when(agendamentoRepository.existsByProfessorIdAndDataHora(any(), any())).thenReturn(false);
        when(agendamentoRepository.findAgendamentosByAlunoAndDataHora(any(), any())).thenReturn(Collections.emptyList());
        // Nota: ausenciaRepository não é mockado aqui porque a exceção é lançada antes de chegar à validação de ausência

        assertThrows(EquipamentoPCDInsuficienteException.class, () -> validator.validar(dto));
    }

    @Test
    void validar_DeveLancarEntidadeNaoEncontradaException_QuandoSalaNaoExiste() {
        when(salaRepository.findById(1L)).thenReturn(Optional.empty());

        assertThrows(EntidadeNaoEncontradaException.class, () -> validator.validar(dto));
    }

    @Test
    void validar_DeveLancarConflitoHorarioException_QuandoSalaJaEstaOcupada() {
        when(salaRepository.findById(1L)).thenReturn(Optional.of(sala));
        when(professorRepository.findById(1L)).thenReturn(Optional.of(professor));
        when(especialidadeRepository.findById(1L)).thenReturn(Optional.of(especialidade));
        when(alunoRepository.findAllById(any())).thenReturn(alunos);
        when(agendamentoRepository.existsBySalaIdAndDataHora(any(), any())).thenReturn(true);

        assertThrows(ConflitoHorarioException.class, () -> validator.validar(dto));
    }
}

