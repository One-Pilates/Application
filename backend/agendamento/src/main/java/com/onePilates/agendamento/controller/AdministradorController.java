package com.onePilates.agendamento.controller;

import com.onePilates.agendamento.dto.AdministradorDTO;
import com.onePilates.agendamento.dto.response.AdministradorResponseDTO;
import com.onePilates.agendamento.service.AdministradorService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/administradores")
public class AdministradorController {

    @Autowired
    private AdministradorService administradorService;

    @PostMapping
    @PreAuthorize("hasAuthority('ADMINISTRADOR')")
    public ResponseEntity<AdministradorResponseDTO> criarAdministrador(@RequestBody AdministradorDTO dto) {
        return ResponseEntity.ok(administradorService.toResponseDTO(administradorService.criarAdministrador(dto)));
    }

    @GetMapping
    @PreAuthorize("hasAuthority('ADMINISTRADOR')")
    public ResponseEntity<List<AdministradorResponseDTO>> listarAdministradores() {
        return ResponseEntity.ok(administradorService.listarTodosDTO());
    }

    @GetMapping("/{id}")
    @PreAuthorize("hasAuthority('ADMINISTRADOR')")
    public ResponseEntity<AdministradorResponseDTO> buscarPorId(@PathVariable Long id) {
        return ResponseEntity.ok(administradorService.buscarPorIdDTO(id));
    }

    @PatchMapping("/{id}")
    @PreAuthorize("hasAuthority('ADMINISTRADOR')")
    public ResponseEntity<AdministradorResponseDTO> atualizarAdministradorParcial(@PathVariable Long id, @RequestBody AdministradorDTO dto) {
        return ResponseEntity.ok(administradorService.atualizarAdministrador(id, dto));
    }

    @DeleteMapping("/{id}")
    @PreAuthorize("hasAuthority('ADMINISTRADOR')")
    public ResponseEntity<Void> excluirAdministrador(@PathVariable Long id) {
        administradorService.excluirAdministrador(id);
        return ResponseEntity.noContent().build();
    }
}