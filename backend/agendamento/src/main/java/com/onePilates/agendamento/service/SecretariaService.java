package com.onePilates.agendamento.service;

import com.onePilates.agendamento.dto.SecretariaDTO;
import com.onePilates.agendamento.dto.response.EnderecoResponseDTO;
import com.onePilates.agendamento.dto.response.SecretariaResponseDTO;
import com.onePilates.agendamento.model.Endereco;
import com.onePilates.agendamento.model.Role;
import com.onePilates.agendamento.model.Secretaria;
import com.onePilates.agendamento.repository.EnderecoRepository;
import com.onePilates.agendamento.repository.SecretariaRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class SecretariaService {

    @Autowired
    private SecretariaRepository secretariaRepository;

    @Autowired
    private EnderecoRepository enderecoRepository;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Transactional
    public Secretaria criarSecretaria(SecretariaDTO dto) {
        if (secretariaRepository.existsByEmail(dto.getEmail())) {
            throw new RuntimeException("Email já cadastrado");
        }
        if (secretariaRepository.existsByCpf(dto.getCpf())) {
            throw new RuntimeException("CPF já cadastrado");
        }

        Secretaria secretaria = new Secretaria();
        secretaria.setNome(dto.getNome());
        secretaria.setEmail(dto.getEmail());
        secretaria.setCpf(dto.getCpf());
        secretaria.setDataNascimento(dto.getIdade());
        secretaria.setStatus(dto.getStatus());
        secretaria.setFoto(dto.getFoto());
        secretaria.setObservacoes(dto.getObservacoes());
        secretaria.setNotificacaoAtiva(dto.getNotificacaoAtiva());
        secretaria.setSenha(passwordEncoder.encode(dto.getSenha()));
        secretaria.setCargo(dto.getCargo());
        secretaria.setRole(Role.SECRETARIA);

        if (dto.getEndereco() != null) {
            Endereco endereco = new Endereco();
            endereco.setRua(dto.getEndereco().getRua());
            endereco.setNumero(dto.getEndereco().getNumero());
            endereco.setBairro(dto.getEndereco().getBairro());
            endereco.setCidade(dto.getEndereco().getCidade());
            endereco.setEstado(dto.getEndereco().getEstado());
            endereco.setCep(dto.getEndereco().getCep());
            endereco.setUf(dto.getEndereco().getUf());
            endereco = enderecoRepository.save(endereco);
            secretaria.setEndereco(endereco);
        }

        return secretariaRepository.save(secretaria);
    }

    public List<SecretariaResponseDTO> listarTodosDTO() {
        return secretariaRepository.findAll().stream()
                .map(this::toResponseDTO)
                .collect(Collectors.toList());
    }

    public SecretariaResponseDTO buscarPorIdDTO(Long id) {
        Secretaria secretaria = secretariaRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Secretária não encontrada"));
        return toResponseDTO(secretaria);
    }

    @Transactional
    public SecretariaResponseDTO atualizarSecretaria(Long id, SecretariaDTO dto) {
        Secretaria secretaria = secretariaRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Secretária não encontrada"));

        if (dto.getNome() != null) {
            secretaria.setNome(dto.getNome());
        }
        if (dto.getEmail() != null && !dto.getEmail().equals(secretaria.getEmail())) {
            if (secretariaRepository.existsByEmail(dto.getEmail())) {
                throw new RuntimeException("Email já cadastrado");
            }
            secretaria.setEmail(dto.getEmail());
        }
        if (dto.getCpf() != null && !dto.getCpf().equals(secretaria.getCpf())) {
            if (secretariaRepository.existsByCpf(dto.getCpf())) {
                throw new RuntimeException("CPF já cadastrado");
            }
            secretaria.setCpf(dto.getCpf());
        }
        if (dto.getIdade() != null) {
            secretaria.setDataNascimento(dto.getIdade());
        }
        if (dto.getStatus() != null) {
            secretaria.setStatus(dto.getStatus());
        }
        if (dto.getFoto() != null) {
            secretaria.setFoto(dto.getFoto());
        }
        if (dto.getObservacoes() != null) {
            secretaria.setObservacoes(dto.getObservacoes());
        }
        if (dto.getNotificacaoAtiva() != null) {
            secretaria.setNotificacaoAtiva(dto.getNotificacaoAtiva());
        }
        if (dto.getSenha() != null && !dto.getSenha().isEmpty()) {
            secretaria.setSenha(passwordEncoder.encode(dto.getSenha()));
        }
        if (dto.getCargo() != null) {
            secretaria.setCargo(dto.getCargo());
        }

        if (dto.getEndereco() != null) {
            Endereco endereco = secretaria.getEndereco();
            if (endereco == null) {
                endereco = new Endereco();
            }
            if (dto.getEndereco().getRua() != null) {
                endereco.setRua(dto.getEndereco().getRua());
            }
            if (dto.getEndereco().getNumero() != null) {
                endereco.setNumero(dto.getEndereco().getNumero());
            }
            if (dto.getEndereco().getBairro() != null) {
                endereco.setBairro(dto.getEndereco().getBairro());
            }
            if (dto.getEndereco().getCidade() != null) {
                endereco.setCidade(dto.getEndereco().getCidade());
            }
            if (dto.getEndereco().getEstado() != null) {
                endereco.setEstado(dto.getEndereco().getEstado());
            }
            if (dto.getEndereco().getCep() != null) {
                endereco.setCep(dto.getEndereco().getCep());
            }
            if (dto.getEndereco().getUf() != null) {
                endereco.setUf(dto.getEndereco().getUf());
            }
            endereco = enderecoRepository.save(endereco);
            secretaria.setEndereco(endereco);
        }

        return toResponseDTO(secretariaRepository.save(secretaria));
    }

    @Transactional
    public void excluirSecretaria(Long id) {
        if (!secretariaRepository.existsById(id)) {
            throw new RuntimeException("Secretária não encontrada");
        }
        secretariaRepository.deleteById(id);
    }

    public SecretariaResponseDTO toResponseDTO(Secretaria secretaria) {
        SecretariaResponseDTO dto = new SecretariaResponseDTO();
        dto.setId(secretaria.getId());
        dto.setNome(secretaria.getNome());
        dto.setEmail(secretaria.getEmail());
        dto.setCpf(secretaria.getCpf());
        dto.setIdade(secretaria.getDataNascimento());
        dto.setStatus(secretaria.getStatus());
        dto.setFoto(secretaria.getFoto());
        dto.setObservacoes(secretaria.getObservacoes());
        dto.setNotificacaoAtiva(secretaria.getNotificacaoAtiva());
        dto.setCargo(secretaria.getCargo());
        dto.setRole(secretaria.getRole() != null ? secretaria.getRole().name() : null);

        if (secretaria.getEndereco() != null) {
            EnderecoResponseDTO enderecoDTO = new EnderecoResponseDTO();
            enderecoDTO.setRua(secretaria.getEndereco().getRua());
            enderecoDTO.setCidade(secretaria.getEndereco().getCidade());
            enderecoDTO.setEstado(secretaria.getEndereco().getEstado());
            enderecoDTO.setCep(secretaria.getEndereco().getCep());
            dto.setEndereco(enderecoDTO);
        }

        return dto;
    }
}
