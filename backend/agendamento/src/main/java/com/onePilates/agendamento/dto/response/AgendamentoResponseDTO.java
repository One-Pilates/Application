package com.onePilates.agendamento.dto.response;

import java.time.LocalDateTime;
import java.util.Set;

public class AgendamentoResponseDTO {
    private Long id;
    private LocalDateTime dataHora;
    private String professor;
    private String sala;
    private String especialidade;
    private Set<AlunoAgendamentoResponseDTO> alunos;


    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public LocalDateTime getDataHora() {
        return dataHora;
    }

    public void setDataHora(LocalDateTime dataHora) {
        this.dataHora = dataHora;
    }

    public String getProfessor() {
        return professor;
    }

    public void setProfessor(String professor) {
        this.professor = professor;
    }

    public String getSala() {
        return sala;
    }

    public void setSala(String sala) {
        this.sala = sala;
    }

    public String getEspecialidade() {
        return especialidade;
    }

    public void setEspecialidade(String especialidade) {
        this.especialidade = especialidade;
    }

    public Set<AlunoAgendamentoResponseDTO> getAlunos() {
        return alunos;
    }

    public void setAlunos(Set<AlunoAgendamentoResponseDTO> alunos) {
        this.alunos = alunos;
    }
}
