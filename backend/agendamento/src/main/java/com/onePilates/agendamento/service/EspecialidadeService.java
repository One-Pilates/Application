package com.onePilates.agendamento.service;

import com.onePilates.agendamento.dto.EspecialidadeDTO;
import com.onePilates.agendamento.dto.response.EspecialidadeResponseDTO;
import com.onePilates.agendamento.model.Especialidade;
import com.onePilates.agendamento.repository.EspecialidadeRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class EspecialidadeService {

    @Autowired
    private EspecialidadeRepository especialidadeRepository;

    public Especialidade criarEspecialidade(EspecialidadeDTO dto) {
        Especialidade especialidade = new Especialidade();
        especialidade.setNome(dto.getNome());
        return especialidadeRepository.save(especialidade);
    }

    public List<EspecialidadeResponseDTO> listarTodasDTO() {
        return especialidadeRepository.findAll()
                .stream()
                .map(this::toResponseDTO)
                .collect(Collectors.toList());
    }

    public EspecialidadeResponseDTO buscarPorIdDTO(Long id) {
        return toResponseDTO(buscarPorId(id));
    }

    public EspecialidadeResponseDTO atualizarEspecialidade(Long id, EspecialidadeDTO dto) {
        Especialidade especialidade = buscarPorId(id);
        if (dto.getNome() != null) especialidade.setNome(dto.getNome());
        return toResponseDTO(especialidadeRepository.save(especialidade));
    }

    public void excluirEspecialidade(Long id) {
        especialidadeRepository.deleteById(id);
    }

    private Especialidade buscarPorId(Long id) {
        return especialidadeRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Especialidade não encontrada"));
    }

    public EspecialidadeResponseDTO toResponseDTO(Especialidade especialidade) {
        EspecialidadeResponseDTO dto = new EspecialidadeResponseDTO();
        dto.setId(especialidade.getId());
        dto.setNome(especialidade.getNome());
        return dto;
    }
}
