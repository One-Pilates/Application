package com.onePilates.agendamento.dto;

import java.time.LocalDate;

public class AlunoDTO {
    private String nome;
    private String email;
    private String cpf;
    private LocalDate dataNascimento;
    private Boolean status;
    private Boolean alunoComLimitacoesFisicas;
    private String tipoContato;
    private Boolean notificacaoAtiva;
    private EnderecoDTO endereco;

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getCpf() {
        return cpf;
    }

    public void setCpf(String cpf) {
        this.cpf = cpf;
    }

    public LocalDate getDataNascimento() {
        return dataNascimento;
    }

    public void setDataNascimento(LocalDate dataNascimento) {
        this.dataNascimento = dataNascimento;
    }

    public Boolean getStatus() {
        return status;
    }

    public void setStatus(Boolean status) {
        this.status = status;
    }

    public Boolean getAlunoComLimitacoesFisicas() {
        return alunoComLimitacoesFisicas;
    }

    public void setAlunoComLimitacoesFisicas(Boolean alunoComLimitacoesFisicas) {
        this.alunoComLimitacoesFisicas = alunoComLimitacoesFisicas;
    }

    public String getTipoContato() {
        return tipoContato;
    }

    public void setTipoContato(String tipoContato) {
        this.tipoContato = tipoContato;
    }

    public Boolean getNotificacaoAtiva() {
        return notificacaoAtiva;
    }

    public void setNotificacaoAtiva(Boolean notificacaoAtiva) {
        this.notificacaoAtiva = notificacaoAtiva;
    }

    public EnderecoDTO getEndereco() {
        return endereco;
    }

    public void setEndereco(EnderecoDTO endereco) {
        this.endereco = endereco;
    }
}