package com.onePilates.agendamento.model;


import jakarta.persistence.*;

import java.time.LocalDate;
import java.util.List;

@Entity
@Inheritance(strategy = InheritanceType.JOINED)
public abstract class Funcionario {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String nome;
    @Column(unique = true)
    private String email;
    @Column(unique = true)
    private String cpf;
    private LocalDate idade;
    private Boolean status;
    private String foto;
    private String observacoes;
    private Boolean notificacaoAtiva;
    private String senha;
    private String cargo;
    @OneToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "endereco_id")
    private Endereco endereco;

    public Funcionario() {
    }

    public Funcionario(String nome, String email, String cpf, LocalDate idade, Boolean status, String foto, String observacoes, Boolean notificacaoAtiva, String senha, String cargo, Endereco endereco) {
        this.nome = nome;
        this.email = email;
        this.cpf = cpf;
        this.idade = idade;
        this.status = status;
        this.foto = foto;
        this.observacoes = observacoes;
        this.notificacaoAtiva = notificacaoAtiva;
        this.senha = senha;
        this.cargo = cargo;
        this.endereco = endereco;
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

    public String getCargo() {
        return cargo;
    }

    public void setCargo(String cargo) {
        this.cargo = cargo;
    }

    public Endereco getEndereco() {
        return endereco;
    }

    public void setEndereco(Endereco endereco) {
        this.endereco = endereco;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }
}
