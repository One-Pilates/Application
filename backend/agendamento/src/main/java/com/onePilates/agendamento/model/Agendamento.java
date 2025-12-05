package com.onePilates.agendamento.model;

import jakarta.persistence.*;
import java.time.LocalDateTime;
import java.util.HashSet;
import java.util.Set;
import java.util.stream.Collectors;

@Entity
public class Agendamento {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private LocalDateTime dataHora;

    @ManyToOne
    private Professor professor;

    @ManyToOne
    private Sala sala;

    @ManyToOne
    private Especialidade especialidade;

    @OneToMany(mappedBy = "agendamento", cascade = CascadeType.ALL, orphanRemoval = true, fetch = FetchType.LAZY)
    private Set<AgendamentoAluno> agendamentoAlunos = new HashSet<>();


    public Agendamento() {
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public LocalDateTime getDataHora() {
        return dataHora;
    }

    public void setDataHora(LocalDateTime dataHora) {
        this.dataHora = dataHora;
    }

    public Professor getProfessor() {
        return professor;
    }

    public void setProfessor(Professor professor) {
        this.professor = professor;
    }

    public Sala getSala() {
        return sala;
    }

    public void setSala(Sala sala) {
        this.sala = sala;
    }

    public Especialidade getEspecialidade() {
        return especialidade;
    }

    public void setEspecialidade(Especialidade especialidade) {
        this.especialidade = especialidade;
    }

    public Set<AgendamentoAluno> getAgendamentoAlunos() {
        return agendamentoAlunos;
    }

    public void setAgendamentoAlunos(Set<AgendamentoAluno> agendamentoAlunos) {
        this.agendamentoAlunos = agendamentoAlunos;
    }

    // Método auxiliar para obter alunos diretamente (para compatibilidade)
    public Set<Aluno> getAlunos() {
        if (agendamentoAlunos == null) {
            return Set.of();
        }
        return agendamentoAlunos.stream()
                .map(AgendamentoAluno::getAluno)
                .collect(Collectors.toSet());
    }
}
