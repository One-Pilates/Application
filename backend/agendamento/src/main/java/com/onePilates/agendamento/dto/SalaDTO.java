package com.onePilates.agendamento.dto;

import java.util.Set;

public class SalaDTO {
    private String nome;
    private Set<Long> especialidadeIds;
    private Integer quantidadeMaximaAlunos;
    private Integer quantidadeEquipamentosPCD;

    public SalaDTO(String nome, Set<Long> especialidadeIds) {
        this.nome = nome;
        this.especialidadeIds = especialidadeIds;
    }

    public SalaDTO() {
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public Set<Long> getEspecialidadeIds() {
        return especialidadeIds;
    }

    public void setEspecialidadeIds(Set<Long> especialidadeIds) {
        this.especialidadeIds = especialidadeIds;
    }

    public Integer getQuantidadeMaximaAlunos() {
        return quantidadeMaximaAlunos;
    }

    public void setQuantidadeMaximaAlunos(Integer quantidadeMaximaAlunos) {
        this.quantidadeMaximaAlunos = quantidadeMaximaAlunos;
    }

    public Integer getQuantidadeEquipamentosPCD() {
        return quantidadeEquipamentosPCD;
    }

    public void setQuantidadeEquipamentosPCD(Integer quantidadeEquipamentosPCD) {
        this.quantidadeEquipamentosPCD = quantidadeEquipamentosPCD;
    }
}
