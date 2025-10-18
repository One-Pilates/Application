package com.onePilates.agendamento.controller;

import com.onePilates.agendamento.dto.EspecialidadeDTO;
import com.onePilates.agendamento.dto.response.EspecialidadeResponseDTO;
import com.onePilates.agendamento.service.EspecialidadeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/especialidades")
public class EspecialidadeController {

    @Autowired
    private EspecialidadeService especialidadeService;

    @PostMapping
    public ResponseEntity<EspecialidadeResponseDTO> criarEspecialidade(@RequestBody EspecialidadeDTO dto) {
        return ResponseEntity.ok(
                especialidadeService.toResponseDTO(especialidadeService.criarEspecialidade(dto))
        );
    }

    @GetMapping
    public ResponseEntity<List<EspecialidadeResponseDTO>> listarEspecialidades() {
        return ResponseEntity.ok(especialidadeService.listarTodasDTO());
    }

    @GetMapping("/{id}")
    public ResponseEntity<EspecialidadeResponseDTO> buscarPorId(@PathVariable Long id) {
        return ResponseEntity.ok(especialidadeService.buscarPorIdDTO(id));
    }

    @PatchMapping("/{id}")
    public ResponseEntity<EspecialidadeResponseDTO> atualizarEspecialidadeParcial(@PathVariable Long id, @RequestBody EspecialidadeDTO dto) {
        return ResponseEntity.ok(especialidadeService.atualizarEspecialidade(id, dto));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> excluirEspecialidade(@PathVariable Long id) {
        especialidadeService.excluirEspecialidade(id);
        return ResponseEntity.noContent().build();
    }
}
