package com.onePilates.agendamento.model;

import jakarta.persistence.Entity;

import java.time.LocalDate;

@Entity
public class Secretaria extends Funcionario{


    public Secretaria() {
    }

    public Secretaria(String nome, String email, String cpf, LocalDate idade, Boolean status, String foto, String observacoes, Boolean notificacaoAtiva, String senha, Endereco endereco) {
        super(nome, email, cpf, idade, status, foto, observacoes, notificacaoAtiva, senha, endereco);
    }
}
