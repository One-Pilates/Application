package com.onePilates.agendamento.model;


import jakarta.persistence.*;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

@Entity
@Inheritance(strategy = InheritanceType.JOINED)
public abstract class Funcionario {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String nome;

    @Column(unique = true, nullable = false)
    private String email;

    @Column(nullable = false)
    private String senha; // armazenar hash BCrypt

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private Role role;

    @Column(unique = true)
    private String cpf;
    private LocalDate dataNascimento;
    private Boolean status;
    private String foto;
    private String observacoes;
    private Boolean notificacaoAtiva;
    private String cargo;
    @OneToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "endereco_id")
    private Endereco endereco;
    private String telefone;
    private String codigoVerificacao;
    private LocalDateTime dataUltimaCriacaoCodigo;

    public Funcionario() {
    }

    public Funcionario(Long id, String nome, String email, String senha, Role role, String cpf, LocalDate dataNascimento, Boolean status, String foto, String observacoes, Boolean notificacaoAtiva, String cargo, Endereco endereco, String telefone) {
        this.id = id;
        this.nome = nome;
        this.email = email;
        this.senha = senha;
        this.role = role;
        this.cpf = cpf;
        this.dataNascimento = dataNascimento;
        this.status = status;
        this.foto = foto;
        this.observacoes = observacoes;
        this.notificacaoAtiva = notificacaoAtiva;
        this.cargo = cargo;
        this.endereco = endereco;
        this.telefone = telefone;
    }

    public Funcionario(Long id, String nome, String email, String senha, Role role, String cpf, LocalDate dataNascimento, Boolean status, String foto, String observacoes, Boolean notificacaoAtiva, String cargo, Endereco endereco, String telefone, String codigoVerificacao, LocalDateTime dataUltimaCriacaoCodigo) {
        this.id = id;
        this.nome = nome;
        this.email = email;
        this.senha = senha;
        this.role = role;
        this.cpf = cpf;
        this.dataNascimento = dataNascimento;
        this.status = status;
        this.foto = foto;
        this.observacoes = observacoes;
        this.notificacaoAtiva = notificacaoAtiva;
        this.cargo = cargo;
        this.endereco = endereco;
        this.telefone = telefone;
        this.codigoVerificacao = codigoVerificacao;
        this.dataUltimaCriacaoCodigo = dataUltimaCriacaoCodigo;
    }

    public Long getId() {
        return id;
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

    public String getSenha() {
        return senha;
    }

    public void setSenha(String senha) {
        this.senha = senha;
    }

    public Role getRole() {
        return role;
    }

    public void setRole(Role role) {
        this.role = role;
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

    public String getFoto() {
        return foto;
    }

    public void setFoto(String foto) {
        this.foto = foto;
    }

    public String getCodigoVerificacao() {
        return codigoVerificacao;
    }

    public void setCodigoVerificacao(String codigoVerificacao) {
        this.codigoVerificacao = codigoVerificacao;
    }

    public LocalDateTime getDataUltimaCriacaoCodigo() {
        return dataUltimaCriacaoCodigo;
    }

    public void setDataUltimaCriacaoCodigo(LocalDateTime dataUltimaCriacaoCodigo) {
        this.dataUltimaCriacaoCodigo = dataUltimaCriacaoCodigo;
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

    public String getTelefone() {
        return telefone;
    }

    public void setTelefone(String telefone) {
        this.telefone = telefone;
    }
}
