package com.onePilates.agendamento.service;

import com.onePilates.agendamento.dto.*;
import com.onePilates.agendamento.dto.response.EnderecoResponseDTO;
import com.onePilates.agendamento.dto.response.EspecialidadeResponseDTO;
import com.onePilates.agendamento.dto.response.ProfessorResponseDTO;
import com.onePilates.agendamento.dto.response.RespostaDashProfessoraDTO;
import com.onePilates.agendamento.exception.*;
import com.onePilates.agendamento.model.Endereco;
import com.onePilates.agendamento.model.Especialidade;
import com.onePilates.agendamento.model.Professor;
import com.onePilates.agendamento.model.Role;
import com.onePilates.agendamento.repository.AgendamentoRepository;
import com.onePilates.agendamento.repository.EspecialidadeRepository;
import com.onePilates.agendamento.repository.ProfessorRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.*;
import java.util.stream.Collectors;

@Service
public class ProfessorService {

    private static final Logger logger = LoggerFactory.getLogger(ProfessorService.class);

    private final ProfessorRepository professorRepository;
    private final EspecialidadeRepository especialidadeRepository;
    private final AgendamentoRepository agendamentoRepository;
    private final PasswordEncoder passwordEncoder;

    public ProfessorService(ProfessorRepository professorRepository,
                            EspecialidadeRepository especialidadeRepository, AgendamentoRepository agendamentoRepository,
                            PasswordEncoder passwordEncoder) {
        this.professorRepository = professorRepository;
        this.especialidadeRepository = especialidadeRepository;
        this.agendamentoRepository = agendamentoRepository;
        this.passwordEncoder = passwordEncoder;
    }

    @Transactional
    public ProfessorResponseDTO criarProfessor(ProfessorDTO dto) {
        logger.info("Tentativa de criar professor: {}", dto.getNome());
        try {
            // fluxo padrão: aceita dto.role se presente, mas endpoint público deve forçar PROFESSOR
            Role roleToSet = dto.getRole() != null ? dto.getRole() : Role.PROFESSOR;
            ProfessorResponseDTO response = criarProfessorInterno(dto, roleToSet);
            logger.info("Professor criado com sucesso. ID: {}", response.getId());
            return response;
        } catch (BusinessException e) {
            logger.warn("Falha ao criar professor: {}", e.getMessage());
            throw e;
        } catch (Exception e) {
            logger.error("Erro inesperado ao criar professor", e);
            throw e;
        }
    }


    private ProfessorResponseDTO criarProfessorInterno(ProfessorDTO dto, Role roleToSet) {
        validateDto(dto);

        Professor professor = new Professor();
        professor.setNome(dto.getNome());
        professor.setEmail(dto.getEmail());
        professor.setCpf(dto.getCpf());
        professor.setDataNascimento(dto.getIdade());
        professor.setStatus(true);
        professor.setFoto(dto.getFoto());
        professor.setObservacoes(dto.getObservacoes());
        professor.setNotificacaoAtiva(dto.getNotificacaoAtiva() != null ? dto.getNotificacaoAtiva() : Boolean.FALSE);
        professor.setCargo(dto.getCargo());
        professor.setRole(roleToSet);
        professor.setTelefone(dto.getTelefone());

        if (dto.getSenha() != null) {
            professor.setSenha(passwordEncoder.encode(dto.getSenha()));
        } else {
            throw new CampoObrigatorioException("Senha é obrigatória");
        }

        EnderecoDTO enderecoDTO = dto.getEndereco();
        if (enderecoDTO != null) {
            Endereco endereco = new Endereco();
            endereco.setRua(enderecoDTO.getRua());
            endereco.setNumero(enderecoDTO.getNumero());
            endereco.setBairro(enderecoDTO.getBairro());
            endereco.setCidade(enderecoDTO.getCidade());
            endereco.setEstado(enderecoDTO.getEstado());
            endereco.setCep(enderecoDTO.getCep());
            endereco.setUf(enderecoDTO.getUf());
            professor.setEndereco(endereco);
        }

        Set<Especialidade> especialidades = Optional.ofNullable(dto.getEspecialidadeIds())
                .orElse(Collections.emptySet())
                .stream()
                .map(id -> especialidadeRepository.findById(id)
                        .orElseThrow(() -> new EntidadeNaoEncontradaException("Especialidade não encontrada: " + id)))
                .collect(Collectors.toSet());
        professor.setEspecialidades(especialidades);

        Professor salvo = professorRepository.save(professor);
        return toResponseDTO(salvo);
    }

    public List<ProfessorResponseDTO> listarTodosDTO() {
        logger.debug("Listando todos os professores");
        List<ProfessorResponseDTO> professores = professorRepository.findAll()
                .stream()
                .map(this::toResponseDTO)
                .collect(Collectors.toList());
        logger.debug("Encontrados {} professores", professores.size());
        return professores;
    }

    public ProfessorResponseDTO buscarPorIdDTO(Long id) {
        logger.debug("Buscando professor por ID: {}", id);
        return toResponseDTO(buscarPorId(id));
    }

    @Transactional
    public ProfessorResponseDTO atualizarProfessor(Long id, ProfessorDTO dto) {
        logger.info("Tentativa de atualizar professor ID: {}", id);
        try {
            Professor existente = buscarPorId(id);

            if (dto.getNome() != null) existente.setNome(dto.getNome());
            if (dto.getEmail() != null) existente.setEmail(dto.getEmail());
            if (dto.getCpf() != null) existente.setCpf(dto.getCpf());
            if (dto.getIdade() != null) existente.setDataNascimento(dto.getIdade());
            if (dto.getFoto() != null) existente.setFoto(dto.getFoto());
            if (dto.getObservacoes() != null) existente.setObservacoes(dto.getObservacoes());
            if (dto.getNotificacaoAtiva() != null) existente.setNotificacaoAtiva(dto.getNotificacaoAtiva());
            if (dto.getCargo() != null) existente.setCargo(dto.getCargo());
            if (dto.getTelefone() != null) existente.setTelefone(dto.getTelefone());

            if (dto.getSenha() != null) {
                existente.setSenha(passwordEncoder.encode(dto.getSenha()));
            }

            if (dto.getRole() != null) {
                existente.setRole(dto.getRole()); // se quiser proteger alteração de role, aplique checagem adicional
            }

            if (dto.getEndereco() != null) {
                EnderecoDTO e = dto.getEndereco();
                Endereco endereco = existente.getEndereco() != null ? existente.getEndereco() : new Endereco();
                if (e.getRua() != null) endereco.setRua(e.getRua());
                if (e.getNumero() != null) endereco.setNumero(e.getNumero());
                if (e.getBairro() != null) endereco.setBairro(e.getBairro());
                if (e.getCidade() != null) endereco.setCidade(e.getCidade());
                if (e.getEstado() != null) endereco.setEstado(e.getEstado());
                if (e.getCep() != null) endereco.setCep(e.getCep());
                if (e.getUf() != null) endereco.setUf(e.getUf());
                existente.setEndereco(endereco);
            }

            if (dto.getEspecialidadeIds() != null) {
                Set<Especialidade> especialidades = dto.getEspecialidadeIds().stream()
                        .map(idEsp -> especialidadeRepository.findById(idEsp)
                                .orElseThrow(() -> new EntidadeNaoEncontradaException("Especialidade não encontrada: " + idEsp)))
                        .collect(Collectors.toSet());
                existente.setEspecialidades(especialidades);
            }

            Professor atualizado = professorRepository.save(existente);
            ProfessorResponseDTO response = toResponseDTO(atualizado);
            logger.info("Professor atualizado com sucesso. ID: {}", id);
            return response;
        } catch (BusinessException e) {
            logger.warn("Falha ao atualizar professor ID {}: {}", id, e.getMessage());
            throw e;
        } catch (Exception e) {
            logger.error("Erro inesperado ao atualizar professor ID: {}", id, e);
            throw e;
        }
    }

    @Transactional
    public void excluirProfessor(Long id) {
        logger.info("Tentativa de excluir professor ID: {}", id);
        try {
            if (!professorRepository.existsById(id)) {
                throw new EntidadeNaoEncontradaException("Professor não encontrado");
            }
            professorRepository.deleteById(id);
            logger.info("Professor excluído com sucesso. ID: {}", id);
        } catch (BusinessException e) {
            logger.warn("Falha ao excluir professor ID {}: {}", id, e.getMessage());
            throw e;
        } catch (Exception e) {
            logger.error("Erro inesperado ao excluir professor ID: {}", id, e);
            throw e;
        }
    }

    private Professor buscarPorId(Long id) {
        return professorRepository.findById(id)
                .orElseThrow(() -> new EntidadeNaoEncontradaException("Professor não encontrado"));
    }

    public ProfessorResponseDTO toResponseDTO(Professor professor) {
        ProfessorResponseDTO dto = new ProfessorResponseDTO();
        dto.setId(professor.getId());
        dto.setNome(professor.getNome());
        dto.setEmail(professor.getEmail());
        dto.setCpf(professor.getCpf());
        dto.setIdade(professor.getDataNascimento());
        dto.setStatus(professor.getStatus());
        dto.setFoto(professor.getFoto());
        dto.setObservacoes(professor.getObservacoes());
        dto.setNotificacaoAtiva(professor.getNotificacaoAtiva());
        dto.setCargo(professor.getCargo());
        dto.setRole(professor.getRole() != null ? professor.getRole().name() : null);

        if (professor.getEndereco() != null) {
            EnderecoResponseDTO enderecoDTO = new EnderecoResponseDTO();
            enderecoDTO.setRua(professor.getEndereco().getRua());
            enderecoDTO.setCidade(professor.getEndereco().getCidade());
            enderecoDTO.setEstado(professor.getEndereco().getEstado());
            enderecoDTO.setCep(professor.getEndereco().getCep());
            dto.setEndereco(enderecoDTO);
        }

        if (professor.getEspecialidades() != null && !professor.getEspecialidades().isEmpty()) {
            Set<EspecialidadeResponseDTO> especialidadesDTO = professor.getEspecialidades().stream()
                    .map(esp -> {
                        EspecialidadeResponseDTO espDTO = new EspecialidadeResponseDTO();
                        espDTO.setId(esp.getId());
                        espDTO.setNome(esp.getNome());
                        return espDTO;
                    })
                    .collect(Collectors.toSet());
            dto.setEspecialidades(especialidadesDTO);
        }

        return dto;
    }

    private void validateDto(ProfessorDTO dto) {
        if (dto == null) throw new CampoObrigatorioException("Payload inválido");
        if (dto.getNome() == null || dto.getNome().isBlank()) throw new CampoObrigatorioException("Nome é obrigatório");
        if (dto.getEmail() == null || dto.getEmail().isBlank()) throw new CampoObrigatorioException("Email é obrigatório");
        if (dto.getSenha() == null || dto.getSenha().isBlank()) throw new CampoObrigatorioException("Senha é obrigatória");
    }

    public RespostaDashProfessoraDTO respostaDashProfessora(Long id , Integer qtdUltimosDias) {
        logger.debug("Buscando dashboard para professor ID: {}, últimos {} dias", id, qtdUltimosDias);
        LocalDateTime inicio = LocalDate.now().minusDays(qtdUltimosDias).atStartOfDay();
        LocalDateTime fim = LocalDate.now().plusDays(1).atStartOfDay();

        List<AgendamentoPorDiaDTO> grafico1 = agendamentoRepository.buscarAgendamentosPorDiaSemana(id, inicio, fim);

        Map<String, Integer> ordemDias = Map.of(
                "Sunday", 1, "Monday", 2, "Tuesday", 3, "Wednesday", 4,
                "Thursday", 5, "Friday", 6, "Saturday", 7
        );

        grafico1.sort(Comparator.comparingInt(dto -> ordemDias.getOrDefault(dto.getDiaSemana(), 8)));

        List<AulaPorEspecialidadeDTO> grafico2 =agendamentoRepository.buscarDistribuicaoAulasPorEspecialidade(id, qtdUltimosDias);

        return new RespostaDashProfessoraDTO(grafico1, grafico2);

    }



}