package com.onePilates.agendamento.dto;

import java.util.List;

public class RespostaDashProfessoraDTO {

    private List<AgendamentoPorDiaDTO> agendamentosPorDiasDTO;
    private List<AulaPorEspecialidadeDTO> aulasPorEspecialidadesDTO;

    public RespostaDashProfessoraDTO() {

    }

    public RespostaDashProfessoraDTO(List<AgendamentoPorDiaDTO> agendamentosPorDiasDTO, List<AulaPorEspecialidadeDTO> aulasPorEspecialidadesDTO) {
        this.agendamentosPorDiasDTO = agendamentosPorDiasDTO;
        this.aulasPorEspecialidadesDTO = aulasPorEspecialidadesDTO;
    }

    public List<AgendamentoPorDiaDTO> getAgendamentosPorDiasDTO() {
        return agendamentosPorDiasDTO;
    }

    public void setAgendamentosPorDiasDTO(List<AgendamentoPorDiaDTO> agendamentosPorDiasDTO) {
        this.agendamentosPorDiasDTO = agendamentosPorDiasDTO;
    }

    public List<AulaPorEspecialidadeDTO> getAulasPorEspecialidadesDTO() {
        return aulasPorEspecialidadesDTO;
    }

    public void setAulasPorEspecialidadesDTO(List<AulaPorEspecialidadeDTO> aulasPorEspecialidadesDTO) {
        this.aulasPorEspecialidadesDTO = aulasPorEspecialidadesDTO;
    }
}
