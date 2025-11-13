package com.onePilates.agendamento.service;

import com.onePilates.agendamento.dto.AgendamentoDTO;
import com.onePilates.agendamento.dto.response.AgendamentoResponseDTO;
import com.onePilates.agendamento.dto.response.AlunoAgendamentoResponseDTO;
import com.onePilates.agendamento.model.*;
import com.onePilates.agendamento.observer.AgendamentoNotifier;
import com.onePilates.agendamento.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.*;
import java.util.stream.Collectors;

@Service
public class AgendamentoService {

    @Autowired
    private AgendamentoRepository agendamentoRepository;

    @Autowired
    private ProfessorRepository professorRepository;

    @Autowired
    private SalaRepository salaRepository;

    @Autowired
    private EspecialidadeRepository especialidadeRepository;

    @Autowired
    private AlunoRepository alunoRepository;

    @Autowired
    private AgendamentoNotifier notifier;

    @Transactional
    public Agendamento criarAgendamento(AgendamentoDTO dto) {
        Agendamento agendamento = mapDtoToEntity(dto);
        agendamento = agendamentoRepository.save(agendamento);

        Professor professor = professorRepository.findById(dto.getProfessorId()).get();

        if(professor.getNotificacaoAtiva() == null|| professor.getNotificacaoAtiva() == false){
            return agendamento;

        }
        notifier.notificarTodos(agendamento);

        return agendamento;
    }

    public List<AgendamentoResponseDTO> buscarAgendamentosPorIdProfessor(Long id) {
        List<Agendamento> agendamentos = agendamentoRepository.findByProfessorId(id);

        return agendamentos.stream().map(agendamento -> {
            Set<AlunoAgendamentoResponseDTO> alunosDTO = agendamento.getAlunos().stream()
                    .map(aluno -> new AlunoAgendamentoResponseDTO(
                            aluno.getId(),
                            aluno.getNome(),
                            aluno.getObservacao(),
                            aluno.getStatus()
                    ))
                    .collect(Collectors.toSet());

            return new AgendamentoResponseDTO(
                    agendamento.getId(),
                    agendamento.getDataHora(),
                    agendamento.getProfessor().getNome(),
                    agendamento.getSala().getNome(),
                    agendamento.getEspecialidade().getNome(),
                    alunosDTO
            );
        }).collect(Collectors.toList());
    }


    private void validarAgendamento(AgendamentoDTO dto){
        LocalDateTime dataHora = dto.getDataHora();

        Sala sala = salaRepository.findById(dto.getSalaId())
                .orElseThrow(() -> new RuntimeException("Sala não encontrada"));

        Professor professor = professorRepository.findById(dto.getProfessorId())
                .orElseThrow(() -> new RuntimeException("Professor não encontrado"));

        if (agendamentoRepository.existsBySalaIdAndDataHora(dto.getSalaId(), dataHora)) {
            throw new RuntimeException("Sala indisponível para o horário agendado.");
        }

        if (agendamentoRepository.existsByProfessorIdAndDataHora(dto.getProfessorId(), dataHora)) {
            throw new RuntimeException("Professor indisponível para o horário agendado.");
        }

        List<String> nomesIndisponiveis = new ArrayList<>();

        for (Long alunoId : dto.getAlunoIds()) {
            Aluno aluno = alunoRepository.findById(alunoId)
                    .orElseThrow(() -> new RuntimeException("Aluno não encontrado: " + alunoId));

            List<Agendamento> agendamentos = agendamentoRepository.findAgendamentosByAlunoAndDataHora(aluno, dataHora);
            if (!agendamentos.isEmpty()) {
                nomesIndisponiveis.add(aluno.getNome());
            }
        }

        if (!nomesIndisponiveis.isEmpty()) {
            throw new RuntimeException("Alunos indisponíveis para o horário: " + String.join(", ", nomesIndisponiveis));
        }

    }


    private Agendamento mapDtoToEntity(AgendamentoDTO dto) {
        if (dto.getAlunoIds().size() > 5) {
            throw new RuntimeException("Máximo de 5 alunos por agendamento.");
        }

        validarAgendamento(dto);

        Agendamento agendamento = new Agendamento();
        agendamento.setDataHora(dto.getDataHora());

        agendamento.setProfessor(professorRepository.findById(dto.getProfessorId())
                .orElseThrow(() -> new RuntimeException("Professor não encontrado")));

        agendamento.setSala(salaRepository.findById(dto.getSalaId())
                .orElseThrow(() -> new RuntimeException("Sala não encontrada")));

        agendamento.setEspecialidade(especialidadeRepository.findById(dto.getEspecialidadeId())
                .orElseThrow(() -> new RuntimeException("Especialidade não encontrada")));

        Set<Aluno> alunos = dto.getAlunoIds().stream()
                .map(id -> alunoRepository.findById(id)
                        .orElseThrow(() -> new RuntimeException("Aluno não encontrado: " + id)))
                .collect(Collectors.toSet());

        agendamento.setAlunos(alunos);

        return agendamento;
    }

    public List<AgendamentoResponseDTO> listarTodosDTO() {
        return agendamentoRepository.findAll()
                .stream()
                .map(this::toResponseDTO)
                .collect(Collectors.toList());
    }

    public AgendamentoResponseDTO buscarPorIdDTO(Long id) {
        return toResponseDTO(buscarPorId(id));
    }

    public AgendamentoResponseDTO atualizarAgendamento(Long agendamentoId, AgendamentoDTO dto) {
        Agendamento agendamento = buscarPorId(agendamentoId);
        if (dto.getDataHora() != null) agendamento.setDataHora(dto.getDataHora());
        if (dto.getProfessorId() != null) {
            Professor professor = professorRepository.findById(dto.getProfessorId())
                    .orElseThrow(() -> new RuntimeException("Professor não encontrado"));
            agendamento.setProfessor(professor);
        }
        if (dto.getSalaId() != null) {
            Sala sala = salaRepository.findById(dto.getSalaId())
                    .orElseThrow(() -> new RuntimeException("Sala não encontrada"));
            agendamento.setSala(sala);
        }
        if (dto.getEspecialidadeId() != null) {
            Especialidade especialidade = especialidadeRepository.findById(dto.getEspecialidadeId())
                    .orElseThrow(() -> new RuntimeException("Especialidade não encontrada"));
            agendamento.setEspecialidade(especialidade);
        }
        if (dto.getAlunoIds() != null) {
            Set<Aluno> alunos = dto.getAlunoIds().stream()
                    .map(id -> alunoRepository.findById(id).orElseThrow(() -> new RuntimeException("Aluno não encontrado: " + id)))
                    .collect(Collectors.toSet());
            agendamento.setAlunos(alunos);
        }
        return toResponseDTO(agendamentoRepository.save(agendamento));
    }

    public void excluirAgendamento(Long id) {
        agendamentoRepository.deleteById(id);
    }

    private Agendamento buscarPorId(Long id) {
        return agendamentoRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Agendamento não encontrado"));
    }

    public AgendamentoResponseDTO toResponseDTO(Agendamento agendamento) {
        AgendamentoResponseDTO dto = new AgendamentoResponseDTO();
        dto.setId(agendamento.getId());
        dto.setDataHora(agendamento.getDataHora());
        dto.setProfessor(agendamento.getProfessor().getNome());
        dto.setSala(agendamento.getSala().getNome());
        dto.setEspecialidade(agendamento.getEspecialidade().getNome());

        Set<AlunoAgendamentoResponseDTO> alunosDTO = agendamento.getAlunos()
                .stream()
                .map(aluno -> {
                    AlunoAgendamentoResponseDTO alunoDTO = new AlunoAgendamentoResponseDTO();
                    alunoDTO.setId(aluno.getId());
                    alunoDTO.setNome(aluno.getNome());
                    return alunoDTO;
                })
                .collect(Collectors.toSet());

        dto.setAlunos(alunosDTO);
        return dto;
    }
}