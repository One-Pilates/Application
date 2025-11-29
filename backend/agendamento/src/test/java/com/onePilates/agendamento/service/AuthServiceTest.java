package com.onePilates.agendamento.service;

import com.onePilates.agendamento.dto.loginPages.LoginDTO;
import com.onePilates.agendamento.dto.response.LoginResponseDTO;
import com.onePilates.agendamento.dto.response.NovaSenhaResponseDTO;
import com.onePilates.agendamento.exception.*;
import com.onePilates.agendamento.model.*;
import com.onePilates.agendamento.repository.AdministradorRepository;
import com.onePilates.agendamento.repository.FuncionarioRepository;
import com.onePilates.agendamento.repository.ProfessorRepository;
import com.onePilates.agendamento.repository.SecretariaRepository;
import com.onePilates.agendamento.security.JwtUtil;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.security.crypto.password.PasswordEncoder;

import java.time.LocalDateTime;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class AuthServiceTest {

    @Mock
    private AdministradorRepository administradorRepository;

    @Mock
    private ProfessorRepository professorRepository;

    @Mock
    private SecretariaRepository secretariaRepository;

    @Mock
    private PasswordEncoder passwordEncoder;

    @Mock
    private FuncionarioRepository funcionarioRepository;

    @Mock
    private JwtUtil jwtUtil;

    @Mock
    private EmailService emailService;

    @InjectMocks
    private AuthService authService;

    private LoginDTO loginDTO;
    private Professor professor;
    private Administrador administrador;
    private Secretaria secretaria;

    @BeforeEach
    void setUp() {
        loginDTO = new LoginDTO();
        loginDTO.setEmail("professor@teste.com");
        loginDTO.setSenha("senha123");

        professor = new Professor();
        professor.setId(1L);
        professor.setNome("Professor Teste");
        professor.setEmail("professor@teste.com");
        professor.setSenha("encodedPassword");
        professor.setStatus(true);
        professor.setRole(Role.PROFESSOR);
        professor.setPrimeiroAcesso(false);

        administrador = new Administrador();
        administrador.setId(2L);
        administrador.setNome("Admin Teste");
        administrador.setEmail("admin@teste.com");
        administrador.setSenha("encodedPassword");
        administrador.setStatus(true);
        administrador.setRole(Role.ADMINISTRADOR);

        secretaria = new Secretaria();
        secretaria.setId(3L);
        secretaria.setNome("Secretaria Teste");
        secretaria.setEmail("secretaria@teste.com");
        secretaria.setSenha("encodedPassword");
        secretaria.setStatus(true);
        secretaria.setRole(Role.SECRETARIA);
    }

    @Test
    void authenticate_DeveAutenticarProfessorComSucesso() {
        when(administradorRepository.findByEmail("professor@teste.com")).thenReturn(Optional.empty());
        when(professorRepository.findByEmail("professor@teste.com")).thenReturn(Optional.of(professor));
        when(passwordEncoder.matches("senha123", "encodedPassword")).thenReturn(true);
        when(jwtUtil.generateToken(professor)).thenReturn("token123");

        LoginResponseDTO result = authService.authenticate(loginDTO);

        assertNotNull(result);
        assertEquals("token123", result.getToken());
        assertEquals("PROFESSOR", result.getRole());
        assertNotNull(result.getFuncionario());
        verify(jwtUtil).generateToken(professor);
    }

    @Test
    void authenticate_DeveAutenticarAdministradorComSucesso() {
        loginDTO.setEmail("admin@teste.com");
        when(administradorRepository.findByEmail("admin@teste.com")).thenReturn(Optional.of(administrador));
        when(passwordEncoder.matches("senha123", "encodedPassword")).thenReturn(true);
        when(jwtUtil.generateToken(administrador)).thenReturn("token123");

        LoginResponseDTO result = authService.authenticate(loginDTO);

        assertNotNull(result);
        assertEquals("token123", result.getToken());
        assertEquals("ADMINISTRADOR", result.getRole());
        verify(jwtUtil).generateToken(administrador);
    }

    @Test
    void authenticate_DeveAutenticarSecretariaComSucesso() {
        loginDTO.setEmail("secretaria@teste.com");
        when(administradorRepository.findByEmail("secretaria@teste.com")).thenReturn(Optional.empty());
        when(professorRepository.findByEmail("secretaria@teste.com")).thenReturn(Optional.empty());
        when(secretariaRepository.findByEmail("secretaria@teste.com")).thenReturn(Optional.of(secretaria));
        when(passwordEncoder.matches("senha123", "encodedPassword")).thenReturn(true);
        when(jwtUtil.generateToken(secretaria)).thenReturn("token123");

        LoginResponseDTO result = authService.authenticate(loginDTO);

        assertNotNull(result);
        assertEquals("token123", result.getToken());
        assertEquals("SECRETARIA", result.getRole());
        verify(jwtUtil).generateToken(secretaria);
    }

    @Test
    void authenticate_DeveLancarExcecao_QuandoFuncionarioNaoEncontrado() {
        when(administradorRepository.findByEmail("inexistente@teste.com")).thenReturn(Optional.empty());
        when(professorRepository.findByEmail("inexistente@teste.com")).thenReturn(Optional.empty());
        when(secretariaRepository.findByEmail("inexistente@teste.com")).thenReturn(Optional.empty());

        loginDTO.setEmail("inexistente@teste.com");

        assertThrows(EntidadeNaoEncontradaException.class, () -> {
            authService.authenticate(loginDTO);
        });
    }

    @Test
    void authenticate_DeveLancarExcecao_QuandoSenhaInvalida() {
        when(administradorRepository.findByEmail("professor@teste.com")).thenReturn(Optional.empty());
        when(professorRepository.findByEmail("professor@teste.com")).thenReturn(Optional.of(professor));
        when(passwordEncoder.matches("senhaErrada", "encodedPassword")).thenReturn(false);

        loginDTO.setSenha("senhaErrada");

        assertThrows(CredenciaisInvalidasException.class, () -> {
            authService.authenticate(loginDTO);
        });
    }

    @Test
    void authenticate_DeveLancarExcecao_QuandoPerfilInativo() {
        professor.setStatus(false);
        when(administradorRepository.findByEmail("professor@teste.com")).thenReturn(Optional.empty());
        when(professorRepository.findByEmail("professor@teste.com")).thenReturn(Optional.of(professor));
        when(passwordEncoder.matches("senha123", "encodedPassword")).thenReturn(true);

        assertThrows(PerfilInativoException.class, () -> {
            authService.authenticate(loginDTO);
        });
    }

    @Test
    void criarCodigoVerificacao_DeveCriarComSucesso() {
        when(administradorRepository.findByEmail("professor@teste.com")).thenReturn(Optional.empty());
        when(professorRepository.findByEmail("professor@teste.com")).thenReturn(Optional.of(professor));
        when(funcionarioRepository.save(any(Funcionario.class))).thenReturn(professor);
        when(emailService.enviarCodigoPorEmail(anyString(), anyString(), anyString())).thenReturn("Email enviado");

        String result = authService.criarCodigoVerificacao("professor@teste.com");

        assertNotNull(result);
        assertTrue(result.contains("Código enviado"));
        verify(funcionarioRepository).save(any(Funcionario.class));
        verify(emailService).enviarCodigoPorEmail(anyString(), anyString(), anyString());
    }

    @Test
    void criarCodigoVerificacao_DeveLancarExcecao_QuandoErroAoEnviarEmail() {
        when(administradorRepository.findByEmail("professor@teste.com")).thenReturn(Optional.empty());
        when(professorRepository.findByEmail("professor@teste.com")).thenReturn(Optional.of(professor));
        when(funcionarioRepository.save(any(Funcionario.class))).thenReturn(professor);
        doThrow(new RuntimeException("Erro ao enviar email")).when(emailService).enviarCodigoPorEmail(anyString(), anyString(), anyString());

        assertThrows(OperacaoInvalidaException.class, () -> {
            authService.criarCodigoVerificacao("professor@teste.com");
        });
    }

    @Test
    void validarCodigoVerificacao_DeveValidarComSucesso() {
        professor.setCodigoVerificacao("12345");
        professor.setDataUltimaCriacaoCodigo(LocalDateTime.now().minusMinutes(2));

        when(administradorRepository.findByEmail("professor@teste.com")).thenReturn(Optional.empty());
        when(professorRepository.findByEmail("professor@teste.com")).thenReturn(Optional.of(professor));

        Boolean result = authService.validarCodigoVerificacao("professor@teste.com", "12345");

        assertTrue(result);
    }

    @Test
    void validarCodigoVerificacao_DeveLancarExcecao_QuandoCodigoInvalido() {
        professor.setCodigoVerificacao("12345");
        professor.setDataUltimaCriacaoCodigo(LocalDateTime.now());

        when(administradorRepository.findByEmail("professor@teste.com")).thenReturn(Optional.empty());
        when(professorRepository.findByEmail("professor@teste.com")).thenReturn(Optional.of(professor));

        assertThrows(CodigoInvalidoException.class, () -> {
            authService.validarCodigoVerificacao("professor@teste.com", "99999");
        });
    }

    @Test
    void validarCodigoVerificacao_DeveLancarExcecao_QuandoCodigoExpirado() {
        professor.setCodigoVerificacao("12345");
        professor.setDataUltimaCriacaoCodigo(LocalDateTime.now().minusMinutes(10));

        when(administradorRepository.findByEmail("professor@teste.com")).thenReturn(Optional.empty());
        when(professorRepository.findByEmail("professor@teste.com")).thenReturn(Optional.of(professor));

        assertThrows(CodigoExpiradoException.class, () -> {
            authService.validarCodigoVerificacao("professor@teste.com", "12345");
        });
    }

    @Test
    void novaSenha_DeveAlterarSenhaComSucesso() {
        professor.setPrimeiroAcesso(true);
        when(administradorRepository.findByEmail("professor@teste.com")).thenReturn(Optional.empty());
        when(professorRepository.findByEmail("professor@teste.com")).thenReturn(Optional.of(professor));
        when(passwordEncoder.encode("novaSenha")).thenReturn("encodedNewPassword");
        when(funcionarioRepository.save(any(Funcionario.class))).thenReturn(professor);

        NovaSenhaResponseDTO result = authService.novaSenha("novaSenha", "professor@teste.com");

        assertNotNull(result);
        assertEquals("Senha alterada com sucesso", result.getMensagem());
        verify(passwordEncoder).encode("novaSenha");
        verify(funcionarioRepository).save(any(Funcionario.class));
    }

    @Test
    void novaSenha_DeveDesativarPrimeiroAcesso() {
        professor.setPrimeiroAcesso(true);
        when(administradorRepository.findByEmail("professor@teste.com")).thenReturn(Optional.empty());
        when(professorRepository.findByEmail("professor@teste.com")).thenReturn(Optional.of(professor));
        when(passwordEncoder.encode("novaSenha")).thenReturn("encodedNewPassword");
        when(funcionarioRepository.save(any(Funcionario.class))).thenAnswer(invocation -> {
            Funcionario func = invocation.getArgument(0);
            assertFalse(func.getPrimeiroAcesso());
            return func;
        });

        authService.novaSenha("novaSenha", "professor@teste.com");

        verify(funcionarioRepository).save(any(Funcionario.class));
    }

    @Test
    void novaSenha_DeveLancarExcecao_QuandoFuncionarioNaoEncontrado() {
        when(administradorRepository.findByEmail("inexistente@teste.com")).thenReturn(Optional.empty());
        when(professorRepository.findByEmail("inexistente@teste.com")).thenReturn(Optional.empty());
        when(secretariaRepository.findByEmail("inexistente@teste.com")).thenReturn(Optional.empty());

        assertThrows(EntidadeNaoEncontradaException.class, () -> {
            authService.novaSenha("novaSenha", "inexistente@teste.com");
        });
    }
}

