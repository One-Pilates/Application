package com.onePilates.agendamento.controller;

import com.onePilates.agendamento.dto.AusenciaDTO;
import com.onePilates.agendamento.dto.response.AusenciaResponseDTO;
import com.onePilates.agendamento.service.AusenciaService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/ausencias")
public class AusenciaController {

    @Autowired
    private AusenciaService ausenciaService;

    @PostMapping
    public ResponseEntity<AusenciaResponseDTO> registrar( @Valid @RequestBody AusenciaDTO dto) {
        AusenciaResponseDTO response = ausenciaService.registrarAusencia(dto);
        return ResponseEntity.status(HttpStatus.CREATED).body(response);
    }


    @GetMapping("/professor/{id}")
    public ResponseEntity<List<AusenciaResponseDTO>> listarPorProfessor(@PathVariable Long id) {
        return ResponseEntity.ok(ausenciaService.listarPorProfessor(id));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Map<String, String>> deletar(@PathVariable Integer id) {
        ausenciaService.deletarAusencia(id);

        Map<String, String> resposta = new HashMap<>();
        resposta.put("mensagem", "Ausência apagada com sucesso.");

        return ResponseEntity.ok(resposta);
    }

}
