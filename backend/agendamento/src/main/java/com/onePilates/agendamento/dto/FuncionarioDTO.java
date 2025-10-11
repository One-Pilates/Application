package com.onePilates.agendamento.dto;

import com.onePilates.agendamento.model.Endereco;
import jakarta.persistence.*;
import jakarta.validation.constraints.NotBlank;

import java.time.LocalDate;

public class FuncionarioDTO {


    @NotBlank(message = "O campo nome não pode estar em branco")
    private String nome;
    @NotBlank(message = "O campo email não pode estar em branco")
    private String email;
    @NotBlank(message = "O campo cpf não pode estar em branco")
    private String cpf;
    @NotBlank(message = "O campo idade não pode estar em branco")
    private LocalDate idade;
    @NotBlank(message = "O campo status não pode estar em branco")
    private Boolean status;
    private String foto;
    private String observacoes;
    @NotBlank(message = "O campo notificacaoAtiva não pode estar em branco")
    private Boolean notificacaoAtiva;
    @NotBlank(message = "O campo senha não pode estar em branco")
    private String senha;

    private Endereco endereco;

    public FuncionarioDTO(String nome, String email, String cpf, LocalDate idade, Boolean status, String foto, String observacoes, Boolean notificacaoAtiva, String senha, Endereco endereco) {
        this.nome = nome;
        this.email = email;
        this.cpf = cpf;
        this.idade = idade;
        this.status = status;
        this.foto = foto;
        this.observacoes = observacoes;
        this.notificacaoAtiva = notificacaoAtiva;
        this.senha = senha;
        this.endereco = endereco;
    }

    public FuncionarioDTO() {
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

    public LocalDate getIdade() {
        return idade;
    }

    public void setIdade(LocalDate idade) {
        this.idade = idade;
    }

    public Boolean getStatus() {
        return status;
    }

    public void setStatus(Boolean status) {
        this.status = status;
    }

    public String getFoto() {
        return foto;
    }

    public void setFoto(String foto) {
        this.foto = foto;
    }

    public String getObservacoes() {
        return observacoes;
    }

    public void setObservacoes(String observacoes) {
        this.observacoes = observacoes;
    }

    public Boolean getNotificacaoAtiva() {
        return notificacaoAtiva;
    }

    public void setNotificacaoAtiva(Boolean notificacaoAtiva) {
        this.notificacaoAtiva = notificacaoAtiva;
    }

    public String getSenha() {
        return senha;
    }

    public void setSenha(String senha) {
        this.senha = senha;
    }

    public Endereco getEndereco() {
        return endereco;
    }

    public void setEndereco(Endereco endereco) {
        this.endereco = endereco;
    }
}
