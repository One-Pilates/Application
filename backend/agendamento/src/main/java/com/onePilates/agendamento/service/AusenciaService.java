package com.onePilates.agendamento.service;

import com.onePilates.agendamento.dto.AusenciaDTO;
import com.onePilates.agendamento.dto.response.AusenciaResponseDTO;
import com.onePilates.agendamento.model.Ausencia;
import com.onePilates.agendamento.model.Professor;
import com.onePilates.agendamento.repository.AusenciaRepository;
import com.onePilates.agendamento.repository.ProfessorRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.*;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class AusenciaService {

    @Autowired
    private AusenciaRepository ausenciaRepository;

    @Autowired
    private ProfessorRepository professorRepository;

    public AusenciaResponseDTO registrarAusencia(AusenciaDTO dto) {
        Professor professor = professorRepository.findById(dto.getProfessorId())
                .orElseThrow(() -> new RuntimeException("Professor não encontrado"));

        Ausencia ausencia = new Ausencia();
        ausencia.setProfessor(professor);
        ausencia.setDataInicio(dto.getDataInicio());
        ausencia.setDataFim(dto.getDataFim());
        ausencia.setDiaSemanaInicio(dto.getDiaSemanaInicio());
        ausencia.setDiaSemanaFim(dto.getDiaSemanaFim());
        ausencia.setMotivo(dto.getMotivo());

        ausenciaRepository.save(ausencia);

        return toResponseDTO(ausencia);
    }

    public List<AusenciaResponseDTO> listarPorProfessor(Long professorId) {
        return ausenciaRepository.findByProfessorId(professorId).stream()
                .map(this::toResponseDTO)
                .collect(Collectors.toList());
    }

    private AusenciaResponseDTO toResponseDTO(Ausencia ausencia) {
        AusenciaResponseDTO dto = new AusenciaResponseDTO();
        dto.setId(ausencia.getId());
        dto.setNomeProfessor(ausencia.getProfessor().getNome());
        dto.setDataInicio(ausencia.getDataInicio());
        dto.setDataFim(ausencia.getDataFim());
        dto.setDiaSemanaInicio(ausencia.getDiaSemanaInicio());
        dto.setDiaSemanaFim(ausencia.getDiaSemanaFim());
        dto.setMotivo(ausencia.getMotivo());
        return dto;
    }

    public void deletarAusencia(Integer id) {
        Ausencia ausencia = ausenciaRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Ausência não encontrada"));
        ausenciaRepository.delete(ausencia);
    }


}
