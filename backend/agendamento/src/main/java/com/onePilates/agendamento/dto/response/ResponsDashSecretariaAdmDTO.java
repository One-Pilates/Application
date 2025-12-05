package com.onePilates.agendamento.dto.response;

import com.onePilates.agendamento.dto.AgendamentoPorDiaDTO;
import com.onePilates.agendamento.dto.AgendamentosPorProfessorDTO;

import java.util.List;

public class ResponsDashSecretariaAdmDTO {

    private List<AgendamentoPorDiaDTO> agendamentosPorDias;
    private List<AgendamentosPorProfessorDTO> qtdSessoesPorProfessor;
    private Integer qtdDeAlunosAtendidos;


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

    public Integer getQtdDeAlunosAtendidos() {
        return qtdDeAlunosAtendidos;
    }

    public void setQtdDeAlunosAtendidos(Integer qtdDeAlunosAtendidos) {
        this.qtdDeAlunosAtendidos = qtdDeAlunosAtendidos;
    }
}
