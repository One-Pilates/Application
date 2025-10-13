package com.onePilates.agendamento.model;

import jakarta.persistence.*;
import java.time.LocalDate;

@Entity
public class Aluno {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String nome;

    @Column(unique = true)
    private String email;

    @Column(unique = true)
    private String cpf;

    private LocalDate dataNascimento;

    private Boolean status;

    private Boolean alunoComLimitacoesFisicas;

    private String tipoContato;

    private Boolean notificacaoAtiva;

    @OneToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "endereco_id")
    private Endereco endereco;

    public Aluno(Long id, String nome, String email, String cpf, LocalDate dataNascimento, Boolean status, Boolean alunoComLimitacoesFisicas, String tipoContato, Boolean notificacaoAtiva, Endereco endereco) {
        this.id = id;
        this.nome = nome;
        this.email = email;
        this.cpf = cpf;
        this.dataNascimento = dataNascimento;
        this.status = status;
        this.alunoComLimitacoesFisicas = alunoComLimitacoesFisicas;
        this.tipoContato = tipoContato;
        this.notificacaoAtiva = notificacaoAtiva;
        this.endereco = endereco;
    }

    public Aluno() {
    }

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

    public Endereco getEndereco() {
        return endereco;
    }

    public void setEndereco(Endereco endereco) {
        this.endereco = endereco;
    }
}