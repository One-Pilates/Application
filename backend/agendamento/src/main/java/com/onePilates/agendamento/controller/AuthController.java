package com.onePilates.agendamento.controller;

import com.onePilates.agendamento.dto.LoginDTO;
import com.onePilates.agendamento.dto.response.LoginResponseDTO;
import com.onePilates.agendamento.dto.ProfessorDTO;
import com.onePilates.agendamento.dto.response.ProfessorResponseDTO;
import com.onePilates.agendamento.model.Role;
import com.onePilates.agendamento.service.AuthService;
import com.onePilates.agendamento.service.ProfessorService;
import jakarta.validation.Valid;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
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


}
