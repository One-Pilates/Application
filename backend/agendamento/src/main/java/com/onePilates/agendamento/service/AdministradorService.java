package com.onePilates.agendamento.service;

import com.onePilates.agendamento.dto.AdministradorDTO;
import com.onePilates.agendamento.dto.response.AdministradorResponseDTO;
import com.onePilates.agendamento.dto.response.EnderecoResponseDTO;
import com.onePilates.agendamento.exception.*;
import com.onePilates.agendamento.model.Administrador;
import com.onePilates.agendamento.model.Endereco;
import com.onePilates.agendamento.repository.AdministradorRepository;
import com.onePilates.agendamento.repository.EnderecoRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class AdministradorService {

    private static final Logger logger = LoggerFactory.getLogger(AdministradorService.class);

    private final AdministradorRepository administradorRepository;
    private final EnderecoRepository enderecoRepository;
    private final PasswordEncoder passwordEncoder;

    public AdministradorService(
            AdministradorRepository administradorRepository,
            EnderecoRepository enderecoRepository,
            PasswordEncoder passwordEncoder
    ) {
        this.administradorRepository = administradorRepository;
        this.enderecoRepository = enderecoRepository;
        this.passwordEncoder = passwordEncoder;
    }

    @Transactional
    public Administrador criarAdministrador(AdministradorDTO dto) {
        logger.info("Tentativa de criar administrador: {}", dto.getNome());
        try {
            if (administradorRepository.existsByEmail(dto.getEmail())) {
                throw new EmailJaCadastradoException("Email já cadastrado");
            }
            if (administradorRepository.existsByCpf(dto.getCpf())) {
                throw new CpfJaCadastradoException("CPF já cadastrado");
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

            Administrador saved = administradorRepository.save(administrador);
            logger.info("Administrador criado com sucesso. ID: {}", saved.getId());
            return saved;
        } catch (BusinessException e) {
            logger.warn("Falha ao criar administrador: {}", e.getMessage());
            throw e;
        } catch (Exception e) {
            logger.error("Erro inesperado ao criar administrador", e);
            throw e;
        }
    }

    public List<AdministradorResponseDTO> listarTodosDTO() {
        logger.debug("Listando todos os administradores");
        List<AdministradorResponseDTO> administradores = administradorRepository.findAll().stream()
                .map(this::toResponseDTO)
                .collect(Collectors.toList());
        logger.debug("Encontrados {} administradores", administradores.size());
        return administradores;
    }

    public AdministradorResponseDTO buscarPorIdDTO(Long id) {
        logger.debug("Buscando administrador por ID: {}", id);
        Administrador administrador = administradorRepository.findById(id)
                .orElseThrow(() -> new EntidadeNaoEncontradaException("Administrador não encontrado"));
        return toResponseDTO(administrador);
    }

    @Transactional
    public AdministradorResponseDTO atualizarAdministrador(Long id, AdministradorDTO dto) {
        logger.info("Tentativa de atualizar administrador ID: {}", id);
        try {
            Administrador administrador = administradorRepository.findById(id)
                    .orElseThrow(() -> new EntidadeNaoEncontradaException("Administrador não encontrado"));

            if (dto.getNome() != null) {
                administrador.setNome(dto.getNome());
            }
            if (dto.getEmail() != null && !dto.getEmail().equals(administrador.getEmail())) {
                if (administradorRepository.existsByEmail(dto.getEmail())) {
                    throw new EmailJaCadastradoException("Email já cadastrado");
                }
                administrador.setEmail(dto.getEmail());
            }
            if (dto.getCpf() != null && !dto.getCpf().equals(administrador.getCpf())) {
                if (administradorRepository.existsByCpf(dto.getCpf())) {
                    throw new CpfJaCadastradoException("CPF já cadastrado");
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

            AdministradorResponseDTO response = toResponseDTO(administradorRepository.save(administrador));
            logger.info("Administrador atualizado com sucesso. ID: {}", id);
            return response;
        } catch (BusinessException e) {
            logger.warn("Falha ao atualizar administrador ID {}: {}", id, e.getMessage());
            throw e;
        } catch (Exception e) {
            logger.error("Erro inesperado ao atualizar administrador ID: {}", id, e);
            throw e;
        }
    }

    @Transactional
    public void excluirAdministrador(Long id) {
        logger.info("Tentativa de excluir administrador ID: {}", id);
        try {
            if (!administradorRepository.existsById(id)) {
                throw new EntidadeNaoEncontradaException("Administrador não encontrado");
            }
            administradorRepository.deleteById(id);
            logger.info("Administrador excluído com sucesso. ID: {}", id);
        } catch (BusinessException e) {
            logger.warn("Falha ao excluir administrador ID {}: {}", id, e.getMessage());
            throw e;
        } catch (Exception e) {
            logger.error("Erro inesperado ao excluir administrador ID: {}", id, e);
            throw e;
        }
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
