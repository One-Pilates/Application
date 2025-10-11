package com.onePilates.agendamento.model;
import jakarta.persistence.Entity;
import java.time.LocalDate;
import jakarta.persistence.*;
import java.util.HashSet;
import java.util.Set;



@Entity
public class Professor extends Funcionario{

    @ManyToMany
    @JoinTable(
            name = "professor_especialidade",
            joinColumns = @JoinColumn(name = "professor_id"),
            inverseJoinColumns = @JoinColumn(name = "especialidade_id")
    )
    private Set<Especialidade> especialidades = new HashSet<>();


    public Professor() {
    }

    public Professor(String nome, String email, String cpf, LocalDate idade, Boolean status, String foto, String observacoes, Boolean notificacaoAtiva, String senha, String cargo, Endereco endereco, Set<Especialidade> especialidades) {
        super(nome, email, cpf, idade, status, foto, observacoes, notificacaoAtiva, senha, cargo, endereco);
        this.especialidades = especialidades;
    }

    public Set<Especialidade> getEspecialidades() {
        return especialidades;
    }

    public void setEspecialidades(Set<Especialidade> especialidades) {
        this.especialidades = especialidades;
    }
}
