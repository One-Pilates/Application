package com.onePilates.agendamento.controller;

import com.onePilates.agendamento.model.Funcionario;
import com.onePilates.agendamento.service.FuncionarioService;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/funcionarios")
public class FuncionarioController {

    private final FuncionarioService service;

    public FuncionarioController(FuncionarioService service) {
        this.service = service;
    }

}

