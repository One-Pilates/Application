package com.onePilates.agendamento.controller;

import com.onePilates.agendamento.dto.AgendamentoDTO;
import com.onePilates.agendamento.dto.response.AgendamentoResponseDTO;
import com.onePilates.agendamento.service.AgendamentoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/agendamentos")
public class AgendamentoController {

    @Autowired
    private AgendamentoService agendamentoService;

    @PostMapping
    public ResponseEntity<AgendamentoResponseDTO> criarAgendamento(@RequestBody AgendamentoDTO dto) {
        return ResponseEntity.ok(agendamentoService.toResponseDTO(agendamentoService.criarAgendamento(dto)));
    }

    @GetMapping
    public ResponseEntity<List<AgendamentoResponseDTO>> listarAgendamentos() {
        return ResponseEntity.ok(agendamentoService.listarTodosDTO());
    }

    @GetMapping("/{id}")
    public ResponseEntity<AgendamentoResponseDTO> buscarPorId(@PathVariable Long id) {
        return ResponseEntity.ok(agendamentoService.buscarPorIdDTO(id));
    }

    @PutMapping("/{id}")
    public ResponseEntity<AgendamentoResponseDTO> atualizarAgendamento(@PathVariable Long id, @RequestBody AgendamentoDTO dto) {
        return ResponseEntity.ok(agendamentoService.atualizarAgendamento(id, dto));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> excluirAgendamento(@PathVariable Long id) {
        agendamentoService.excluirAgendamento(id);
        return ResponseEntity.noContent().build();
    }
}
