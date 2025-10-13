package com.onePilates.agendamento.controller;

import com.onePilates.agendamento.dto.LoginRequestDTO;
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



    @PostMapping("/login")
    public Funcionario login(@RequestBody LoginRequestDTO dados){
        return service.login(dados);
    }
}

