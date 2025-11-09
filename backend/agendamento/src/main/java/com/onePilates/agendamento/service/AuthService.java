package com.onePilates.agendamento.service;

import com.onePilates.agendamento.dto.EspecialidadeDTO;
import com.onePilates.agendamento.dto.FuncionarioLoginDTO;
import com.onePilates.agendamento.dto.LoginDTO;
import com.onePilates.agendamento.dto.response.EspecialidadeResponseDTO;
import com.onePilates.agendamento.dto.response.LoginResponseDTO;
import com.onePilates.agendamento.model.Funcionario;
import com.onePilates.agendamento.model.Professor;
import com.onePilates.agendamento.model.Role;
import com.onePilates.agendamento.repository.AdministradorRepository;
import com.onePilates.agendamento.repository.FuncionarioRepository;
import com.onePilates.agendamento.repository.ProfessorRepository;
import com.onePilates.agendamento.repository.SecretariaRepository;
import com.onePilates.agendamento.security.JwtUtil;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

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

        if (funcionario == null) {
            throw new RuntimeException("Funcionário não encontrado");
        }

        if (!passwordEncoder.matches(request.getSenha(), funcionario.getSenha())) {
            throw new RuntimeException("Credenciais inválidas");
        }

        String token = jwtUtil.generateToken(funcionario);

        FuncionarioLoginDTO funcionarioDTO;

        if (funcionario.getRole() == Role.PROFESSOR && funcionario instanceof Professor professor) {

            List<EspecialidadeResponseDTO> especialidades = professor.getEspecialidades()
                    .stream()
                    .map(e -> new EspecialidadeResponseDTO(e.getId(), e.getNome()))
                    .collect(Collectors.toList());

            funcionarioDTO = new FuncionarioLoginDTO(
                    funcionario.getId(),
                    funcionario.getNome(),
                    funcionario.getEmail(),
                    funcionario.getRole(),
                    funcionario.getCpf(),
                    funcionario.getDataNascimento(),
                    funcionario.getStatus(),
                    funcionario.getFoto(),
                    funcionario.getObservacoes(),
                    funcionario.getNotificacaoAtiva(),
                    funcionario.getCargo(),
                    funcionario.getEndereco(),
                    funcionario.getTelefone(),
                    especialidades
            );

        } else {

            funcionarioDTO = new FuncionarioLoginDTO(
                    funcionario.getId(),
                    funcionario.getNome(),
                    funcionario.getEmail(),
                    funcionario.getRole(),
                    funcionario.getCpf(),
                    funcionario.getDataNascimento(),
                    funcionario.getStatus(),
                    funcionario.getFoto(),
                    funcionario.getObservacoes(),
                    funcionario.getNotificacaoAtiva(),
                    funcionario.getCargo(),
                    funcionario.getEndereco(),
                    funcionario.getTelefone()
            );
        }

        return new LoginResponseDTO(token, funcionario.getRole().name(), funcionarioDTO);
    }



    private Funcionario buscarFuncionarioPorEmail(String email) {
        return administradorRepository.findByEmail(email)
                .map(f -> (Funcionario) f)
                .or(() -> professorRepository.findByEmail(email).map(f -> (Funcionario) f))
                .or(() -> secretariaRepository.findByEmail(email).map(f -> (Funcionario) f))
                .orElseThrow(() -> new RuntimeException("Usuário não encontrado"));
    }
}
