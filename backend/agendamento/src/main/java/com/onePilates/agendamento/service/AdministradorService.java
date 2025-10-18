package com.onePilates.agendamento.service;

import com.onePilates.agendamento.dto.AdministradorDTO;
import com.onePilates.agendamento.dto.response.AdministradorResponseDTO;
import com.onePilates.agendamento.dto.response.EnderecoResponseDTO;
import com.onePilates.agendamento.model.Administrador;
import com.onePilates.agendamento.model.Endereco;
import com.onePilates.agendamento.repository.AdministradorRepository;
import com.onePilates.agendamento.repository.EnderecoRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class AdministradorService {

    @Autowired
    private AdministradorRepository administradorRepository;

    @Autowired
    private EnderecoRepository enderecoRepository;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Transactional
    public Administrador criarAdministrador(AdministradorDTO dto) {
        if (administradorRepository.existsByEmail(dto.getEmail())) {
            throw new RuntimeException("Email já cadastrado");
        }
        if (administradorRepository.existsByCpf(dto.getCpf())) {
            throw new RuntimeException("CPF já cadastrado");
        }

        Administrador administrador = new Administrador();
        administrador.setNome(dto.getNome());
        administrador.setEmail(dto.getEmail());
        administrador.setCpf(dto.getCpf());
        administrador.setDataNascimento(dto.getIdade());
        administrador.setStatus(dto.getStatus());
        administrador.setFoto(dto.getFoto());
        administrador.setObservacoes(dto.getObservacoes());
        administrador.setNotificacaoAtiva(dto.getNotificacaoAtiva());
        administrador.setSenha(passwordEncoder.encode(dto.getSenha()));
        administrador.setCargo(dto.getCargo());

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
            administrador.setEndereco(endereco);
        }

        return administradorRepository.save(administrador);
    }

    public List<AdministradorResponseDTO> listarTodosDTO() {
        return administradorRepository.findAll().stream()
                .map(this::toResponseDTO)
                .collect(Collectors.toList());
    }

    public AdministradorResponseDTO buscarPorIdDTO(Long id) {
        Administrador administrador = administradorRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Administrador não encontrado"));
        return toResponseDTO(administrador);
    }

    @Transactional
    public AdministradorResponseDTO atualizarAdministrador(Long id, AdministradorDTO dto) {
        Administrador administrador = administradorRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Administrador não encontrado"));

        if (dto.getNome() != null) {
            administrador.setNome(dto.getNome());
        }
        if (dto.getEmail() != null && !dto.getEmail().equals(administrador.getEmail())) {
            if (administradorRepository.existsByEmail(dto.getEmail())) {
                throw new RuntimeException("Email já cadastrado");
            }
            administrador.setEmail(dto.getEmail());
        }
        if (dto.getCpf() != null && !dto.getCpf().equals(administrador.getCpf())) {
            if (administradorRepository.existsByCpf(dto.getCpf())) {
                throw new RuntimeException("CPF já cadastrado");
            }
            administrador.setCpf(dto.getCpf());
        }
        if (dto.getIdade() != null) {
            administrador.setDataNascimento(dto.getIdade());
        }
        if (dto.getStatus() != null) {
            administrador.setStatus(dto.getStatus());
        }
        if (dto.getFoto() != null) {
            administrador.setFoto(dto.getFoto());
        }
        if (dto.getObservacoes() != null) {
            administrador.setObservacoes(dto.getObservacoes());
        }
        if (dto.getNotificacaoAtiva() != null) {
            administrador.setNotificacaoAtiva(dto.getNotificacaoAtiva());
        }
        if (dto.getSenha() != null && !dto.getSenha().isEmpty()) {
            administrador.setSenha(passwordEncoder.encode(dto.getSenha()));
        }
        if (dto.getCargo() != null) {
            administrador.setCargo(dto.getCargo());
        }

        if (dto.getEndereco() != null) {
            Endereco endereco = administrador.getEndereco();
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
            administrador.setEndereco(endereco);
        }

        return toResponseDTO(administradorRepository.save(administrador));
    }

    @Transactional
    public void excluirAdministrador(Long id) {
        if (!administradorRepository.existsById(id)) {
            throw new RuntimeException("Administrador não encontrado");
        }
        administradorRepository.deleteById(id);
    }

    public AdministradorResponseDTO toResponseDTO(Administrador administrador) {
        AdministradorResponseDTO dto = new AdministradorResponseDTO();
        dto.setId(administrador.getId());
        dto.setNome(administrador.getNome());
        dto.setEmail(administrador.getEmail());
        dto.setCpf(administrador.getCpf());
        dto.setIdade(administrador.getDataNascimento());
        dto.setStatus(administrador.getStatus());
        dto.setFoto(administrador.getFoto());
        dto.setObservacoes(administrador.getObservacoes());
        dto.setNotificacaoAtiva(administrador.getNotificacaoAtiva());
        dto.setCargo(administrador.getCargo());
        dto.setRole(administrador.getRole() != null ? administrador.getRole().name() : null);

        if (administrador.getEndereco() != null) {
            EnderecoResponseDTO enderecoDTO = new EnderecoResponseDTO();
            enderecoDTO.setRua(administrador.getEndereco().getRua());
            enderecoDTO.setCidade(administrador.getEndereco().getCidade());
            enderecoDTO.setEstado(administrador.getEndereco().getEstado());
            enderecoDTO.setCep(administrador.getEndereco().getCep());
            dto.setEndereco(enderecoDTO);
        }

        return dto;
    }
}
