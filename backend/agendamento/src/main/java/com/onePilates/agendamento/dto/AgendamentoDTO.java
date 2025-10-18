package com.onePilates.agendamento.dto;

import java.time.LocalDateTime;
import java.util.Set;

public class AgendamentoDTO {
    private LocalDateTime dataHora;
    private Long professorId;
    private Long salaId;
    private Long especialidadeId;
    private Set<Long> alunoIds;

    public LocalDateTime getDataHora() {
        return dataHora;
    }

    public void setDataHora(LocalDateTime dataHora) {
        this.dataHora = dataHora;
    }

    public Long getProfessorId() {
        return professorId;
    }

    public void setProfessorId(Long professorId) {
        this.professorId = professorId;
    }

    public Long getSalaId() {
        return salaId;
    }

    public void setSalaId(Long salaId) {
        this.salaId = salaId;
    }

    public Long getEspecialidadeId() {
        return especialidadeId;
    }

    public void setEspecialidadeId(Long especialidadeId) {
        this.especialidadeId = especialidadeId;
    }

    public Set<Long> getAlunoIds() {
        return alunoIds;
    }

    public void setAlunoIds(Set<Long> alunoIds) {
        this.alunoIds = alunoIds;
    }
}
