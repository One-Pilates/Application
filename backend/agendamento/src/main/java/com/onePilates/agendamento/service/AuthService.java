package com.onePilates.agendamento.service;

import com.onePilates.agendamento.dto.FuncionarioLoginDTO;
import com.onePilates.agendamento.dto.LoginPages.LoginDTO;
import com.onePilates.agendamento.dto.response.EspecialidadeResponseDTO;
import com.onePilates.agendamento.dto.response.LoginResponseDTO;
import com.onePilates.agendamento.dto.response.NovaSenhaResponseDTO;
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

import java.time.Duration;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Random;
import java.util.stream.Collectors;

@Service
public class AuthService {

    private final AdministradorRepository administradorRepository;
    private final ProfessorRepository professorRepository;
    private final SecretariaRepository secretariaRepository;
    private final PasswordEncoder passwordEncoder;
    private final FuncionarioRepository funcionarioRepository;
    private final JwtUtil jwtUtil;
    private final EmailService emailService;

    public AuthService(
            AdministradorRepository administradorRepository,
            ProfessorRepository professorRepository,
            SecretariaRepository secretariaRepository,
            PasswordEncoder passwordEncoder, FuncionarioRepository funcionarioRepository,
            JwtUtil jwtUtil, EmailService emailService
    ) {
        this.administradorRepository = administradorRepository;
        this.professorRepository = professorRepository;
        this.secretariaRepository = secretariaRepository;
        this.passwordEncoder = passwordEncoder;
        this.funcionarioRepository = funcionarioRepository;
        this.jwtUtil = jwtUtil;
        this.emailService = emailService;
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

    public String criarCodigoVerificacao(String email) {
        Funcionario funcionario = buscarFuncionarioPorEmail(email);

        String codigoVerificacao = String.format("%05d", new Random().nextInt(100000));
        funcionario.setCodigoVerificacao(codigoVerificacao);
        funcionario.setDataUltimaCriacaoCodigo(LocalDateTime.now());

        funcionarioRepository.save(funcionario);

        try {
            emailService.enviarCodigoPorEmail(funcionario.getNome(), codigoVerificacao, email);
        } catch (Exception e) {
            System.err.println("Erro ao enviar o e-mail de verificação: " + e.getMessage());
            return "Erro ao enviar o e-mail de verificação.";
        }

        return "Código enviado para o e-mail do funcionário.";
    }


    public Boolean validarCodigoVerificacao(String email, String codigoVerificacao) {
        Funcionario funcionario = buscarFuncionarioPorEmail(email);



        if (!funcionario.getCodigoVerificacao().equals(codigoVerificacao)) {
            throw  new RuntimeException("Código inválido");
        }


        LocalDateTime agora = LocalDateTime.now();
        Duration diferenca = Duration.between(funcionario.getDataUltimaCriacaoCodigo(), agora);

        if (diferenca.toMinutes() > 5) {
            throw  new RuntimeException ("Código expirado");
        }

        return true;
    }

    public NovaSenhaResponseDTO novaSenha(String senha,String email) {
        Funcionario funcionario = buscarFuncionarioPorEmail(email);
        if(funcionario==null){
            throw new RuntimeException("Funcionário não encontrado");
        }
        funcionario.setSenha(passwordEncoder.encode(senha));
        funcionarioRepository.save(funcionario);
        NovaSenhaResponseDTO dtoResponse =  new NovaSenhaResponseDTO();
        dtoResponse.setMensagem("Senha alterada com sucesso");
        return dtoResponse;
    }
}
