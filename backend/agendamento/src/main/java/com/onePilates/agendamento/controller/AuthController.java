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
public class AuthController {

    private final AuthService authService;
    private final ProfessorService professorService;

    public AuthController(AuthService authService, ProfessorService professorService) {
        this.authService = authService;
        this.professorService = professorService;
    }

    @PostMapping("/login")
    public ResponseEntity<LoginResponseDTO> login(@Valid @RequestBody LoginDTO request) {
        LoginResponseDTO response = authService.authenticate(request);
        return ResponseEntity.ok(response);
    }

    // Endpoint público de registro: força Role.PROFESSOR independentemente do dto.role
    @PostMapping("/register/professor")
    public ResponseEntity<ProfessorResponseDTO> registerProfessorPublic(@Valid @RequestBody ProfessorDTO dto) {
        dto.setRole(Role.PROFESSOR);
        ProfessorResponseDTO response = professorService.criarProfessor(dto);
        return ResponseEntity.status(HttpStatus.CREATED).body(response);
    }

    // Endpoint protegido: somente ADMINISTRADOR pode criar professor com role arbitrária
    @PreAuthorize("hasRole('ADMINISTRADOR')")
    @PostMapping("/admin/create-professor")
    public ResponseEntity<ProfessorResponseDTO> createProfessorAdmin(@Valid @RequestBody ProfessorDTO dto) {
        // aqui dto.role é respeitado (pode ser ADMINISTRADOR, SECRETARIA ou PROFESSOR)
        ProfessorResponseDTO response = professorService.criarProfessorAsAdmin(dto);
        return ResponseEntity.status(HttpStatus.CREATED).body(response);
    }

}
