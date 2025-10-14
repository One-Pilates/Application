package com.onePilates.agendamento.controller;

import com.onePilates.agendamento.dto.ProfessorDTO;
import com.onePilates.agendamento.dto.response.ProfessorResponseDTO;
import com.onePilates.agendamento.service.ProfessorService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/professores")
public class ProfessorController {

    @Autowired
    private ProfessorService professorService;

    @PostMapping
    public ResponseEntity<ProfessorResponseDTO> criarProfessor(@RequestBody ProfessorDTO dto) {
        return ResponseEntity.ok(professorService.toResponseDTO(professorService.criarProfessor(dto)));
    }

    @GetMapping
    public ResponseEntity<List<ProfessorResponseDTO>> listarProfessores() {
        return ResponseEntity.ok(professorService.listarTodosDTO());
    }

    @GetMapping("/{id}")
    public ResponseEntity<ProfessorResponseDTO> buscarPorId(@PathVariable Long id) {
        return ResponseEntity.ok(professorService.buscarPorIdDTO(id));
    }

    @PatchMapping("/{id}")
    public ResponseEntity<ProfessorResponseDTO> atualizarProfessorParcial(@PathVariable Long id, @RequestBody ProfessorDTO dto) {
        return ResponseEntity.ok(professorService.atualizarProfessor(id, dto));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> excluirProfessor(@PathVariable Long id) {
        professorService.excluirProfessor(id);
        return ResponseEntity.noContent().build();
    }
}