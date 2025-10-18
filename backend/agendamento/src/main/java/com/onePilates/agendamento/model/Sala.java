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

    @Column(nullable = false)
    private Integer quantidadeMaximaAlunos;

    @Column(nullable = false)
    private Integer quantidadeEquipamentosPCD;

    @ManyToMany
    @JoinTable(
            name = "sala_especialidade",
            joinColumns = @JoinColumn(name = "sala_id"),
            inverseJoinColumns = @JoinColumn(name = "especialidade_id")
    )
    private Set<Especialidade> especialidades = new HashSet<>();

    public Sala(Long id, String nome, Integer quantidadeMaximaAlunos, Integer quantidadeEquipamentosPCD, Set<Especialidade> especialidades) {
        this.id = id;
        this.nome = nome;
        this.quantidadeMaximaAlunos = quantidadeMaximaAlunos;
        this.quantidadeEquipamentosPCD = quantidadeEquipamentosPCD;
        this.especialidades = especialidades;
    }

    public Sala() {
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

    public Set<Especialidade> getEspecialidades() {
        return especialidades;
    }

    public void setEspecialidades(Set<Especialidade> especialidades) {
        this.especialidades = especialidades;
    }

    public Integer getQuantidadeMaximaAlunos() {
        return quantidadeMaximaAlunos;
    }

    public void setQuantidadeMaximaAlunos(Integer quantidadeMaximaAlunos) {
        this.quantidadeMaximaAlunos = quantidadeMaximaAlunos;
    }

    public Integer getQuantidadeEquipamentosPCD() {
        return quantidadeEquipamentosPCD;
    }

    public void setQuantidadeEquipamentosPCD(Integer quantidadeEquipamentosPCD) {
        this.quantidadeEquipamentosPCD = quantidadeEquipamentosPCD;
    }
}
