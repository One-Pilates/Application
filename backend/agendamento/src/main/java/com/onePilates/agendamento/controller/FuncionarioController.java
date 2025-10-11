package com.onePilates.agendamento.controller;

import com.onePilates.agendamento.model.Funcionario;
import com.onePilates.agendamento.model.Professor;
import com.onePilates.agendamento.model.Secretaria;
import com.onePilates.agendamento.service.FuncionarioService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.net.URI;
import java.util.List;

@RestController
@RequestMapping("/funcionarios")
public class FuncionarioController {

    private final FuncionarioService service;

    public FuncionarioController(FuncionarioService service) {
        this.service = service;
    }

    @PostMapping("/secretaria")
    public Secretaria criarFuncionario(@RequestBody Secretaria secretaria) {
        return  service.criarFuncionario(secretaria);

    }

    @PostMapping("/professor")
    public Professor criarFuncionario(@RequestBody Professor professor) {
        return  service.criarProfessor(professor);

    }
    @GetMapping
    public List<Professor> buscarProfessoresCadastrados(){
        return service.buscarProfessores();
    }
}

