package com.onePilates.agendamento.service;

import com.onePilates.agendamento.dto.AgendamentoDTO;
import com.onePilates.agendamento.exception.BusinessException;
import com.onePilates.agendamento.model.*;
import com.onePilates.agendamento.observer.AgendamentoNotifier;
import com.onePilates.agendamento.repository.*;
import com.onePilates.agendamento.validator.AgendamentoValidator;
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
class AgendamentoServiceTest {

    @Mock
    private AgendamentoRepository agendamentoRepository;

    @Mock
    private ProfessorRepository professorRepository;

    @Mock
    private SalaRepository salaRepository;

    @Mock
    private EspecialidadeRepository especialidadeRepository;

    @Mock
    private AlunoRepository alunoRepository;

    @Mock
    private AgendamentoNotifier notifier;

    @Mock
    private AgendamentoAlunoRepository agendamentoAlunoRepository;

    @Mock
    private AgendamentoValidator agendamentoValidator;

    @Mock
    private EmailService emailService;

    @InjectMocks
    private AgendamentoService agendamentoService;

    private AgendamentoDTO dto;
    private Agendamento agendamento;
    private Professor professor;
    private Sala sala;
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

        professor = new Professor();
        professor.setId(1L);
        professor.setNome("Professor Teste");
        professor.setEmail("professor@teste.com");
        professor.setNotificacaoAtiva(true);

        sala = new Sala();
        sala.setId(1L);
        sala.setNome("Sala 1");

        especialidade = new Especialidade();
        especialidade.setId(1L);
        especialidade.setNome("Pilates Clássico");

        Aluno aluno1 = new Aluno();
        aluno1.setId(1L);
        aluno1.setNome("Aluno 1");

        Aluno aluno2 = new Aluno();
        aluno2.setId(2L);
        aluno2.setNome("Aluno 2");

        alunos = Arrays.asList(aluno1, aluno2);

        agendamento = new Agendamento();
        agendamento.setId(1L);
        agendamento.setDataHora(dto.getDataHora());
        agendamento.setProfessor(professor);
        agendamento.setSala(sala);
        agendamento.setEspecialidade(especialidade);
        
        // Configurar AgendamentoAluno para o agendamento
        Set<AgendamentoAluno> agendamentoAlunos = new HashSet<>();
        agendamentoAlunos.add(new AgendamentoAluno(agendamento, aluno1));
        agendamentoAlunos.add(new AgendamentoAluno(agendamento, aluno2));
        agendamento.setAgendamentoAlunos(agendamentoAlunos);
    }

    @Test
    void criarAgendamento_DeveCriarComSucesso_QuandoDadosValidos() {
        when(professorRepository.findById(1L)).thenReturn(Optional.of(professor));
        when(salaRepository.findById(1L)).thenReturn(Optional.of(sala));
        when(especialidadeRepository.findById(1L)).thenReturn(Optional.of(especialidade));
        when(alunoRepository.findAllById(any())).thenReturn(alunos);
        when(agendamentoRepository.save(any(Agendamento.class))).thenReturn(agendamento);
        when(agendamentoRepository.findById(1L)).thenReturn(Optional.of(agendamento));

        doNothing().when(agendamentoValidator).validar(any(AgendamentoDTO.class));

        Agendamento resultado = agendamentoService.criarAgendamento(dto);

        assertNotNull(resultado);
        assertEquals(1L, resultado.getId());
        verify(agendamentoRepository, times(1)).save(any(Agendamento.class));
        verify(notifier, times(1)).notificarTodos(any(Agendamento.class));
    }

    @Test
    void criarAgendamento_DeveLancarExcecao_QuandoValidacaoFalha() {
        doThrow(new BusinessException("Erro de validação", "ERRO_VALIDACAO"))
                .when(agendamentoValidator).validar(any(AgendamentoDTO.class));

        assertThrows(BusinessException.class, () -> agendamentoService.criarAgendamento(dto));
        verify(agendamentoRepository, never()).save(any(Agendamento.class));
    }

    @Test
    void excluirAgendamento_DeveExcluirComSucesso_QuandoAgendamentoExiste() {
        when(agendamentoRepository.existsById(1L)).thenReturn(true);
        when(agendamentoRepository.findById(1L)).thenReturn(Optional.of(agendamento));
        doNothing().when(agendamentoRepository).deleteById(1L);
        when(emailService.envioEmailCancelamentoAula(any(), any(), any(LocalDateTime.class), any(), any()))
            .thenReturn("Email enviado");

        assertDoesNotThrow(() -> agendamentoService.excluirAgendamento(1L));
        verify(agendamentoRepository, times(1)).deleteById(1L);
        verify(emailService, times(1)).envioEmailCancelamentoAula(
            eq(professor.getNome()),
            eq(professor.getEmail()),
            eq(agendamento.getDataHora()),
            eq(sala.getNome()),
            eq(especialidade.getNome())
        );
    }

    @Test
    void excluirAgendamento_DeveLancarExcecao_QuandoAgendamentoNaoExiste() {
        when(agendamentoRepository.existsById(1L)).thenReturn(false);

        assertThrows(BusinessException.class, () -> agendamentoService.excluirAgendamento(1L));
        verify(agendamentoRepository, never()).deleteById(any());
    }

    @Test
    void criarAgendamento_DeveValidarConflitosAntesDeSalvar() {
        when(professorRepository.findById(1L)).thenReturn(Optional.of(professor));
        when(salaRepository.findById(1L)).thenReturn(Optional.of(sala));
        when(especialidadeRepository.findById(1L)).thenReturn(Optional.of(especialidade));
        when(alunoRepository.findAllById(any())).thenReturn(alunos);
        when(agendamentoRepository.existsByProfessorIdAndDataHora(any(), any())).thenReturn(false);
        when(agendamentoRepository.existsBySalaIdAndDataHora(any(), any())).thenReturn(false);
        when(agendamentoRepository.findAgendamentosByAlunoAndDataHora(any(), any())).thenReturn(Collections.emptyList());
        when(agendamentoRepository.save(any(Agendamento.class))).thenReturn(agendamento);
        when(agendamentoRepository.findById(1L)).thenReturn(Optional.of(agendamento));

        doNothing().when(agendamentoValidator).validar(any(AgendamentoDTO.class));

        Agendamento resultado = agendamentoService.criarAgendamento(dto);

        assertNotNull(resultado);
        verify(agendamentoRepository).existsByProfessorIdAndDataHora(any(), any());
        verify(agendamentoRepository).existsBySalaIdAndDataHora(any(), any());
    }

    @Test
    void criarAgendamento_DeveLancarExcecao_QuandoConflitoProfessor() {
        when(professorRepository.findById(1L)).thenReturn(Optional.of(professor));
        when(salaRepository.findById(1L)).thenReturn(Optional.of(sala));
        when(especialidadeRepository.findById(1L)).thenReturn(Optional.of(especialidade));
        when(alunoRepository.findAllById(any())).thenReturn(alunos);
        when(agendamentoRepository.existsByProfessorIdAndDataHora(any(), any())).thenReturn(true);

        doNothing().when(agendamentoValidator).validar(any(AgendamentoDTO.class));

        assertThrows(BusinessException.class, () -> agendamentoService.criarAgendamento(dto));
        verify(agendamentoRepository, never()).save(any(Agendamento.class));
    }

    @Test
    void criarAgendamento_DeveLancarExcecao_QuandoConflitoSala() {
        when(professorRepository.findById(1L)).thenReturn(Optional.of(professor));
        when(salaRepository.findById(1L)).thenReturn(Optional.of(sala));
        when(especialidadeRepository.findById(1L)).thenReturn(Optional.of(especialidade));
        when(alunoRepository.findAllById(any())).thenReturn(alunos);
        when(agendamentoRepository.existsByProfessorIdAndDataHora(any(), any())).thenReturn(false);
        when(agendamentoRepository.existsBySalaIdAndDataHora(any(), any())).thenReturn(true);

        doNothing().when(agendamentoValidator).validar(any(AgendamentoDTO.class));

        assertThrows(BusinessException.class, () -> agendamentoService.criarAgendamento(dto));
        verify(agendamentoRepository, never()).save(any(Agendamento.class));
    }

    @Test
    void criarAgendamento_DeveLancarExcecao_QuandoConflitoAluno() {
        when(professorRepository.findById(1L)).thenReturn(Optional.of(professor));
        when(salaRepository.findById(1L)).thenReturn(Optional.of(sala));
        when(especialidadeRepository.findById(1L)).thenReturn(Optional.of(especialidade));
        when(alunoRepository.findAllById(any())).thenReturn(alunos);
        when(agendamentoRepository.existsByProfessorIdAndDataHora(any(), any())).thenReturn(false);
        when(agendamentoRepository.existsBySalaIdAndDataHora(any(), any())).thenReturn(false);
        
        Agendamento conflito = new Agendamento();
        when(agendamentoRepository.findAgendamentosByAlunoAndDataHora(any(), any()))
                .thenReturn(Collections.singletonList(conflito));

        doNothing().when(agendamentoValidator).validar(any(AgendamentoDTO.class));

        assertThrows(BusinessException.class, () -> agendamentoService.criarAgendamento(dto));
        verify(agendamentoRepository, never()).save(any(Agendamento.class));
    }

    @Test
    void criarAgendamento_DeveNotificarProfessor_QuandoNotificacaoAtiva() {
        when(professorRepository.findById(1L)).thenReturn(Optional.of(professor));
        when(salaRepository.findById(1L)).thenReturn(Optional.of(sala));
        when(especialidadeRepository.findById(1L)).thenReturn(Optional.of(especialidade));
        when(alunoRepository.findAllById(any())).thenReturn(alunos);
        when(agendamentoRepository.existsByProfessorIdAndDataHora(any(), any())).thenReturn(false);
        when(agendamentoRepository.existsBySalaIdAndDataHora(any(), any())).thenReturn(false);
        when(agendamentoRepository.findAgendamentosByAlunoAndDataHora(any(), any())).thenReturn(Collections.emptyList());
        when(agendamentoRepository.save(any(Agendamento.class))).thenReturn(agendamento);
        when(agendamentoRepository.findById(1L)).thenReturn(Optional.of(agendamento));

        doNothing().when(agendamentoValidator).validar(any(AgendamentoDTO.class));

        agendamentoService.criarAgendamento(dto);

        verify(notifier).notificarTodos(any(Agendamento.class));
    }

    @Test
    void criarAgendamento_DeveNaoNotificarProfessor_QuandoNotificacaoInativa() {
        professor.setNotificacaoAtiva(false);
        when(professorRepository.findById(1L)).thenReturn(Optional.of(professor));
        when(salaRepository.findById(1L)).thenReturn(Optional.of(sala));
        when(especialidadeRepository.findById(1L)).thenReturn(Optional.of(especialidade));
        when(alunoRepository.findAllById(any())).thenReturn(alunos);
        when(agendamentoRepository.existsByProfessorIdAndDataHora(any(), any())).thenReturn(false);
        when(agendamentoRepository.existsBySalaIdAndDataHora(any(), any())).thenReturn(false);
        when(agendamentoRepository.findAgendamentosByAlunoAndDataHora(any(), any())).thenReturn(Collections.emptyList());
        when(agendamentoRepository.save(any(Agendamento.class))).thenReturn(agendamento);
        when(agendamentoRepository.findById(1L)).thenReturn(Optional.of(agendamento));

        doNothing().when(agendamentoValidator).validar(any(AgendamentoDTO.class));

        agendamentoService.criarAgendamento(dto);

        verify(notifier, never()).notificarTodos(any(Agendamento.class));
    }
}

