package com.onePilates.agendamento.service;

import com.onePilates.agendamento.dto.EnderecoDTO;
import com.onePilates.agendamento.dto.SecretariaDTO;
import com.onePilates.agendamento.dto.response.ResponsDashSecretariaAdmDTO;
import com.onePilates.agendamento.dto.response.SecretariaResponseDTO;
import com.onePilates.agendamento.exception.*;
import com.onePilates.agendamento.model.*;
import com.onePilates.agendamento.repository.AgendamentoRepository;
import com.onePilates.agendamento.repository.EnderecoRepository;
import com.onePilates.agendamento.repository.SecretariaRepository;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.multipart.MultipartFile;

import java.time.LocalDate;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class SecretariaServiceTest {

    @Mock
    private SecretariaRepository secretariaRepository;

    @Mock
    private EnderecoRepository enderecoRepository;

    @Mock
    private PasswordEncoder passwordEncoder;

    @Mock
    private ImageService imageService;

    @Mock
    private EmailService emailService;

    @Mock
    private AgendamentoRepository agendamentoRepository;

    @InjectMocks
    private SecretariaService secretariaService;

    private SecretariaDTO dto;
    private Secretaria secretaria;
    private Endereco endereco;

    @BeforeEach
    void setUp() {
        dto = new SecretariaDTO();
        dto.setNome("Secretaria Teste");
        dto.setEmail("secretaria@teste.com");
        dto.setCpf("12345678900");
        dto.setIdade(LocalDate.of(1990, 1, 1));
        dto.setStatus(true);
        dto.setSenha("senha123");
        dto.setCargo("Secretária");
        dto.setNotificacaoAtiva(true);

        EnderecoDTO enderecoDTO = new EnderecoDTO();
        enderecoDTO.setRua("Rua Teste");
        enderecoDTO.setNumero("123");
        enderecoDTO.setBairro("Bairro Teste");
        enderecoDTO.setCidade("Cidade Teste");
        enderecoDTO.setEstado("Estado Teste");
        enderecoDTO.setCep("12345678");
        enderecoDTO.setUf("SP");
        dto.setEndereco(enderecoDTO);

        endereco = new Endereco();
        endereco.setId(1L);
        endereco.setRua("Rua Teste");

        secretaria = new Secretaria();
        secretaria.setId(1L);
        secretaria.setNome("Secretaria Teste");
        secretaria.setEmail("secretaria@teste.com");
        secretaria.setCpf("12345678900");
        secretaria.setDataNascimento(LocalDate.of(1990, 1, 1));
        secretaria.setStatus(true);
        secretaria.setCargo("Secretária");
        secretaria.setRole(Role.SECRETARIA);
        secretaria.setEndereco(endereco);
    }

    @Test
    void criarSecretaria_DeveCriarComSucesso() {
        when(secretariaRepository.existsByEmail(dto.getEmail())).thenReturn(false);
        when(secretariaRepository.existsByCpf(dto.getCpf())).thenReturn(false);
        when(passwordEncoder.encode(dto.getSenha())).thenReturn("encodedPassword");
        when(enderecoRepository.save(any(Endereco.class))).thenReturn(endereco);
        when(secretariaRepository.save(any(Secretaria.class))).thenReturn(secretaria);
        when(emailService.envioEmailPrimeiroAcesso(anyString(), anyString(), anyString())).thenReturn("Email enviado");

        Secretaria result = secretariaService.criarSecretaria(dto);

        assertNotNull(result);
        assertEquals("Secretaria Teste", result.getNome());
        verify(secretariaRepository, atLeastOnce()).save(any(Secretaria.class));
        verify(emailService).envioEmailPrimeiroAcesso(anyString(), anyString(), anyString());
    }

    @Test
    void criarSecretaria_DeveLancarExcecao_QuandoEmailJaExiste() {
        when(secretariaRepository.existsByEmail(dto.getEmail())).thenReturn(true);

        assertThrows(EmailJaCadastradoException.class, () -> {
            secretariaService.criarSecretaria(dto);
        });

        verify(secretariaRepository, never()).save(any());
    }

    @Test
    void criarSecretaria_DeveLancarExcecao_QuandoCpfJaExiste() {
        when(secretariaRepository.existsByEmail(dto.getEmail())).thenReturn(false);
        when(secretariaRepository.existsByCpf(dto.getCpf())).thenReturn(true);

        assertThrows(CpfJaCadastradoException.class, () -> {
            secretariaService.criarSecretaria(dto);
        });

        verify(secretariaRepository, never()).save(any());
    }

    @Test
    void listarTodosDTO_DeveRetornarLista() {
        List<Secretaria> secretarias = Arrays.asList(secretaria);
        when(secretariaRepository.findAll()).thenReturn(secretarias);

        List<SecretariaResponseDTO> result = secretariaService.listarTodosDTO();

        assertNotNull(result);
        assertEquals(1, result.size());
        verify(secretariaRepository).findAll();
    }

    @Test
    void buscarPorIdDTO_DeveRetornarSecretaria() {
        when(secretariaRepository.findById(1L)).thenReturn(Optional.of(secretaria));

        SecretariaResponseDTO result = secretariaService.buscarPorIdDTO(1L);

        assertNotNull(result);
        assertEquals("Secretaria Teste", result.getNome());
        verify(secretariaRepository).findById(1L);
    }

    @Test
    void buscarPorIdDTO_DeveLancarExcecao_QuandoNaoEncontrado() {
        when(secretariaRepository.findById(1L)).thenReturn(Optional.empty());

        assertThrows(EntidadeNaoEncontradaException.class, () -> {
            secretariaService.buscarPorIdDTO(1L);
        });
    }

    @Test
    void atualizarSecretaria_DeveAtualizarComSucesso() {
        SecretariaDTO dtoAtualizacao = new SecretariaDTO();
        dtoAtualizacao.setNome("Secretaria Atualizada");

        when(secretariaRepository.findById(1L)).thenReturn(Optional.of(secretaria));
        when(secretariaRepository.save(any(Secretaria.class))).thenReturn(secretaria);

        SecretariaResponseDTO result = secretariaService.atualizarSecretaria(1L, dtoAtualizacao);

        assertNotNull(result);
        verify(secretariaRepository).findById(1L);
        verify(secretariaRepository).save(any(Secretaria.class));
    }

    @Test
    void atualizarSecretaria_DeveLancarExcecao_QuandoEmailJaExiste() {
        SecretariaDTO dtoAtualizacao = new SecretariaDTO();
        dtoAtualizacao.setEmail("novo@email.com");

        when(secretariaRepository.findById(1L)).thenReturn(Optional.of(secretaria));
        when(secretariaRepository.existsByEmail("novo@email.com")).thenReturn(true);

        assertThrows(EmailJaCadastradoException.class, () -> {
            secretariaService.atualizarSecretaria(1L, dtoAtualizacao);
        });
    }

    @Test
    void atualizarSecretaria_DeveLancarExcecao_QuandoCpfJaExiste() {
        SecretariaDTO dtoAtualizacao = new SecretariaDTO();
        dtoAtualizacao.setCpf("98765432100");

        when(secretariaRepository.findById(1L)).thenReturn(Optional.of(secretaria));
        when(secretariaRepository.existsByCpf("98765432100")).thenReturn(true);

        assertThrows(CpfJaCadastradoException.class, () -> {
            secretariaService.atualizarSecretaria(1L, dtoAtualizacao);
        });
    }

    @Test
    void atualizarSecretaria_DeveAtualizarSenha_QuandoSenhaFornecida() {
        SecretariaDTO dtoAtualizacao = new SecretariaDTO();
        dtoAtualizacao.setSenha("novaSenha");

        when(secretariaRepository.findById(1L)).thenReturn(Optional.of(secretaria));
        when(passwordEncoder.encode("novaSenha")).thenReturn("encodedNewPassword");
        when(secretariaRepository.save(any(Secretaria.class))).thenReturn(secretaria);

        secretariaService.atualizarSecretaria(1L, dtoAtualizacao);

        verify(passwordEncoder).encode("novaSenha");
    }

    @Test
    void salvarFoto_DeveSalvarComSucesso() throws Exception {
        MultipartFile file = mock(MultipartFile.class);
        secretaria.setFoto("fotoAntiga.jpg");

        when(secretariaRepository.findById(1L)).thenReturn(Optional.of(secretaria));
        when(imageService.atualizarImagem(eq(1L), eq(file), eq("fotoAntiga.jpg"), eq("secretaria")))
                .thenReturn("novaFoto.jpg");
        when(secretariaRepository.save(any(Secretaria.class))).thenReturn(secretaria);

        String result = secretariaService.salvarFoto(1L, file);

        assertEquals("novaFoto.jpg", result);
        verify(imageService).atualizarImagem(1L, file, "fotoAntiga.jpg", "secretaria");
        verify(secretariaRepository).save(any(Secretaria.class));
    }

    @Test
    void salvarFoto_DeveLancarExcecao_QuandoSecretariaNaoEncontrada() {
        MultipartFile file = mock(MultipartFile.class);

        when(secretariaRepository.findById(1L)).thenReturn(Optional.empty());

        assertThrows(EntidadeNaoEncontradaException.class, () -> {
            secretariaService.salvarFoto(1L, file);
        });
    }

    @Test
    void excluirSecretaria_DeveExcluirComSucesso() {
        secretaria.setFoto("foto.jpg");

        when(secretariaRepository.findById(1L)).thenReturn(Optional.of(secretaria));
        doNothing().when(imageService).removerImagem("foto.jpg");
        doNothing().when(secretariaRepository).deleteById(1L);

        secretariaService.excluirSecretaria(1L);

        verify(secretariaRepository).findById(1L);
        verify(imageService).removerImagem("foto.jpg");
        verify(secretariaRepository).deleteById(1L);
    }

    @Test
    void excluirSecretaria_DeveLancarExcecao_QuandoNaoEncontrado() {
        when(secretariaRepository.findById(1L)).thenReturn(Optional.empty());

        assertThrows(EntidadeNaoEncontradaException.class, () -> {
            secretariaService.excluirSecretaria(1L);
        });
    }

    @Test
    void excluirSecretaria_DeveExcluirSemFoto_QuandoFotoNula() {
        secretaria.setFoto(null);

        when(secretariaRepository.findById(1L)).thenReturn(Optional.of(secretaria));
        doNothing().when(secretariaRepository).deleteById(1L);

        secretariaService.excluirSecretaria(1L);

        verify(imageService, never()).removerImagem(anyString());
        verify(secretariaRepository).deleteById(1L);
    }

    @Test
    void respostaDashSecretariaAdm_DeveRetornarDashboard() {
        Agendamento agendamento = new Agendamento();
        Professor professor = new Professor();
        professor.setId(1L);
        professor.setNome("Professor Teste");
        agendamento.setProfessor(professor);

        when(agendamentoRepository.buscarAgendamentosPorIntervalo(any(), any())).thenReturn(Collections.singletonList(agendamento));
        when(agendamentoRepository.buscarAgendamentosPorDiaSemana(any(), any())).thenReturn(Collections.emptyList());

        ResponsDashSecretariaAdmDTO result = secretariaService.respostaDashSecretariaAdm(30);

        assertNotNull(result);
        verify(agendamentoRepository).buscarAgendamentosPorIntervalo(any(), any());
        verify(agendamentoRepository).buscarAgendamentosPorDiaSemana(any(), any());
    }

    @Test
    void toResponseDTO_DeveConverterCorretamente() {
        SecretariaResponseDTO result = secretariaService.toResponseDTO(secretaria);

        assertNotNull(result);
        assertEquals(1L, result.getId());
        assertEquals("Secretaria Teste", result.getNome());
        assertEquals("secretaria@teste.com", result.getEmail());
        assertEquals("12345678900", result.getCpf());
        assertNotNull(result.getEndereco());
    }
}

