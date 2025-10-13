package com.onePilates.agendamento.dto.response;

import java.time.LocalDate;

public class AlunoResponseDTO {
    private Long id;
    private String nome;
    private String email;
    private String cpf;
    private LocalDate dataNascimento;
    private Boolean status;
    private Boolean alunoComLimitacoesFisicas;
    private String tipoContato;
    private Boolean notificacaoAtiva;
    private EnderecoResponseDTO endereco;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

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

    public EnderecoResponseDTO getEndereco() {
        return endereco;
    }

    public void setEndereco(EnderecoResponseDTO endereco) {
        this.endereco = endereco;
    }
}
