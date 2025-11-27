package com.onePilates.agendamento.dto.response;

import com.onePilates.agendamento.dto.AgendamentoPorDiaDTO;
import com.onePilates.agendamento.dto.AgendamentosPorProfessorDTO;

import java.util.List;

public class ResponsDashSecretariaAdmDTO {

    private List<AgendamentoPorDiaDTO> agendamentosPorDias;
    private List<AgendamentosPorProfessorDTO> qtdSessoesPorProfessor;


    public ResponsDashSecretariaAdmDTO() {
    }

    public List<AgendamentoPorDiaDTO> getAgendamentosPorDias() {
        return agendamentosPorDias;
    }

    public void setAgendamentosPorDias(List<AgendamentoPorDiaDTO> agendamentosPorDias) {
        this.agendamentosPorDias = agendamentosPorDias;
    }

    public List<AgendamentosPorProfessorDTO> getQtdSessoesPorProfessor() {
        return qtdSessoesPorProfessor;
    }

    public void setQtdSessoesPorProfessor(List<AgendamentosPorProfessorDTO> qtdSessoesPorProfessor) {
        this.qtdSessoesPorProfessor = qtdSessoesPorProfessor;
    }

}
