package com.onePilates.agendamento.observer;

import com.onePilates.agendamento.model.Agendamento;
import com.onePilates.agendamento.model.AgendamentoAluno;
import com.onePilates.agendamento.model.Aluno;
import com.onePilates.agendamento.model.Especialidade;
import com.onePilates.agendamento.model.Professor;
import com.onePilates.agendamento.model.Sala;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.time.LocalDateTime;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.*;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class NotificacaoProfessorObserverTest {

    @Mock
    private EmailService emailService;

    @InjectMocks
    private NotificacaoProfessorObserver observer;

    private Agendamento agendamento;
    private Professor professor;
    private Sala sala;
    private Especialidade especialidade;
    private Set<AgendamentoAluno> agendamentoAlunos;

    @BeforeEach
    void setUp() {
        professor = new Professor();
        professor.setId(1L);
        professor.setNome("Professor Teste");
        professor.setEmail("professor@teste.com");

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

        AgendamentoAluno agendamentoAluno1 = new AgendamentoAluno();
        agendamentoAluno1.setAluno(aluno1);

        AgendamentoAluno agendamentoAluno2 = new AgendamentoAluno();
        agendamentoAluno2.setAluno(aluno2);

        agendamentoAlunos = new HashSet<>();
        agendamentoAlunos.add(agendamentoAluno1);
        agendamentoAlunos.add(agendamentoAluno2);

        agendamento = new Agendamento();
        agendamento.setId(1L);
        agendamento.setProfessor(professor);
        agendamento.setSala(sala);
        agendamento.setEspecialidade(especialidade);
        agendamento.setDataHora(LocalDateTime.now().plusDays(1));
        agendamento.setAgendamentoAlunos(agendamentoAlunos);
    }

    @Test
    void notificar_DeveChamarEmailService_QuandoAgendamentoValido() {
        observer.notificar(agendamento);

        verify(emailService, times(1)).enviarEmailAvisoDeAulaMarcada(
                eq("Professor Teste"),
                argThat(list -> list != null && 
                        list.size() == 2 && 
                        list.contains("Aluno 1") && 
                        list.contains("Aluno 2")),
                eq("professor@teste.com"),
                any(LocalDateTime.class),
                eq("Sala 1"),
                eq("Pilates Clássico")
        );
    }

    @Test
    void notificar_DeveFuncionar_QuandoListaAlunosVazia() {
        agendamento.setAgendamentoAlunos(new HashSet<>());

        observer.notificar(agendamento);

        verify(emailService, times(1)).enviarEmailAvisoDeAulaMarcada(
                eq("Professor Teste"),
                eq(List.of()),
                eq("professor@teste.com"),
                any(LocalDateTime.class),
                eq("Sala 1"),
                eq("Pilates Clássico")
        );
    }

    @Test
    void notificar_DeveFuncionar_QuandoUmAluno() {
        Aluno aluno = new Aluno();
        aluno.setId(1L);
        aluno.setNome("Aluno 1");

        AgendamentoAluno agendamentoAluno = new AgendamentoAluno();
        agendamentoAluno.setAluno(aluno);

        Set<AgendamentoAluno> alunosUnicos = new HashSet<>();
        alunosUnicos.add(agendamentoAluno);
        agendamento.setAgendamentoAlunos(alunosUnicos);

        observer.notificar(agendamento);

        verify(emailService, times(1)).enviarEmailAvisoDeAulaMarcada(
                eq("Professor Teste"),
                argThat(list -> list != null && list.size() == 1 && list.contains("Aluno 1")),
                eq("professor@teste.com"),
                any(LocalDateTime.class),
                eq("Sala 1"),
                eq("Pilates Clássico")
        );
    }

    @Test
    void notificar_DeveFuncionar_QuandoEmailServiceLancaExcecao() {
        doThrow(new RuntimeException("Erro ao enviar email"))
                .when(emailService).enviarEmailAvisoDeAulaMarcada(any(), any(), any(), any(), any(), any());

        RuntimeException exception = assertThrows(RuntimeException.class, () -> {
            observer.notificar(agendamento);
        });

        assertEquals("Erro ao enviar email", exception.getMessage());
        verify(emailService, times(1)).enviarEmailAvisoDeAulaMarcada(any(), any(), any(), any(), any(), any());
    }
}

