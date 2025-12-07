package com.onePilates.agendamento.service;

import com.onePilates.agendamento.dto.EnderecoDTO;
import com.onePilates.agendamento.dto.ProfessorDTO;
import com.onePilates.agendamento.dto.response.ProfessorResponseDTO;
import com.onePilates.agendamento.dto.response.RespostaDashProfessoraDTO;
import com.onePilates.agendamento.exception.*;
import com.onePilates.agendamento.model.*;
import com.onePilates.agendamento.repository.AgendamentoRepository;
import com.onePilates.agendamento.repository.EspecialidadeRepository;
import com.onePilates.agendamento.repository.ProfessorRepository;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.multipart.MultipartFile;

import java.time.LocalDate;
import java.util.*;
import java.util.ArrayList;
import java.util.Arrays;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class ProfessorServiceTest {

    @Mock
    private ProfessorRepository professorRepository;

    @Mock
    private EspecialidadeRepository especialidadeRepository;

    @Mock
    private AgendamentoRepository agendamentoRepository;

    @Mock
    private AgendamentoService agendamentoService;

    @Mock
    private PasswordEncoder passwordEncoder;

    @Mock
    private ImageService imageService;

    @Mock
    private EmailService emailService;

    @InjectMocks
    private ProfessorService professorService;

    private ProfessorDTO dto;
    private Professor professor;
    private Especialidade especialidade;
    private Endereco endereco;

    @BeforeEach
    void setUp() {
        dto = new ProfessorDTO();
        dto.setNome("Professor Teste");
        dto.setEmail("professor@teste.com");
        dto.setCpf("12345678900");
        dto.setIdade(LocalDate.of(1990, 1, 1));
        dto.setSenha("senha123");
        dto.setCargo("Professor");
        dto.setNotificacaoAtiva(true);
        dto.setTelefone("11999999999");
        dto.setEspecialidadeIds(Set.of(1L));

        EnderecoDTO enderecoDTO = new EnderecoDTO();
        enderecoDTO.setRua("Rua Teste");
        enderecoDTO.setNumero("123");
        enderecoDTO.setBairro("Bairro Teste");
        enderecoDTO.setCidade("Cidade Teste");
        enderecoDTO.setEstado("Estado Teste");
        enderecoDTO.setCep("12345678");
        enderecoDTO.setUf("SP");
        dto.setEndereco(enderecoDTO);

        especialidade = new Especialidade();
        especialidade.setId(1L);
        especialidade.setNome("Pilates Clássico");

        endereco = new Endereco();
        endereco.setId(1L);
        endereco.setRua("Rua Teste");

        professor = new Professor();
        professor.setId(1L);
        professor.setNome("Professor Teste");
        professor.setEmail("professor@teste.com");
        professor.setCpf("12345678900");
        professor.setDataNascimento(LocalDate.of(1990, 1, 1));
        professor.setStatus(true);
        professor.setCargo("Professor");
        professor.setRole(Role.PROFESSOR);
        professor.setEspecialidades(Set.of(especialidade));
        professor.setEndereco(endereco);
    }

    @Test
    void criarProfessor_DeveCriarComSucesso() {
        when(especialidadeRepository.findById(1L)).thenReturn(Optional.of(especialidade));
        when(passwordEncoder.encode("senha123")).thenReturn("encodedPassword");
        when(professorRepository.save(any(Professor.class))).thenReturn(professor);
        when(emailService.envioEmailPrimeiroAcesso(anyString(), anyString(), anyString())).thenReturn("Email enviado");

        ProfessorResponseDTO result = professorService.criarProfessor(dto);

        assertNotNull(result);
        assertEquals("Professor Teste", result.getNome());
        verify(professorRepository, atLeastOnce()).save(any(Professor.class));
        verify(emailService).envioEmailPrimeiroAcesso(anyString(), anyString(), anyString());
    }

    @Test
    void criarProfessor_DeveLancarExcecao_QuandoNomeVazio() {
        dto.setNome("");

        assertThrows(CampoObrigatorioException.class, () -> {
            professorService.criarProfessor(dto);
        });
    }

    @Test
    void criarProfessor_DeveLancarExcecao_QuandoEmailVazio() {
        dto.setEmail("");

        assertThrows(CampoObrigatorioException.class, () -> {
            professorService.criarProfessor(dto);
        });
    }

    @Test
    void criarProfessor_DeveLancarExcecao_QuandoSenhaVazia() {
        dto.setSenha("");

        assertThrows(CampoObrigatorioException.class, () -> {
            professorService.criarProfessor(dto);
        });
    }

    @Test
    void criarProfessor_DeveLancarExcecao_QuandoEspecialidadeNaoEncontrada() {
        when(especialidadeRepository.findById(1L)).thenReturn(Optional.empty());

        assertThrows(EntidadeNaoEncontradaException.class, () -> {
            professorService.criarProfessor(dto);
        });
    }

    @Test
    void listarTodosDTO_DeveRetornarLista() {
        List<Professor> professores = Arrays.asList(professor);
        when(professorRepository.findAll()).thenReturn(professores);

        List<ProfessorResponseDTO> result = professorService.listarTodosDTO();

        assertNotNull(result);
        assertEquals(1, result.size());
        verify(professorRepository).findAll();
    }

    @Test
    void buscarPorIdDTO_DeveRetornarProfessor() {
        when(professorRepository.findById(1L)).thenReturn(Optional.of(professor));

        ProfessorResponseDTO result = professorService.buscarPorIdDTO(1L);

        assertNotNull(result);
        assertEquals("Professor Teste", result.getNome());
        verify(professorRepository).findById(1L);
    }

    @Test
    void buscarPorIdDTO_DeveLancarExcecao_QuandoNaoEncontrado() {
        when(professorRepository.findById(1L)).thenReturn(Optional.empty());

        assertThrows(EntidadeNaoEncontradaException.class, () -> {
            professorService.buscarPorIdDTO(1L);
        });
    }

    @Test
    void atualizarProfessor_DeveAtualizarComSucesso() {
        ProfessorDTO dtoAtualizacao = new ProfessorDTO();
        dtoAtualizacao.setNome("Professor Atualizado");

        when(professorRepository.findById(1L)).thenReturn(Optional.of(professor));
        when(professorRepository.save(any(Professor.class))).thenReturn(professor);

        ProfessorResponseDTO result = professorService.atualizarProfessor(1L, dtoAtualizacao);

        assertNotNull(result);
        verify(professorRepository).findById(1L);
        verify(professorRepository).save(any(Professor.class));
    }

    @Test
    void atualizarProfessor_DeveAtualizarSenha_QuandoSenhaFornecida() {
        ProfessorDTO dtoAtualizacao = new ProfessorDTO();
        dtoAtualizacao.setSenha("novaSenha");

        when(professorRepository.findById(1L)).thenReturn(Optional.of(professor));
        when(passwordEncoder.encode("novaSenha")).thenReturn("encodedNewPassword");
        when(professorRepository.save(any(Professor.class))).thenReturn(professor);

        professorService.atualizarProfessor(1L, dtoAtualizacao);

        verify(passwordEncoder).encode("novaSenha");
    }

    @Test
    void atualizarProfessor_DeveAtualizarEspecialidades_QuandoFornecidas() {
        Especialidade especialidade2 = new Especialidade();
        especialidade2.setId(2L);
        especialidade2.setNome("RPG");

        ProfessorDTO dtoAtualizacao = new ProfessorDTO();
        dtoAtualizacao.setEspecialidadeIds(Set.of(1L, 2L));

        when(professorRepository.findById(1L)).thenReturn(Optional.of(professor));
        when(especialidadeRepository.findById(1L)).thenReturn(Optional.of(especialidade));
        when(especialidadeRepository.findById(2L)).thenReturn(Optional.of(especialidade2));
        when(professorRepository.save(any(Professor.class))).thenReturn(professor);

        professorService.atualizarProfessor(1L, dtoAtualizacao);

        verify(especialidadeRepository).findById(1L);
        verify(especialidadeRepository).findById(2L);
        verify(professorRepository).save(any(Professor.class));
    }

    @Test
    void atualizarProfessor_DeveLancarExcecao_QuandoEspecialidadeNaoEncontrada() {
        ProfessorDTO dtoAtualizacao = new ProfessorDTO();
        dtoAtualizacao.setEspecialidadeIds(Set.of(999L));

        when(professorRepository.findById(1L)).thenReturn(Optional.of(professor));
        when(especialidadeRepository.findById(999L)).thenReturn(Optional.empty());

        assertThrows(EntidadeNaoEncontradaException.class, () -> {
            professorService.atualizarProfessor(1L, dtoAtualizacao);
        });
    }

    @Test
    void excluirProfessor_DeveExcluirComSucesso() {
        professor.setFoto("foto.jpg");

        when(professorRepository.findById(1L)).thenReturn(Optional.of(professor));
        doNothing().when(imageService).removerImagem("foto.jpg");
        doNothing().when(professorRepository).deleteById(1L);

        professorService.excluirProfessor(1L);

        verify(professorRepository).findById(1L);
        verify(imageService).removerImagem("foto.jpg");
        verify(professorRepository).deleteById(1L);
    }

    @Test
    void excluirProfessor_DeveLancarExcecao_QuandoNaoEncontrado() {
        when(professorRepository.findById(1L)).thenReturn(Optional.empty());

        assertThrows(EntidadeNaoEncontradaException.class, () -> {
            professorService.excluirProfessor(1L);
        });
    }

    @Test
    void salvarFoto_DeveSalvarComSucesso() throws Exception {
        MultipartFile file = mock(MultipartFile.class);
        professor.setFoto("fotoAntiga.jpg");

        when(professorRepository.findById(1L)).thenReturn(Optional.of(professor));
        when(imageService.atualizarImagem(eq(1L), eq(file), eq("fotoAntiga.jpg"), eq("professor")))
                .thenReturn("novaFoto.jpg");
        when(professorRepository.save(any(Professor.class))).thenReturn(professor);

        String result = professorService.salvarFoto(1L, file);

        assertEquals("novaFoto.jpg", result);
        verify(imageService).atualizarImagem(1L, file, "fotoAntiga.jpg", "professor");
        verify(professorRepository).save(any(Professor.class));
    }

    @Test
    void salvarFoto_DeveLancarExcecao_QuandoProfessorNaoEncontrado() {
        MultipartFile file = mock(MultipartFile.class);

        when(professorRepository.findById(1L)).thenReturn(Optional.empty());

        assertThrows(EntidadeNaoEncontradaException.class, () -> {
            professorService.salvarFoto(1L, file);
        });
    }

    @Test
    void respostaDashProfessora_DeveRetornarDashboard_QuandoAgendamentosExistem() {
        when(professorRepository.existsById(1L)).thenReturn(true);
        when(agendamentoRepository.countByProfessorIdAndPeriod(any(), any(), any())).thenReturn(10L);
        when(agendamentoRepository.buscarAgendamentosPorDiaSemanaRaw(any(), any(), any())).thenReturn(Collections.emptyList());
        when(agendamentoRepository.buscarDistribuicaoAulasPorEspecialidadeRaw(any(), any(), any(), any())).thenReturn(Collections.emptyList());
        when(agendamentoRepository.findAgendamentosByProfessorAndPeriod(any(), any(), any())).thenReturn(Collections.emptyList());

        RespostaDashProfessoraDTO result = professorService.respostaDashProfessora(1L, 30);

        assertNotNull(result);
        verify(professorRepository).existsById(1L);
    }

    @Test
    void respostaDashProfessora_DeveRetornarVazio_QuandoNaoHaAgendamentos() {
        when(professorRepository.existsById(1L)).thenReturn(true);
        when(agendamentoRepository.countByProfessorIdAndPeriod(any(), any(), any())).thenReturn(0L);

        RespostaDashProfessoraDTO result = professorService.respostaDashProfessora(1L, 30);

        assertNotNull(result);
        assertTrue(result.getAgendamentosPorDiasDTO().isEmpty());
        assertTrue(result.getAulasPorEspecialidadesDTO().isEmpty());
    }

    @Test
    void respostaDashProfessora_DeveLancarExcecao_QuandoProfessorNaoEncontrado() {
        when(professorRepository.existsById(1L)).thenReturn(false);

        assertThrows(EntidadeNaoEncontradaException.class, () -> {
            professorService.respostaDashProfessora(1L, 30);
        });
    }

    @Test
    void toResponseDTO_DeveConverterCorretamente() {
        ProfessorResponseDTO result = professorService.toResponseDTO(professor);

        assertNotNull(result);
        assertEquals(1L, result.getId());
        assertEquals("Professor Teste", result.getNome());
        assertEquals("professor@teste.com", result.getEmail());
        assertNotNull(result.getEspecialidades());
        assertNotNull(result.getEndereco());
    }

    @Test
    void criarProfessor_DeveCriarComRoleDefault_QuandoRoleNaoInformada() {
        dto.setRole(null);
        when(especialidadeRepository.findById(1L)).thenReturn(Optional.of(especialidade));
        when(passwordEncoder.encode("senha123")).thenReturn("encodedPassword");
        when(professorRepository.save(any(Professor.class))).thenReturn(professor);
        when(emailService.envioEmailPrimeiroAcesso(anyString(), anyString(), anyString())).thenReturn("Email enviado");

        ProfessorResponseDTO result = professorService.criarProfessor(dto);

        assertNotNull(result);
        verify(professorRepository, atLeastOnce()).save(any(Professor.class));
    }

    @Test
    void criarProfessor_DeveProcessarImagem_QuandoImagemFornecida() throws Exception {
        MultipartFile imagem = mock(MultipartFile.class);
        dto.setImagem(imagem);

        when(especialidadeRepository.findById(1L)).thenReturn(Optional.of(especialidade));
        when(passwordEncoder.encode("senha123")).thenReturn("encodedPassword");
        when(professorRepository.save(any(Professor.class))).thenReturn(professor);
        when(imageService.salvarImagem(anyLong(), any(MultipartFile.class), eq("professor"))).thenReturn("foto.jpg");
        when(emailService.envioEmailPrimeiroAcesso(anyString(), anyString(), anyString())).thenReturn("Email enviado");

        professorService.criarProfessor(dto);

        verify(imageService).salvarImagem(anyLong(), any(MultipartFile.class), eq("professor"));
    }

    @Test
    void atualizarProfessor_DeveMantemDadosAnteriores_QuandoCamposNaoInformados() {
        ProfessorDTO dtoAtualizacao = new ProfessorDTO();

        when(professorRepository.findById(1L)).thenReturn(Optional.of(professor));
        when(professorRepository.save(any(Professor.class))).thenReturn(professor);

        ProfessorResponseDTO result = professorService.atualizarProfessor(1L, dtoAtualizacao);

        assertNotNull(result);
        verify(professorRepository).save(any(Professor.class));
    }

    @Test
    void atualizarProfessor_DeveCriarEndereco_QuandoNaoExistir() {
        professor.setEndereco(null);
        EnderecoDTO enderecoDTO = new EnderecoDTO();
        enderecoDTO.setRua("Nova Rua");
        dto.setEndereco(enderecoDTO);
        // Não atualizar especialidades neste teste, então seta como null
        dto.setEspecialidadeIds(null);

        when(professorRepository.findById(1L)).thenReturn(Optional.of(professor));
        when(professorRepository.save(any(Professor.class))).thenReturn(professor);

        professorService.atualizarProfessor(1L, dto);

        verify(professorRepository).save(any(Professor.class));
    }

    @Test
    void respostaDashProfessora_DeveRetornarKPIsCorretos_QuandoHaAgendamentos() {
        when(professorRepository.existsById(1L)).thenReturn(true);
        when(agendamentoRepository.countByProfessorIdAndPeriod(any(), any(), any())).thenReturn(10L);
        
        Object[] linha1 = new Object[]{"Monday", 5L};
        Object[] linha2 = new Object[]{"Wednesday", 3L};
        List<Object[]> dadosDiaSemana = new ArrayList<>();
        dadosDiaSemana.add(linha1);
        dadosDiaSemana.add(linha2);
        
        when(agendamentoRepository.buscarAgendamentosPorDiaSemanaRaw(any(), any(), any())).thenReturn(dadosDiaSemana);
        
        Object[] linhaEspecialidade = new Object[]{"Pilates Clássico", 0.6};
        List<Object[]> dadosEspecialidade = new ArrayList<>();
        dadosEspecialidade.add(linhaEspecialidade);
        
        when(agendamentoRepository.buscarDistribuicaoAulasPorEspecialidadeRaw(any(), any(), any(), any())).thenReturn(dadosEspecialidade);
        
        Agendamento agendamentoTeste = new Agendamento();
        agendamentoTeste.setProfessor(professor);
        agendamentoTeste.setEspecialidade(especialidade);
        
        Aluno alunoTeste = new Aluno();
        alunoTeste.setId(1L);
        alunoTeste.setNome("Aluno Teste");
        
        Set<AgendamentoAluno> agendamentoAlunos = new HashSet<>();
        AgendamentoAluno aa = new AgendamentoAluno(agendamentoTeste, alunoTeste);
        agendamentoAlunos.add(aa);
        agendamentoTeste.setAgendamentoAlunos(agendamentoAlunos);
        
        when(agendamentoRepository.findAgendamentosByProfessorAndPeriod(any(), any(), any()))
            .thenReturn(Arrays.asList(agendamentoTeste));

        RespostaDashProfessoraDTO result = professorService.respostaDashProfessora(1L, 30);

        assertNotNull(result);
        assertNotNull(result.getKpisProfessorDTO());
        verify(professorRepository).existsById(1L);
    }

    @Test
    void respostaDashProfessora_DeveLancarExcecao_QuandoProfessorNaoExiste() {
        when(professorRepository.existsById(1L)).thenReturn(false);

        assertThrows(EntidadeNaoEncontradaException.class, () -> {
            professorService.respostaDashProfessora(1L, 30);
        });
    }

    @Test
    void criarProfessor_DeveUsarFotoString_QuandoImagemNaoFornecida() {
        dto.setImagem(null);
        dto.setFoto("fotoExistente.jpg");

        when(especialidadeRepository.findById(1L)).thenReturn(Optional.of(especialidade));
        when(passwordEncoder.encode("senha123")).thenReturn("encodedPassword");
        when(professorRepository.save(any(Professor.class))).thenReturn(professor);
        when(emailService.envioEmailPrimeiroAcesso(anyString(), anyString(), anyString())).thenReturn("Email enviado");

        professorService.criarProfessor(dto);

        verify(professorRepository, atLeast(2)).save(any(Professor.class));
    }

    @Test
    void atualizarProfessor_DeveAtualizarEndereco_QuandoEnderecoExistir() {
        EnderecoDTO enderecoDTO = new EnderecoDTO();
        enderecoDTO.setRua("Rua Atualizada");
        enderecoDTO.setNumero("456");
        dto.setEndereco(enderecoDTO);
        // Não atualizar especialidades neste teste, então seta como null
        dto.setEspecialidadeIds(null);

        when(professorRepository.findById(1L)).thenReturn(Optional.of(professor));
        when(professorRepository.save(any(Professor.class))).thenReturn(professor);

        professorService.atualizarProfessor(1L, dto);

        verify(professorRepository).save(any(Professor.class));
    }

}

