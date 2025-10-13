package com.onePilates.agendamento.service;

import com.onePilates.agendamento.dto.SalaDTO;
import com.onePilates.agendamento.dto.response.SalaResponseDTO;
import com.onePilates.agendamento.model.Especialidade;
import com.onePilates.agendamento.model.Sala;
import com.onePilates.agendamento.repository.EspecialidadeRepository;
import com.onePilates.agendamento.repository.SalaRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;
import java.util.stream.Collectors;

@Service
public class SalaService {

    @Autowired
    private SalaRepository salaRepository;

    @Autowired
    private EspecialidadeRepository especialidadeRepository;

    public Sala criarSala(SalaDTO dto) {
        return mapDtoToEntity(dto);
    }

    public List<SalaResponseDTO> listarTodasDTO() {
        return salaRepository.findAll()
                .stream()
                .map(this::toResponseDTO)
                .collect(Collectors.toList());
    }

    public SalaResponseDTO buscarPorIdDTO(Long id) {
        return toResponseDTO(buscarPorId(id));
    }

    public SalaResponseDTO atualizarSala(Long id, SalaDTO dto) {
        Sala atualizada = mapDtoToEntity(dto);
        atualizada.setId(id);
        return toResponseDTO(salaRepository.save(atualizada));
    }

    public void excluirSala(Long id) {
        salaRepository.deleteById(id);
    }

    private Sala buscarPorId(Long id) {
        return salaRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Sala não encontrada"));
    }

    private Sala mapDtoToEntity(SalaDTO dto) {
        Sala sala = new Sala();
        sala.setNome(dto.getNome());

        Set<Especialidade> especialidades = dto.getEspecialidadeIds().stream()
                .map(id -> especialidadeRepository.findById(id)
                        .orElseThrow(() -> new RuntimeException("Especialidade não encontrada: " + id)))
                .collect(Collectors.toSet());
        sala.setEspecialidades(especialidades);

        return salaRepository.save(sala);
    }

    public SalaResponseDTO toResponseDTO(Sala sala) {
        SalaResponseDTO dto = new SalaResponseDTO();
        dto.setId(sala.getId());
        dto.setNome(sala.getNome());
        dto.setEspecialidades(sala.getEspecialidades()
                .stream()
                .map(Especialidade::getNome)
                .collect(Collectors.toSet()));
        return dto;
    }
}