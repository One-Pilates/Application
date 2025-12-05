package com.onePilates.agendamento.dto.response;

import com.onePilates.agendamento.dto.AgendamentoPorDiaDTO;
import com.onePilates.agendamento.dto.AulaPorEspecialidadeDTO;
import com.onePilates.agendamento.dto.KPIsProfessorDTO;

import java.util.List;

public class RespostaDashProfessoraDTO {

    private List<AgendamentoPorDiaDTO> agendamentosPorDiasDTO;
    private List<AulaPorEspecialidadeDTO> aulasPorEspecialidadesDTO;
    private KPIsProfessorDTO kpisProfessorDTO;

    public RespostaDashProfessoraDTO() {

    }

    public RespostaDashProfessoraDTO(List<AgendamentoPorDiaDTO> agendamentosPorDiasDTO, List<AulaPorEspecialidadeDTO> aulasPorEspecialidadesDTO, KPIsProfessorDTO kpisProfessorDTO) {
        this.agendamentosPorDiasDTO = agendamentosPorDiasDTO;
        this.aulasPorEspecialidadesDTO = aulasPorEspecialidadesDTO;
        this.kpisProfessorDTO = kpisProfessorDTO;
    }

    public List<AgendamentoPorDiaDTO> getAgendamentosPorDiasDTO() {
        return agendamentosPorDiasDTO;
    }

    public void setAgendamentosPorDiasDTO(List<AgendamentoPorDiaDTO> agendamentosPorDiasDTO) {
        this.agendamentosPorDiasDTO = agendamentosPorDiasDTO;
    }

    public KPIsProfessorDTO getKpisProfessorDTO() {
        return kpisProfessorDTO;
    }

    public void setKpisProfessorDTO(KPIsProfessorDTO kpisProfessorDTO) {
        this.kpisProfessorDTO = kpisProfessorDTO;
    }

    public List<AulaPorEspecialidadeDTO> getAulasPorEspecialidadesDTO() {
        return aulasPorEspecialidadesDTO;
    }

    public void setAulasPorEspecialidadesDTO(List<AulaPorEspecialidadeDTO> aulasPorEspecialidadesDTO) {
        this.aulasPorEspecialidadesDTO = aulasPorEspecialidadesDTO;
    }
}
