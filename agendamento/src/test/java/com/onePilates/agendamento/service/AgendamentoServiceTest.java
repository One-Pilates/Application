package com.onePilates.agendamento.service;

import com.onePilates.agendamento.dto.AgendamentoDTO;
import com.onePilates.agendamento.dto.response.AgendamentoResponseDTO;
import com.onePilates.agendamento.exception.BusinessException;
import com.onePilates.agendamento.exception.EntidadeNaoEncontradaException;
import com.onePilates.agendamento.exception.OperacaoInvalidaException;
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

    @Test
    void listarTodosDTO_DeveRetornarListaDeAgendamentos() {
        List<Agendamento> agendamentos = Arrays.asList(agendamento);
        when(agendamentoRepository.findAll()).thenReturn(agendamentos);

        List<AgendamentoResponseDTO> resultado = agendamentoService.listarTodosDTO();

        assertNotNull(resultado);
        assertEquals(1, resultado.size());
        verify(agendamentoRepository).findAll();
    }

    @Test
    void buscarPorIdDTO_DeveRetornarAgendamentoQuandoEncontrado() {
        when(agendamentoRepository.findById(1L)).thenReturn(Optional.of(agendamento));

        AgendamentoResponseDTO resultado = agendamentoService.buscarPorIdDTO(1L);

        assertNotNull(resultado);
        assertEquals(1L, resultado.getId());
        verify(agendamentoRepository).findById(1L);
    }

    @Test
    void buscarPorIdDTO_DeveLancarExcecaoQuandoNaoEncontrado() {
        when(agendamentoRepository.findById(1L)).thenReturn(Optional.empty());

        assertThrows(EntidadeNaoEncontradaException.class, () -> agendamentoService.buscarPorIdDTO(1L));
    }

    @Test
    void buscarAgendamentosPorIdProfessor_DeveRetornarListaQuandoExistem() {
        List<Agendamento> agendamentos = Arrays.asList(agendamento);
        when(agendamentoRepository.findByProfessorId(1L)).thenReturn(agendamentos);

        List<AgendamentoResponseDTO> resultado = agendamentoService.buscarAgendamentosPorIdProfessor(1L);

        assertNotNull(resultado);
        assertEquals(1, resultado.size());
        verify(agendamentoRepository).findByProfessorId(1L);
    }

    @Test
    void buscarAgendamentosPorIdSala_DeveRetornarListaQuandoExistem() {
        List<Agendamento> agendamentos = Arrays.asList(agendamento);
        when(salaRepository.findById(1L)).thenReturn(Optional.of(sala));
        when(agendamentoRepository.findBySalaId(1L)).thenReturn(agendamentos);

        List<AgendamentoResponseDTO> resultado = agendamentoService.buscarAgendamentosPorIdSala(1L);

        assertNotNull(resultado);
        assertEquals(1, resultado.size());
        verify(agendamentoRepository).findBySalaId(1L);
    }

    @Test
    void buscarAgendamentosPorIdSala_DeveLancarExcecaoQuandoSalaNaoExiste() {
        when(salaRepository.findById(1L)).thenReturn(Optional.empty());

        assertThrows(RuntimeException.class, () -> agendamentoService.buscarAgendamentosPorIdSala(1L));
    }

    @Test
    void buscarAgendamentosPorIdSala_DeveLancarExcecaoQuandoNaoHaAgendamentos() {
        when(salaRepository.findById(1L)).thenReturn(Optional.of(sala));
        when(agendamentoRepository.findBySalaId(1L)).thenReturn(Collections.emptyList());

        assertThrows(RuntimeException.class, () -> agendamentoService.buscarAgendamentosPorIdSala(1L));
    }

    @Test
    void buscarAgendamentosPorIdsDeSalaEProfessor_DeveRetornarListaFiltrada() {
        when(salaRepository.findById(1L)).thenReturn(Optional.of(sala));
        when(professorRepository.findById(1L)).thenReturn(Optional.of(professor));
        when(agendamentoRepository.findByProfessorId(1L)).thenReturn(Arrays.asList(agendamento));

        List<AgendamentoResponseDTO> resultado = agendamentoService.buscarAgendamentosPorIdsDeSalaEProfessor(1L, 1L);

        assertNotNull(resultado);
        verify(agendamentoRepository).findByProfessorId(1L);
    }

    @Test
    void buscarAgendamentosPorIdsDeSalaEProfessor_DeveLancarExcecaoQuandoIdsInvalidos() {
        assertThrows(IllegalArgumentException.class, () -> 
            agendamentoService.buscarAgendamentosPorIdsDeSalaEProfessor(null, 1L));
    }

    @Test
    void buscarAgendamentosPorIdsDeSalaEProfessor_DeveLancarExcecaoQuandoSalaNaoExiste() {
        when(salaRepository.findById(1L)).thenReturn(Optional.empty());

        assertThrows(RuntimeException.class, () -> 
            agendamentoService.buscarAgendamentosPorIdsDeSalaEProfessor(1L, 1L));
    }

    @Test
    void atualizarAgendamento_DeveAtualizarComSucesso_QuandoDadosValidos() {
        AgendamentoDTO dtoAtualizacao = new AgendamentoDTO();
        dtoAtualizacao.setDataHora(LocalDateTime.now().plusDays(2));
        dtoAtualizacao.setSalaId(1L);
        dtoAtualizacao.setProfessorId(1L);
        dtoAtualizacao.setEspecialidadeId(1L);
        dtoAtualizacao.setAlunoIds(Set.of(1L, 2L));

        when(agendamentoRepository.findById(1L)).thenReturn(Optional.of(agendamento));
        when(professorRepository.findById(1L)).thenReturn(Optional.of(professor));
        when(salaRepository.findById(1L)).thenReturn(Optional.of(sala));
        when(especialidadeRepository.findById(1L)).thenReturn(Optional.of(especialidade));
        when(alunoRepository.findAllById(any())).thenReturn(alunos);
        doNothing().when(agendamentoValidator).validar(any(AgendamentoDTO.class), eq(1L));
        when(agendamentoRepository.save(any(Agendamento.class))).thenReturn(agendamento);
        when(agendamentoRepository.findById(1L)).thenReturn(Optional.of(agendamento));

        AgendamentoResponseDTO resultado = agendamentoService.atualizarAgendamento(1L, dtoAtualizacao);

        assertNotNull(resultado);
        verify(agendamentoRepository).save(any(Agendamento.class));
    }

    @Test
    void atualizarAgendamento_DeveNotificarProfessor_QuandoNotificacaoAtiva() {
        AgendamentoDTO dtoAtualizacao = new AgendamentoDTO();
        dtoAtualizacao.setDataHora(LocalDateTime.now().plusDays(2));

        when(agendamentoRepository.findById(1L)).thenReturn(Optional.of(agendamento));
        doNothing().when(agendamentoValidator).validar(any(AgendamentoDTO.class), eq(1L));
        when(agendamentoRepository.save(any(Agendamento.class))).thenReturn(agendamento);
        when(agendamentoRepository.findById(1L)).thenReturn(Optional.of(agendamento));
        when(emailService.enviarEmailAvisoDeAulaAtualizada(any(), any(), any(), any(), any(), any()))
            .thenReturn("Email enviado");

        agendamentoService.atualizarAgendamento(1L, dtoAtualizacao);

        verify(emailService).enviarEmailAvisoDeAulaAtualizada(any(), any(), any(), any(), any(), any());
    }

    @Test
    void atualizarAgendamento_DeveNotificarAmbosProfessores_QuandoProfessorFoiTrocado() {
        Professor professorNovo = new Professor();
        professorNovo.setId(2L);
        professorNovo.setNome("Professor Novo");
        professorNovo.setEmail("professor.novo@teste.com");
        professorNovo.setNotificacaoAtiva(true);

        AgendamentoDTO dtoAtualizacao = new AgendamentoDTO();
        dtoAtualizacao.setProfessorId(2L);

        when(agendamentoRepository.findById(1L)).thenReturn(Optional.of(agendamento));
        when(professorRepository.findById(2L)).thenReturn(Optional.of(professorNovo));
        doNothing().when(agendamentoValidator).validar(any(AgendamentoDTO.class), eq(1L));
        when(agendamentoRepository.save(any(Agendamento.class))).thenReturn(agendamento);
        when(agendamentoRepository.findById(1L)).thenReturn(Optional.of(agendamento));
        when(emailService.envioEmailCancelamentoAula(any(), any(), any(), any(), any()))
            .thenReturn("Email enviado");
        when(emailService.enviarEmailAvisoDeAulaMarcada(any(), any(), any(), any(), any(), any()))
            .thenReturn("Email enviado");

        agendamentoService.atualizarAgendamento(1L, dtoAtualizacao);

        verify(emailService).envioEmailCancelamentoAula(any(), any(), any(), any(), any());
        verify(emailService).enviarEmailAvisoDeAulaMarcada(any(), any(), any(), any(), any(), any());
    }

    @Test
    void registrarPresencas_DeveRegistrarComSucesso_QuandoAulaJaAconteceu() {
        agendamento.setDataHora(LocalDateTime.now().minusDays(1));
        Map<Long, StatusPresenca> presencas = new HashMap<>();
        presencas.put(1L, StatusPresenca.PRESENTE);
        presencas.put(2L, StatusPresenca.FALTA);

        AgendamentoAluno agendamentoAluno1 = agendamento.getAgendamentoAlunos().iterator().next();
        when(agendamentoRepository.findById(1L)).thenReturn(Optional.of(agendamento));
        when(agendamentoAlunoRepository.save(any(AgendamentoAluno.class))).thenReturn(agendamentoAluno1);

        assertDoesNotThrow(() -> agendamentoService.registrarPresencas(1L, presencas));

        verify(agendamentoAlunoRepository, atLeastOnce()).save(any(AgendamentoAluno.class));
    }

    @Test
    void registrarPresencas_DeveLancarExcecao_QuandoAulaAindaNaoAconteceu() {
        agendamento.setDataHora(LocalDateTime.now().plusDays(1));
        Map<Long, StatusPresenca> presencas = new HashMap<>();
        presencas.put(1L, StatusPresenca.PRESENTE);

        when(agendamentoRepository.findById(1L)).thenReturn(Optional.of(agendamento));

        assertThrows(OperacaoInvalidaException.class, () -> 
            agendamentoService.registrarPresencas(1L, presencas));
    }

    @Test
    void registrarPresencas_DeveLancarExcecao_QuandoAlunoNaoPertenceAoAgendamento() {
        agendamento.setDataHora(LocalDateTime.now().minusDays(1));
        Map<Long, StatusPresenca> presencas = new HashMap<>();
        presencas.put(999L, StatusPresenca.PRESENTE);

        when(agendamentoRepository.findById(1L)).thenReturn(Optional.of(agendamento));

        assertThrows(OperacaoInvalidaException.class, () -> 
            agendamentoService.registrarPresencas(1L, presencas));
    }

    @Test
    void criarAgendamento_DeveNormalizarDataHora() {
        LocalDateTime dataComMinutos = LocalDateTime.now().plusDays(1).withMinute(30).withSecond(45);
        dto.setDataHora(dataComMinutos);

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

        // Verifica que a data foi normalizada (minutos, segundos e nanossegundos zerados)
        assertEquals(0, dto.getDataHora().getMinute());
        assertEquals(0, dto.getDataHora().getSecond());
        assertEquals(0, dto.getDataHora().getNano());
    }

    @Test
    void excluirAgendamento_DeveNaoNotificar_QuandoNotificacaoInativa() {
        professor.setNotificacaoAtiva(false);
        when(agendamentoRepository.existsById(1L)).thenReturn(true);
        when(agendamentoRepository.findById(1L)).thenReturn(Optional.of(agendamento));
        doNothing().when(agendamentoRepository).deleteById(1L);

        agendamentoService.excluirAgendamento(1L);

        verify(emailService, never()).envioEmailCancelamentoAula(any(), any(), any(), any(), any());
        verify(agendamentoRepository).deleteById(1L);
    }
}

