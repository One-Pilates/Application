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
}
