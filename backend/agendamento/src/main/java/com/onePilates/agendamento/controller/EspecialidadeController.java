package com.onePilates.agendamento.controller;

import com.onePilates.agendamento.dto.EspecialidadeDTO;
import com.onePilates.agendamento.dto.SalaDTO;
import com.onePilates.agendamento.dto.response.EspecialidadeResponseDTO;
import com.onePilates.agendamento.dto.response.ProfessorPorEspecialidadeResponseDTO;
import com.onePilates.agendamento.dto.response.SalasPorEspecialidadeResponseDTO;
import com.onePilates.agendamento.model.Professor;
import com.onePilates.agendamento.repository.ProfessorRepository;
import com.onePilates.agendamento.service.EspecialidadeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/especialidades")
@CrossOrigin(origins = "*")
public class EspecialidadeController {

    @Autowired
    private EspecialidadeService especialidadeService;

    @Autowired
    private ProfessorRepository professorRepository;

    @PostMapping
    @PreAuthorize("hasAnyAuthority('ADMINISTRADOR', 'SECRETARIA')")
    public ResponseEntity<EspecialidadeResponseDTO> criarEspecialidade(@RequestBody EspecialidadeDTO dto) {
        return ResponseEntity.ok(
                especialidadeService.toResponseDTO(especialidadeService.criarEspecialidade(dto))
        );
    }

    @GetMapping
    @PreAuthorize("hasAnyAuthority('ADMINISTRADOR', 'SECRETARIA', 'PROFESSOR')")
    public ResponseEntity<List<EspecialidadeResponseDTO>> listarEspecialidades() {
        return ResponseEntity.ok(especialidadeService.listarTodasDTO());
    }

    @GetMapping("/{id}")
    @PreAuthorize("hasAnyAuthority('ADMINISTRADOR', 'SECRETARIA', 'PROFESSOR')")
    public ResponseEntity<EspecialidadeResponseDTO> buscarPorId(@PathVariable Long id) {
        return ResponseEntity.ok(especialidadeService.buscarPorIdDTO(id));
    }

    @PatchMapping("/{id}")
    @PreAuthorize("hasAnyAuthority('ADMINISTRADOR', 'SECRETARIA')")
    public ResponseEntity<EspecialidadeResponseDTO> atualizarEspecialidadeParcial(@PathVariable Long id, @RequestBody EspecialidadeDTO dto) {
        return ResponseEntity.ok(especialidadeService.atualizarEspecialidade(id, dto));
    }

    @DeleteMapping("/{id}")
    @PreAuthorize("hasAuthority('ADMINISTRADOR')")
    public ResponseEntity<Void> excluirEspecialidade(@PathVariable Long id) {
        especialidadeService.excluirEspecialidade(id);
        return ResponseEntity.noContent().build();
    }

    @GetMapping("/professores/{id}")
    @PreAuthorize("hasAnyAuthority('ADMINISTRADOR', 'SECRETARIA')")
    public ResponseEntity<List<ProfessorPorEspecialidadeResponseDTO>> BuscarProfessorEspecialidade(@PathVariable Long id) {
        return ResponseEntity.ok(especialidadeService.BuscarProfessor(id));
    }

    @GetMapping("/salas/{id}")
    @PreAuthorize("hasAnyAuthority('ADMINISTRADOR', 'SECRETARIA')")
    public ResponseEntity<List<SalasPorEspecialidadeResponseDTO>> buscarSalasPorEspecialidade(@PathVariable Long id) {
        return  ResponseEntity.ok(especialidadeService.buscarSalasPorEspecialidade(id));
    }

}
