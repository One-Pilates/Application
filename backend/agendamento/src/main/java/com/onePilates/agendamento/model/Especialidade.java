package com.onePilates.agendamento.model;

import jakarta.persistence.*;
import java.util.HashSet;
import java.util.Set;

@Entity
public class Especialidade {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String nome;

    @ManyToMany(mappedBy = "especialidades")
    private Set<Professor> professores = new HashSet<>();

    @ManyToMany(mappedBy = "especialidades")
    private Set<Sala> salas = new HashSet<>();

    public Especialidade() {
    }

    public Especialidade(Long id, String nome, Set<Professor> professores, Set<Sala> salas) {
        this.id = id;
        this.nome = nome;
        this.professores = professores;
        this.salas = salas;
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

    public Set<Professor> getProfessores() {
        return professores;
    }

    public void setProfessores(Set<Professor> professores) {
        this.professores = professores;
    }

    public Set<Sala> getSalas() {
        return salas;
    }

    public void setSalas(Set<Sala> salas) {
        this.salas = salas;
    }
}
