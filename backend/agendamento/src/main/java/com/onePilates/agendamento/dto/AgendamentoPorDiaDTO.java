package com.onePilates.agendamento.dto;

public class AgendamentoPorDiaDTO {
    private String diaSemana;
    private Long totalAgendamentos;

    public AgendamentoPorDiaDTO(String diaSemana, Long totalAgendamentos) {
        this.diaSemana = diaSemana;
        this.totalAgendamentos = totalAgendamentos;
    }

    public String getDiaSemana() {
        return diaSemana;
    }

    public Long getTotalAgendamentos() {
        return totalAgendamentos;
    }
}

