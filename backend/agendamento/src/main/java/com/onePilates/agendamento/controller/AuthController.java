package com.onePilates.agendamento.controller;

import com.onePilates.agendamento.dto.LoginPages.CriarCodigoValidacaoDTO;
import com.onePilates.agendamento.dto.LoginPages.NovaSenhaDTO;
import com.onePilates.agendamento.dto.LoginPages.ValidarCodigoVerificacaoDTO;
import com.onePilates.agendamento.dto.LoginPages.LoginDTO;
import com.onePilates.agendamento.dto.response.LoginResponseDTO;
import com.onePilates.agendamento.dto.response.NovaSenhaResponseDTO;
import com.onePilates.agendamento.service.AuthService;
import jakarta.validation.Valid;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/auth")
@CrossOrigin(origins = "*")
public class AuthController {

    private final AuthService authService;

    public AuthController(AuthService authService) {
        this.authService = authService;
    }

    @PostMapping("/login")
    public ResponseEntity<LoginResponseDTO> login(@Valid @RequestBody LoginDTO request) {
        LoginResponseDTO response = authService.authenticate(request);
        return ResponseEntity.ok(response);
    }

    @PostMapping("/criarCodigoVerificacao")
    public ResponseEntity<String> validacaoECriacaoDoCodigoDeVerificacao(@Valid @RequestBody CriarCodigoValidacaoDTO dto) {
        return ResponseEntity.ok(authService.criarCodigoVerificacao(dto.getEmail()));
    }

    @PostMapping("/validarCodigo")
    public ResponseEntity<Boolean> validarCodigo(@Valid @RequestBody ValidarCodigoVerificacaoDTO dto) {
        return ResponseEntity.ok(authService.validarCodigoVerificacao(dto.getEmail(), dto.getCodigo()));
    }

    @PostMapping("/alterarSenha")
    public ResponseEntity<NovaSenhaResponseDTO> trocarSenha(@Valid @RequestBody NovaSenhaDTO dto){
        return ResponseEntity.ok(authService.novaSenha(dto.getSenha(),dto.getEmail()));
    }


}
