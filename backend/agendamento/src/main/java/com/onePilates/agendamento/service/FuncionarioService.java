package com.onePilates.agendamento.service;

import com.onePilates.agendamento.dto.LoginRequestDTO;
import com.onePilates.agendamento.model.Funcionario;
import com.onePilates.agendamento.model.Professor;
import com.onePilates.agendamento.model.Secretaria;
import com.onePilates.agendamento.repository.FuncionarioRepository;
import com.onePilates.agendamento.repository.ProfessorRepository;
import com.onePilates.agendamento.repository.SecretariaRepository;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

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




   public Funcionario login(LoginRequestDTO dados){
        Funcionario  funcionario =funcionarioRepository.findByEmailAndSenha(dados.getEmail(), dados.getSenha());
        return funcionario;
   }


}

