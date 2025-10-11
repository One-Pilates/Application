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

    public Secretaria criarFuncionario(Secretaria secretaria) {

        Secretaria novaSecretaria = new Secretaria(
                secretaria.getNome(),
                secretaria.getEmail(),
                secretaria.getCpf(),
                secretaria.getIdade(),
                secretaria.getStatus(),
                secretaria.getFoto(),
                secretaria.getObservacoes(),
                secretaria.getNotificacaoAtiva(),
                secretaria.getSenha(),
                secretaria.getCargo(),
                secretaria.getEndereco()
        );
       return secretariaRepository.save(novaSecretaria);
        
    }

    public Professor criarProfessor(Professor professor) {

        Professor novoProfessor = new Professor(
                professor.getNome(),
                professor.getEmail(),
                professor.getCpf(),
                professor.getIdade(),
                professor.getStatus(),
                professor.getFoto(),
                professor.getObservacoes(),
                professor.getNotificacaoAtiva(),
                professor.getSenha(),
                professor.getCargo(),
                professor.getEndereco(),
                professor.getEspecialidades()
        );
        return professorRepository.save(novoProfessor);

    }

    public List<Professor> buscarProfessores(){
        return professorRepository.findAll();
    }

   public Funcionario login(LoginRequestDTO dados){
        Funcionario  funcionario =funcionarioRepository.findByEmailAndSenha(dados.getEmail(), dados.getSenha());
        return funcionario;
   }


}

