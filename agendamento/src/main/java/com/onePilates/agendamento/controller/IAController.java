package com.onePilates.agendamento.controller;

import com.onePilates.agendamento.dto.IARequestDTO;
import com.onePilates.agendamento.service.IAService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@RequestMapping("/api/ia")
public class IAController {

    private final IAService iaService;

    public IAController(IAService iaService) {
        this.iaService = iaService;
    }

    @PostMapping("/recomendacao")
    public ResponseEntity<Map<String, String>> getRecomendacao(@RequestBody IARequestDTO request) {
        try {
            String recomendacao = iaService.getRecomendacao(
                    request.nomeAluno(),
                    request.observacao(),
                    request.especialidade(),
                    request.historico(),
                    request.mensagemUsuario()
            );
            return ResponseEntity.ok(Map.of("recomendacao", recomendacao));
        } catch (Exception e) {
            return ResponseEntity.internalServerError().body(Map.of("erro", e.getMessage()));
        }
    }
}
