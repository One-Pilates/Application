package com.onePilates.agendamento.service;

import com.onePilates.agendamento.dto.LoginDTO;
import com.onePilates.agendamento.dto.response.LoginResponseDTO;
import com.onePilates.agendamento.model.Funcionario;
import com.onePilates.agendamento.repository.AdministradorRepository;
import com.onePilates.agendamento.repository.FuncionarioRepository;
import com.onePilates.agendamento.repository.ProfessorRepository;
import com.onePilates.agendamento.repository.SecretariaRepository;
import com.onePilates.agendamento.security.JwtUtil;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@Service
public class AuthService {

    private final AdministradorRepository administradorRepository;
    private final ProfessorRepository professorRepository;
    private final SecretariaRepository secretariaRepository;
    private final PasswordEncoder passwordEncoder;
    private final JwtUtil jwtUtil;

    public AuthService(
            AdministradorRepository administradorRepository,
            ProfessorRepository professorRepository,
            SecretariaRepository secretariaRepository,
            PasswordEncoder passwordEncoder,
            JwtUtil jwtUtil
    ) {
        this.administradorRepository = administradorRepository;
        this.professorRepository = professorRepository;
        this.secretariaRepository = secretariaRepository;
        this.passwordEncoder = passwordEncoder;
        this.jwtUtil = jwtUtil;
    }

    public LoginResponseDTO authenticate(LoginDTO request) {
        Funcionario funcionario = buscarFuncionarioPorEmail(request.getEmail());

        if (!passwordEncoder.matches(request.getSenha(), funcionario.getSenha())) {
            throw new RuntimeException("Credenciais inválidas");
        }

        String token = jwtUtil.generateToken(funcionario);


        return new LoginResponseDTO(token, funcionario.getRole().name(), funcionario);
    }


    private Funcionario buscarFuncionarioPorEmail(String email) {
        return administradorRepository.findByEmail(email)
                .map(f -> (Funcionario) f)
                .or(() -> professorRepository.findByEmail(email).map(f -> (Funcionario) f))
                .or(() -> secretariaRepository.findByEmail(email).map(f -> (Funcionario) f))
                .orElseThrow(() -> new RuntimeException("Usuário não encontrado"));
    }
}
