package com.onePilates.agendamento.service;

import com.onePilates.agendamento.model.Funcionario;
import com.onePilates.agendamento.repository.FuncionarioRepository;
import com.onePilates.agendamento.repository.ProfessorRepository;
import com.onePilates.agendamento.repository.SecretariaRepository;
import org.springframework.stereotype.Service;

@Service
public class FuncionarioService {
    private SecretariaRepository secretariaRepository;
    private ProfessorRepository professorRepository;
    private FuncionarioRepository funcionarioRepository;


    public FuncionarioService(SecretariaRepository secretariaRepository, ProfessorRepository professorRepository, FuncionarioRepository funcionarioRepository) {
        this.secretariaRepository = secretariaRepository;
        this.professorRepository = professorRepository;
        this.funcionarioRepository = funcionarioRepository;
    }



}

