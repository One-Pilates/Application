package com.onePilates.agendamento.model;
import jakarta.persistence.Entity;
import java.time.LocalDate;

@Entity
public class Administrador extends Funcionario{
    public Administrador() {
    }

    public Administrador(String nome, String email, String cpf, LocalDate idade, Boolean status, String foto, String observacoes, Boolean notificacaoAtiva, String senha, String cargo, Endereco endereco) {
        super(nome, email, cpf, idade, status, foto, observacoes, notificacaoAtiva, senha, cargo, endereco);
    }
}
