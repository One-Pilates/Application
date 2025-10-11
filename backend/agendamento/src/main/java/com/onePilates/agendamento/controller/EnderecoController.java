package com.onePilates.agendamento.controller;

import com.onePilates.agendamento.dto.EnderecoDTO;
import com.onePilates.agendamento.model.Endereco;
import com.onePilates.agendamento.service.EnderecoService;
import jakarta.validation.Valid;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/endereco")
@CrossOrigin("*")
public class EnderecoController {

    private final EnderecoService service;

    public EnderecoController(EnderecoService service) {
        this.service = service;
    }

    @GetMapping
    public ResponseEntity<List<Endereco>> verTodosOsEnderecos() {
        List<Endereco> enderecos = service.verTodosOsEnderecos();
        return ResponseEntity.ok(enderecos);
    }

    @PostMapping
    public ResponseEntity<Endereco> cadastrarEndereco(@RequestBody @Valid EnderecoDTO enderecoDTO) {
        Endereco enderecoCriado = service.cadastrarEndereco(enderecoDTO);
        return ResponseEntity.status(HttpStatus.CREATED).body(enderecoCriado);
    }
}


