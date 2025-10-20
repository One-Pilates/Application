package com.onePilates.agendamento.dto.response;

import com.onePilates.agendamento.model.Endereco;
import com.onePilates.agendamento.model.Role;

import java.time.LocalDate;

public class LoginResponseDTO {

    private String token;
    private String role;

    private Long id;
    private String nome;
    private String email;
    private String cpf;
    private LocalDate dataNascimento;
    private Boolean status;
    private String foto;
    private String observacoes;
    private Boolean notificacaoAtiva;
    private String cargo;
    private Endereco endereco;

    public LoginResponseDTO() {}

    public LoginResponseDTO(String token, String role, com.onePilates.agendamento.model.Funcionario funcionario) {
        this.token = token;
        this.role = role;
        this.id = funcionario.getId();
        this.nome = funcionario.getNome();
        this.email = funcionario.getEmail();
        this.cpf = funcionario.getCpf();
        this.dataNascimento = funcionario.getDataNascimento();
        this.status = funcionario.getStatus();
        this.foto = funcionario.getFoto();
        this.observacoes = funcionario.getObservacoes();
        this.notificacaoAtiva = funcionario.getNotificacaoAtiva();
        this.cargo = funcionario.getCargo();
        this.endereco = funcionario.getEndereco();
    }

    // Getters e Setters

    public String getToken() { return token; }
    public void setToken(String token) { this.token = token; }

    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getNome() { return nome; }
    public void setNome(String nome) { this.nome = nome; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getCpf() { return cpf; }
    public void setCpf(String cpf) { this.cpf = cpf; }

    public LocalDate getDataNascimento() { return dataNascimento; }
    public void setDataNascimento(LocalDate dataNascimento) { this.dataNascimento = dataNascimento; }

    public Boolean getStatus() { return status; }
    public void setStatus(Boolean status) { this.status = status; }

    public String getFoto() { return foto; }
    public void setFoto(String foto) { this.foto = foto; }

    public String getObservacoes() { return observacoes; }
    public void setObservacoes(String observacoes) { this.observacoes = observacoes; }

    public Boolean getNotificacaoAtiva() { return notificacaoAtiva; }
    public void setNotificacaoAtiva(Boolean notificacaoAtiva) { this.notificacaoAtiva = notificacaoAtiva; }

    public String getCargo() { return cargo; }
    public void setCargo(String cargo) { this.cargo = cargo; }

    public Endereco getEndereco() { return endereco; }
    public void setEndereco(Endereco endereco) { this.endereco = endereco; }
}
