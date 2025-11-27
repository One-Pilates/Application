package com.onePilates.agendamento.service;

import com.onePilates.agendamento.dto.AgendamentoDTO;
import com.onePilates.agendamento.dto.response.AgendamentoResponseDTO;
import com.onePilates.agendamento.dto.response.AlunoAgendamentoResponseDTO;
import com.onePilates.agendamento.exception.*;
import com.onePilates.agendamento.model.*;
import com.onePilates.agendamento.observer.AgendamentoNotifier;
import com.onePilates.agendamento.repository.*;
import com.onePilates.agendamento.validator.AgendamentoValidator;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.*;
import java.util.stream.Collectors;

@Service
public class AgendamentoService {

    private static final Logger logger = LoggerFactory.getLogger(AgendamentoService.class);

    private final AgendamentoRepository agendamentoRepository;
    private final ProfessorRepository professorRepository;
    private final SalaRepository salaRepository;
    private final EspecialidadeRepository especialidadeRepository;
    private final AlunoRepository alunoRepository;
    private final AgendamentoNotifier notifier;
    private final AgendamentoAlunoRepository agendamentoAlunoRepository;
    private final AgendamentoValidator agendamentoValidator;

    @Autowired
    private EmailService emailService;

    public AgendamentoService(
            AgendamentoRepository agendamentoRepository,
            ProfessorRepository professorRepository,
            SalaRepository salaRepository,
            EspecialidadeRepository especialidadeRepository,
            AlunoRepository alunoRepository,
            AgendamentoNotifier notifier,
            AgendamentoAlunoRepository agendamentoAlunoRepository,
            AgendamentoValidator agendamentoValidator
    ) {
        this.agendamentoRepository = agendamentoRepository;
        this.professorRepository = professorRepository;
        this.salaRepository = salaRepository;
        this.especialidadeRepository = especialidadeRepository;
        this.alunoRepository = alunoRepository;
        this.notifier = notifier;
        this.agendamentoAlunoRepository = agendamentoAlunoRepository;
        this.agendamentoValidator = agendamentoValidator;
    }

    /**
     * Cria um novo agendamento após validar todas as regras de negócio.
     *
     * @param dto DTO contendo os dados do agendamento (data/hora, sala, professor, especialidade e alunos)
     * @return Agendamento criado e salvo no banco de dados
     * @throws BusinessException se alguma validação de regra de negócio falhar
     */
    @Transactional
    public Agendamento criarAgendamento(AgendamentoDTO dto) {
        logger.info("Tentativa de criar agendamento para data/hora: {}", dto.getDataHora());
        
        try {
            // Validação é feita no validator
            Agendamento agendamento = mapDtoToEntity(dto);
            agendamento = agendamentoRepository.save(agendamento);
            
            logger.debug("Agendamento criado com ID: {}", agendamento.getId());
            
            // Recarregar o agendamento com todas as relações para o observer
            agendamento = agendamentoRepository.findById(agendamento.getId())
                    .orElseThrow(() -> new EntidadeNaoEncontradaException("Erro ao recarregar agendamento"));

            Professor professor = agendamento.getProfessor();

            if (professor.getNotificacaoAtiva() != null && professor.getNotificacaoAtiva()) {
                logger.debug("Enviando notificação para professor: {}", professor.getNome());
                notifier.notificarTodos(agendamento);
            }

            logger.info("Agendamento criado com sucesso. ID: {}", agendamento.getId());
            return agendamento;
        } catch (BusinessException e) {
            logger.warn("Falha ao criar agendamento: {}", e.getMessage());
            throw e;
        } catch (Exception e) {
            logger.error("Erro inesperado ao criar agendamento", e);
            throw e;
        }
    }

    /**
     * Busca todos os agendamentos de um professor específico.
     *
     * @param id ID do professor
     * @return Lista de agendamentos do professor
     */
    public List<AgendamentoResponseDTO> buscarAgendamentosPorIdProfessor(Long id) {
        logger.debug("Buscando agendamentos para professor ID: {}", id);
        List<Agendamento> agendamentos = agendamentoRepository.findByProfessorId(id);
        logger.debug("Encontrados {} agendamentos para professor ID: {}", agendamentos.size(), id);
        return agendamentos.stream()
                .map(this::toResponseDTO)
                .collect(Collectors.toList());
    }

    public List<AgendamentoResponseDTO> buscarAgendamentosPorIdSala(Long id) {


        if (salaRepository.findById(id).isEmpty()) {
            throw new RuntimeException("A sala informada não é válida.");
        }


        List<Agendamento> agendamentos = agendamentoRepository.findBySalaId(id);

        if (agendamentos.isEmpty()) {
            throw new RuntimeException("Nenhum agendamento encontrado para a sala informada.");
        }


        return agendamentos.stream()
                .map(this::toResponseDTO)
                .collect(Collectors.toList());
    }


    public List<AgendamentoResponseDTO> buscarAgendamentosPorIdsDeSalaEProfessor(Long idSala, Long idProfessor) {

        if (idSala == null || idProfessor == null) {
            throw new IllegalArgumentException("Dados fornecidos inválidos.");
        }
        if(salaRepository.findById(idSala).isEmpty()) {
            throw new RuntimeException("A sala informada não é valida");
        }
        if(idProfessor !=0){
            if(professorRepository.findById(idProfessor).isEmpty()) {
                throw new RuntimeException("Professor informado não existente");
            }
        }

        List<Agendamento> agendamentos;


        if (idProfessor != 0) {
            agendamentos = agendamentoRepository.findByProfessorId(idProfessor);

            if (agendamentos.isEmpty()) {
                throw new RuntimeException("O professor selecionado não possui agendamentos.");
            }

        } else {

            agendamentos = agendamentoRepository.findAll();

            if (agendamentos.isEmpty()) {
                throw new RuntimeException("Nenhum agendamento encontrado.");
            }
        }

        List<Agendamento> filtrados = agendamentos.stream()
                .filter(a -> a.getSala().getId().equals(idSala))
                .collect(Collectors.toList());

        if (filtrados.isEmpty() && idProfessor != 0) {
            throw new RuntimeException("Nenhum agendamento encontrado para o(a) professor(a) " + agendamentos.getFirst().getProfessor().getNome() + " na sala informada.");
        }
        if(filtrados.isEmpty() && idProfessor == 0) {
            throw new RuntimeException("Nenhum agendamento encontrado na sala informada.");
        }

        return filtrados.stream()
                .map(this::toResponseDTO)
                .collect(Collectors.toList());
    }



    private Agendamento mapDtoToEntity(AgendamentoDTO dto) {
        // Validar antes de criar a entidade usando o validator dedicado
        agendamentoValidator.validar(dto);

        Agendamento agendamento = new Agendamento();
        agendamento.setDataHora(dto.getDataHora());

        Professor professor = professorRepository.findById(dto.getProfessorId())
                .orElseThrow(() -> new EntidadeNaoEncontradaException("Professor não encontrado"));
        agendamento.setProfessor(professor);

        Sala sala = salaRepository.findById(dto.getSalaId())
                .orElseThrow(() -> new EntidadeNaoEncontradaException("Sala não encontrada"));
        agendamento.setSala(sala);

        Especialidade especialidade = especialidadeRepository.findById(dto.getEspecialidadeId())
                .orElseThrow(() -> new EntidadeNaoEncontradaException("Especialidade não encontrada"));
        agendamento.setEspecialidade(especialidade);

        // Buscar alunos e criar AgendamentoAluno
        List<Aluno> alunos = alunoRepository.findAllById(dto.getAlunoIds());
        if (alunos.size() != dto.getAlunoIds().size()) {
            throw new EntidadeNaoEncontradaException("Um ou mais alunos não foram encontrados");
        }

        Set<AgendamentoAluno> agendamentoAlunos = alunos.stream()
                .map(aluno -> new AgendamentoAluno(agendamento, aluno))
                .collect(Collectors.toSet());

        agendamento.setAgendamentoAlunos(agendamentoAlunos);

        return agendamento;
    }

    /**
     * Lista todos os agendamentos cadastrados no sistema.
     *
     * @return Lista de todos os agendamentos
     */
    public List<AgendamentoResponseDTO> listarTodosDTO() {
        logger.debug("Listando todos os agendamentos");
        List<Agendamento> agendamentos = agendamentoRepository.findAll();
        logger.debug("Encontrados {} agendamentos", agendamentos.size());
        return agendamentos.stream()
                .map(this::toResponseDTO)
                .collect(Collectors.toList());
    }

    /**
     * Busca um agendamento específico pelo ID.
     *
     * @param id ID do agendamento
     * @return DTO com os dados do agendamento
     * @throws EntidadeNaoEncontradaException se o agendamento não for encontrado
     */
    public AgendamentoResponseDTO buscarPorIdDTO(Long id) {
        logger.debug("Buscando agendamento por ID: {}", id);
        return toResponseDTO(buscarPorId(id));
    }

    /**
     * Atualiza um agendamento existente. Apenas os campos fornecidos no DTO serão atualizados.
     *
     * @param agendamentoId ID do agendamento a ser atualizado
     * @param dto DTO contendo os campos a serem atualizados
     * @return DTO com os dados atualizados do agendamento
     * @throws EntidadeNaoEncontradaException se o agendamento não for encontrado
     * @throws BusinessException se alguma validação de regra de negócio falhar
     */
    @Transactional
    public AgendamentoResponseDTO atualizarAgendamento(Long agendamentoId, AgendamentoDTO dto) {
        logger.info("Tentativa de atualizar agendamento ID: {}", agendamentoId);
        
        try {
            Agendamento agendamento = buscarPorId(agendamentoId);
            
            // Criar DTO temporário com dados do agendamento existente para validação
            AgendamentoDTO dtoValidacao = new AgendamentoDTO();
            dtoValidacao.setDataHora(dto.getDataHora() != null ? dto.getDataHora() : agendamento.getDataHora());
            dtoValidacao.setProfessorId(dto.getProfessorId() != null ? dto.getProfessorId() : agendamento.getProfessor().getId());
            dtoValidacao.setSalaId(dto.getSalaId() != null ? dto.getSalaId() : agendamento.getSala().getId());
            dtoValidacao.setEspecialidadeId(dto.getEspecialidadeId() != null ? dto.getEspecialidadeId() : agendamento.getEspecialidade().getId());
            dtoValidacao.setAlunoIds(dto.getAlunoIds() != null ? dto.getAlunoIds() : 
                agendamento.getAgendamentoAlunos().stream()
                    .map(aa -> aa.getAluno().getId())
                    .collect(Collectors.toSet()));
            
            // Validar com os novos dados usando o validator
            agendamentoValidator.validar(dtoValidacao);
            
            if (dto.getDataHora() != null) agendamento.setDataHora(dto.getDataHora());
            if (dto.getProfessorId() != null) {
                Professor professor = professorRepository.findById(dto.getProfessorId())
                        .orElseThrow(() -> new EntidadeNaoEncontradaException("Professor não encontrado"));
                agendamento.setProfessor(professor);
            }
            if (dto.getSalaId() != null) {
                Sala sala = salaRepository.findById(dto.getSalaId())
                        .orElseThrow(() -> new EntidadeNaoEncontradaException("Sala não encontrada"));
                agendamento.setSala(sala);
            }
            if (dto.getEspecialidadeId() != null) {
                Especialidade especialidade = especialidadeRepository.findById(dto.getEspecialidadeId())
                        .orElseThrow(() -> new EntidadeNaoEncontradaException("Especialidade não encontrada"));
                agendamento.setEspecialidade(especialidade);
            }
            if (dto.getAlunoIds() != null) {
                // Remover alunos antigos e adicionar novos
                agendamento.getAgendamentoAlunos().clear();
                List<Aluno> alunos = alunoRepository.findAllById(dto.getAlunoIds());
                Set<AgendamentoAluno> agendamentoAlunos = alunos.stream()
                        .map(aluno -> new AgendamentoAluno(agendamento, aluno))
                        .collect(Collectors.toSet());
                agendamento.setAgendamentoAlunos(agendamentoAlunos);
            }
            
            AgendamentoResponseDTO response = toResponseDTO(agendamentoRepository.save(agendamento));
            logger.info("Agendamento atualizado com sucesso. ID: {}", agendamentoId);
            return response;
        } catch (BusinessException e) {
            logger.warn("Falha ao atualizar agendamento ID {}: {}", agendamentoId, e.getMessage());
            throw e;
        } catch (Exception e) {
            logger.error("Erro inesperado ao atualizar agendamento ID: {}", agendamentoId, e);
            throw e;
        }
    }

    /**
     * Exclui um agendamento do sistema.
     *
     * @param id ID do agendamento a ser excluído
     * @throws EntidadeNaoEncontradaException se o agendamento não for encontrado
     */
    @Transactional
    public void excluirAgendamento(Long id) {
        logger.info("Tentativa de excluir agendamento ID: {}", id);
        
        try {
            if (!agendamentoRepository.existsById(id)) {
                throw new EntidadeNaoEncontradaException("Agendamento não encontrado");
            }
           Agendamento agendamento = agendamentoRepository.findById(id).orElseThrow();
            emailService.envioEmailCancelamentoAula(agendamento.getProfessor().getNome(),
                    agendamento.getProfessor().getEmail(), agendamento.getDataHora());
            
            agendamentoRepository.deleteById(id);
            logger.info("Agendamento excluído com sucesso. ID: {}", id);
        } catch (BusinessException e) {
            logger.warn("Falha ao excluir agendamento ID {}: {}", id, e.getMessage());
            throw e;
        } catch (Exception e) {
            logger.error("Erro inesperado ao excluir agendamento ID: {}", id, e);
            throw e;
        }
    }

    /**
     * Registra a presença dos alunos em um agendamento.
     * Apenas pode ser executado após a data/hora do agendamento.
     *
     * @param agendamentoId ID do agendamento
     * @param presencas Mapa com o ID do aluno como chave e o status de presença como valor
     * @throws EntidadeNaoEncontradaException se o agendamento ou aluno não for encontrado
     * @throws OperacaoInvalidaException se tentar registrar presença antes da data/hora do agendamento
     */
    @Transactional
    public void registrarPresencas(Long agendamentoId, Map<Long, StatusPresenca> presencas) {
        logger.info("Tentativa de registrar presenças para agendamento ID: {}", agendamentoId);
        
        try {
            Agendamento agendamento = buscarPorId(agendamentoId);
            
            // Validar se a aula já aconteceu
            LocalDateTime agora = LocalDateTime.now();
            if (agendamento.getDataHora().isAfter(agora)) {
                throw new OperacaoInvalidaException("Não é possível registrar presença antes da data/hora da aula.");
            }
            
            // Validar se todos os alunos pertencem ao agendamento usando agendamentoAlunos diretamente
            Set<Long> alunoIdsAgendamento = agendamento.getAgendamentoAlunos().stream()
                    .map(aa -> aa.getAluno().getId())
                    .collect(Collectors.toSet());
            
            for (Long alunoId : presencas.keySet()) {
                if (!alunoIdsAgendamento.contains(alunoId)) {
                    throw new OperacaoInvalidaException("Aluno com ID " + alunoId + " não pertence a este agendamento.");
                }
            }
            
            // Atualizar presenças
            for (Map.Entry<Long, StatusPresenca> entry : presencas.entrySet()) {
                Long alunoId = entry.getKey();
                StatusPresenca status = entry.getValue();
                
                AgendamentoAluno agendamentoAluno = agendamento.getAgendamentoAlunos().stream()
                        .filter(aa -> aa.getAluno().getId().equals(alunoId))
                        .findFirst()
                        .orElseThrow(() -> new EntidadeNaoEncontradaException("Aluno não encontrado no agendamento"));
                
                agendamentoAluno.setStatusPresenca(status);
                agendamentoAlunoRepository.save(agendamentoAluno);
                logger.debug("Presença registrada: Aluno ID {} - Status {}", alunoId, status);
            }
            
            logger.info("Presenças registradas com sucesso para agendamento ID: {}", agendamentoId);
        } catch (BusinessException e) {
            logger.warn("Falha ao registrar presenças para agendamento ID {}: {}", agendamentoId, e.getMessage());
            throw e;
        } catch (Exception e) {
            logger.error("Erro inesperado ao registrar presenças para agendamento ID: {}", agendamentoId, e);
            throw e;
        }
    }

    private Agendamento buscarPorId(Long id) {
        return agendamentoRepository.findById(id)
                .orElseThrow(() -> new EntidadeNaoEncontradaException("Agendamento não encontrado"));
    }

    public AgendamentoResponseDTO toResponseDTO(Agendamento agendamento) {
        AgendamentoResponseDTO dto = new AgendamentoResponseDTO();
        dto.setId(agendamento.getId());
        dto.setDataHora(agendamento.getDataHora());
        dto.setProfessor(agendamento.getProfessor().getNome());
        dto.setSala(agendamento.getSala().getNome());
        dto.setEspecialidade(agendamento.getEspecialidade().getNome());

        // Usar agendamentoAlunos diretamente para incluir informações de presença
        Set<AlunoAgendamentoResponseDTO> alunosDTO = agendamento.getAgendamentoAlunos()
                .stream()
                .map(aa -> {
                    AlunoAgendamentoResponseDTO alunoDTO = new AlunoAgendamentoResponseDTO();
                    alunoDTO.setId(aa.getAluno().getId());
                    alunoDTO.setNome(aa.getAluno().getNome());
                    alunoDTO.setObservacao(aa.getAluno().getObservacao());
                    alunoDTO.setStatus(aa.getAluno().getStatus());
                    // Status de presença pode ser adicionado ao DTO se necessário
                    return alunoDTO;
                })
                .collect(Collectors.toSet());

        dto.setAlunos(alunosDTO);
        return dto;
    }
}