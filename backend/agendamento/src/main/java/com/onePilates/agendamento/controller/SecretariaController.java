package com.onePilates.agendamento.controller;

import com.onePilates.agendamento.dto.SecretariaDTO;
import com.onePilates.agendamento.dto.response.SecretariaResponseDTO;
import com.onePilates.agendamento.service.SecretariaService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/secretarias")
public class SecretariaController {

    @Autowired
    private SecretariaService secretariaService;

    @PostMapping
    @PreAuthorize("hasAuthority('ADMINISTRADOR')")
    public ResponseEntity<SecretariaResponseDTO> criarSecretaria(@RequestBody SecretariaDTO dto) {
        return ResponseEntity.ok(secretariaService.toResponseDTO(secretariaService.criarSecretaria(dto)));
    }

    @GetMapping
    @PreAuthorize("hasAnyAuthority('ADMINISTRADOR', 'SECRETARIA')")
    public ResponseEntity<List<SecretariaResponseDTO>> listarSecretarias() {
        return ResponseEntity.ok(secretariaService.listarTodosDTO());
    }

    @GetMapping("/{id}")
    @PreAuthorize("hasAnyAuthority('ADMINISTRADOR', 'SECRETARIA')")
    public ResponseEntity<SecretariaResponseDTO> buscarPorId(@PathVariable Long id) {
        return ResponseEntity.ok(secretariaService.buscarPorIdDTO(id));
    }

    @PatchMapping("/{id}")
    @PreAuthorize("hasAuthority('ADMINISTRADOR')")
    public ResponseEntity<SecretariaResponseDTO> atualizarSecretariaParcial(@PathVariable Long id, @RequestBody SecretariaDTO dto) {
        return ResponseEntity.ok(secretariaService.atualizarSecretaria(id, dto));
    }

    @DeleteMapping("/{id}")
    @PreAuthorize("hasAuthority('ADMINISTRADOR')")
    public ResponseEntity<Void> excluirSecretaria(@PathVariable Long id) {
        secretariaService.excluirSecretaria(id);
        return ResponseEntity.noContent().build();
    }
}
