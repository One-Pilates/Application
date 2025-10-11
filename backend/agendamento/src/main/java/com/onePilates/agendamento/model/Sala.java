package com.onePilates.agendamento.model;

import com.onePilates.agendamento.model.Especialidade;
import jakarta.persistence.*;
import java.util.HashSet;
import java.util.Set;

@Entity
public class Sala {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String nome;

    @ManyToMany
    @JoinTable(
            name = "sala_especialidade",
            joinColumns = @JoinColumn(name = "sala_id"),
            inverseJoinColumns = @JoinColumn(name = "especialidade_id")
    )
    private Set<Especialidade> especialidades = new HashSet<>();
}
