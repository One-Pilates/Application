package com.onePilates.agendamento.controller;

import com.onePilates.agendamento.dto.AlunoDTO;
import com.onePilates.agendamento.dto.response.AlunoResponseDTO;
import com.onePilates.agendamento.service.AlunoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/alunos")
public class AlunoController {

    @Autowired
    private AlunoService alunoService;

    @PostMapping
    @PreAuthorize("hasAnyAuthority('ADMINISTRADOR', 'SECRETARIA')")
    public ResponseEntity<AlunoResponseDTO> criarAluno(@RequestBody AlunoDTO dto) {
        return ResponseEntity.ok(alunoService.toResponseDTO(alunoService.criarAluno(dto)));
    }

    @GetMapping
    @PreAuthorize("hasAnyAuthority('ADMINISTRADOR', 'SECRETARIA', 'PROFESSOR')")
    public ResponseEntity<List<AlunoResponseDTO>> listarAlunos() {
        return ResponseEntity.ok(alunoService.listarTodosDTO());
    }

    @GetMapping("/{id}")
    @PreAuthorize("hasAnyAuthority('ADMINISTRADOR', 'SECRETARIA')")
    public ResponseEntity<AlunoResponseDTO> buscarPorId(@PathVariable Long id) {
        return ResponseEntity.ok(alunoService.buscarPorIdDTO(id));
    }

    @PatchMapping("/{id}")
    @PreAuthorize("hasAnyAuthority('ADMINISTRADOR', 'SECRETARIA')")
    public ResponseEntity<AlunoResponseDTO> atualizarAlunoParcial(@PathVariable Long id, @RequestBody AlunoDTO dto) {
        return ResponseEntity.ok(alunoService.atualizarAluno(id, dto));
    }

    @DeleteMapping("/{id}")
    @PreAuthorize("hasAnyAuthority('ADMINISTRADOR', 'SECRETARIA')")
    public ResponseEntity<Void> excluirAluno(@PathVariable Long id) {
        alunoService.excluirAluno(id);
        return ResponseEntity.noContent().build();
    }
}