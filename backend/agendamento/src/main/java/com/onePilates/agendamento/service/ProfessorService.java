package com.onePilates.agendamento.service;

import com.onePilates.agendamento.dto.EnderecoDTO;
import com.onePilates.agendamento.dto.ProfessorDTO;
import com.onePilates.agendamento.dto.response.EnderecoResponseDTO;
import com.onePilates.agendamento.dto.response.ProfessorResponseDTO;
import com.onePilates.agendamento.model.Endereco;
import com.onePilates.agendamento.model.Especialidade;
import com.onePilates.agendamento.model.Professor;
import com.onePilates.agendamento.repository.EspecialidadeRepository;
import com.onePilates.agendamento.repository.ProfessorRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;
import java.util.stream.Collectors;

@Service
public class ProfessorService {

    @Autowired
    private ProfessorRepository professorRepository;

    @Autowired
    private EspecialidadeRepository especialidadeRepository;

    public Professor criarProfessor(ProfessorDTO dto) {
        return mapDtoToEntity(dto);
    }

    public List<ProfessorResponseDTO> listarTodosDTO() {
        return professorRepository.findAll()
                .stream()
                .map(this::toResponseDTO)
                .collect(Collectors.toList());
    }

    public ProfessorResponseDTO buscarPorIdDTO(Long id) {
        return toResponseDTO(buscarPorId(id));
    }

    public ProfessorResponseDTO atualizarProfessor(Long id, ProfessorDTO dto) {
        Professor existente = buscarPorId(id);
        Professor atualizado = mapDtoToEntity(dto);
        atualizado.setId(id);
        return toResponseDTO(professorRepository.save(atualizado));
    }

    public void excluirProfessor(Long id) {
        professorRepository.deleteById(id);
    }

    private Professor buscarPorId(Long id) {
        return professorRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Professor não encontrado"));
    }

    private Professor mapDtoToEntity(ProfessorDTO dto) {
        Professor professor = new Professor();
        professor.setNome(dto.getNome());
        professor.setEmail(dto.getEmail());
        professor.setCpf(dto.getCpf());
        professor.setIdade(dto.getIdade());
        professor.setStatus(dto.getStatus());
        professor.setFoto(dto.getFoto());
        professor.setObservacoes(dto.getObservacoes());
        professor.setNotificacaoAtiva(dto.getNotificacaoAtiva());
        professor.setSenha(dto.getSenha());
        professor.setCargo(dto.getCargo());

        EnderecoDTO enderecoDTO = dto.getEndereco();
        Endereco endereco = new Endereco();
        endereco.setRua(enderecoDTO.getRua());
        endereco.setCidade(enderecoDTO.getCidade());
        endereco.setEstado(enderecoDTO.getEstado());
        endereco.setCep(enderecoDTO.getCep());
        professor.setEndereco(endereco);

        Set<Especialidade> especialidades = dto.getEspecialidadeIds().stream()
                .map(id -> especialidadeRepository.findById(id)
                        .orElseThrow(() -> new RuntimeException("Especialidade não encontrada: " + id)))
                .collect(Collectors.toSet());
        professor.setEspecialidades(especialidades);

        return professorRepository.save(professor);
    }

    public ProfessorResponseDTO toResponseDTO(Professor professor) {
        ProfessorResponseDTO dto = new ProfessorResponseDTO();
        dto.setId(professor.getId());
        dto.setNome(professor.getNome());
        dto.setEmail(professor.getEmail());
        dto.setCpf(professor.getCpf());
        dto.setIdade(professor.getIdade());
        dto.setStatus(professor.getStatus());
        dto.setFoto(professor.getFoto());
        dto.setObservacoes(professor.getObservacoes());
        dto.setNotificacaoAtiva(professor.getNotificacaoAtiva());
        dto.setCargo(professor.getCargo());

        EnderecoResponseDTO enderecoDTO = new EnderecoResponseDTO();
        enderecoDTO.setRua(professor.getEndereco().getRua());
        enderecoDTO.setCidade(professor.getEndereco().getCidade());
        enderecoDTO.setEstado(professor.getEndereco().getEstado());
        enderecoDTO.setCep(professor.getEndereco().getCep());
        dto.setEndereco(enderecoDTO);

        Set<String> nomesEspecialidades = professor.getEspecialidades()
                .stream()
                .map(Especialidade::getNome)
                .collect(Collectors.toSet());
        dto.setEspecialidades(nomesEspecialidades);

        return dto;
    }
}