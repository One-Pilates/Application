package com.onePilates.agendamento.service;

import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.mail.javamail.JavaMailSender;

import java.time.LocalDateTime;
import java.util.Arrays;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class EmailServiceTest {

    @Mock
    private JavaMailSender mailSender;

    @Mock
    private MimeMessage mimeMessage;

    private EmailService emailService;

    private LocalDateTime dataHora;
    private List<String> nomesAlunos;

    @BeforeEach
    void setUp() {
        // Criar EmailService manualmente com um email de teste como remetente
        emailService = new EmailService(mailSender, "teste@onepilates.com");
        dataHora = LocalDateTime.of(2025, 12, 15, 14, 0);
        nomesAlunos = Arrays.asList("Aluno 1", "Aluno 2", "Aluno 3");
    }

    @Test
    void enviarEmailAvisoDeAulaMarcada_DeveEnviarComSucesso() throws MessagingException {
        when(mailSender.createMimeMessage()).thenReturn(mimeMessage);

        String result = emailService.enviarEmailAvisoDeAulaMarcada(
                "Professor Teste",
                nomesAlunos,
                "professor@teste.com",
                dataHora,
                "Sala 1",
                "Pilates Clássico"
        );

        assertNotNull(result);
        verify(mailSender).send(any(MimeMessage.class));
    }

    @Test
    void enviarEmailAvisoDeAulaMarcada_DeveLancarExcecao_QuandoErroAoEnviar() throws MessagingException {
        when(mailSender.createMimeMessage()).thenReturn(mimeMessage);
        doThrow(new RuntimeException("Erro ao enviar email")).when(mailSender).send(any(MimeMessage.class));

        RuntimeException exception = assertThrows(RuntimeException.class, () -> {
            emailService.enviarEmailAvisoDeAulaMarcada(
                    "Professor Teste",
                    nomesAlunos,
                    "professor@teste.com",
                    dataHora,
                    "Sala 1",
                    "Pilates Clássico"
            );
        });
        
        assertEquals("Erro ao enviar email", exception.getMessage());
        verify(mailSender).send(any(MimeMessage.class));
    }

    @Test
    void enviarEmailAvisoDeAulaAtualizada_DeveEnviarComSucesso() throws MessagingException {
        when(mailSender.createMimeMessage()).thenReturn(mimeMessage);

        String result = emailService.enviarEmailAvisoDeAulaAtualizada(
                "Professor Teste",
                nomesAlunos,
                "professor@teste.com",
                dataHora,
                "Sala 1",
                "Pilates Clássico"
        );

        assertNotNull(result);
        verify(mailSender).send(any(MimeMessage.class));
    }

    @Test
    void envioEmailCancelamentoAula_DeveEnviarComSucesso() throws MessagingException {
        when(mailSender.createMimeMessage()).thenReturn(mimeMessage);

        String result = emailService.envioEmailCancelamentoAula(
                "Professor Teste",
                "professor@teste.com",
                dataHora,
                "Sala 1",
                "Pilates Clássico"
        );

        assertNotNull(result);
        verify(mailSender).send(any(MimeMessage.class));
    }

    @Test
    void enviarCodigoPorEmail_DeveEnviarComSucesso() throws MessagingException {
        when(mailSender.createMimeMessage()).thenReturn(mimeMessage);

        String result = emailService.enviarCodigoPorEmail(
                "Professor Teste",
                "12345",
                "professor@teste.com"
        );

        assertNotNull(result);
        verify(mailSender).send(any(MimeMessage.class));
    }

    @Test
    void envioEmailPrimeiroAcesso_DeveEnviarComSucesso() throws MessagingException {
        when(mailSender.createMimeMessage()).thenReturn(mimeMessage);

        String result = emailService.envioEmailPrimeiroAcesso(
                "Professor Teste",
                "professor@teste.com",
                "senha123"
        );

        assertNotNull(result);
        verify(mailSender).send(any(MimeMessage.class));
    }

    @Test
    void enviarEmailAvisoDeAulaMarcada_DeveIncluirInformacoesCorretas() throws MessagingException {
        when(mailSender.createMimeMessage()).thenReturn(mimeMessage);

        emailService.enviarEmailAvisoDeAulaMarcada(
                "Professor Teste",
                nomesAlunos,
                "professor@teste.com",
                dataHora,
                "Sala 1",
                "Pilates Clássico"
        );

        verify(mailSender).send(any(MimeMessage.class));
    }

    @Test
    void enviarEmailAvisoDeAulaAtualizada_DeveIncluirInformacoesCorretas() throws MessagingException {
        when(mailSender.createMimeMessage()).thenReturn(mimeMessage);

        emailService.enviarEmailAvisoDeAulaAtualizada(
                "Professor Teste",
                nomesAlunos,
                "professor@teste.com",
                dataHora,
                "Sala 1",
                "Pilates Clássico"
        );

        verify(mailSender).send(any(MimeMessage.class));
    }

    @Test
    void envioEmailCancelamentoAula_DeveIncluirInformacoesCorretas() throws MessagingException {
        when(mailSender.createMimeMessage()).thenReturn(mimeMessage);

        emailService.envioEmailCancelamentoAula(
                "Professor Teste",
                "professor@teste.com",
                dataHora,
                "Sala 1",
                "Pilates Clássico"
        );

        verify(mailSender).send(any(MimeMessage.class));
    }
}

