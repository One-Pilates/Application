package com.onePilates.agendamento.controller;

import com.onePilates.agendamento.dto.SalaDTO;
import com.onePilates.agendamento.dto.response.SalaResponseDTO;
import com.onePilates.agendamento.service.SalaService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/salas")
public class SalaController {

    @Autowired
    private SalaService salaService;

    @PostMapping
    public ResponseEntity<SalaResponseDTO> criarSala(@RequestBody SalaDTO dto) {
        SalaResponseDTO response = salaService.toResponseDTO(salaService.criarSala(dto));
        return ResponseEntity.ok(response);
    }

    @GetMapping
    public ResponseEntity<List<SalaResponseDTO>> listarSalas() {
        return ResponseEntity.ok(salaService.listarTodasDTO());
    }

    @GetMapping("/{id}")
    public ResponseEntity<SalaResponseDTO> buscarPorId(@PathVariable Long id) {
        return ResponseEntity.ok(salaService.buscarPorIdDTO(id));
    }

    @PutMapping("/{id}")
    public ResponseEntity<SalaResponseDTO> atualizarSala(@PathVariable Long id, @RequestBody SalaDTO dto) {
        return ResponseEntity.ok(salaService.atualizarSala(id, dto));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> excluirSala(@PathVariable Long id) {
        salaService.excluirSala(id);
        return ResponseEntity.noContent().build();
    }
}