package com.onePilates.agendamento.service;

import com.onePilates.agendamento.dto.SecretariaDTO;
import com.onePilates.agendamento.dto.response.EnderecoResponseDTO;
import com.onePilates.agendamento.dto.response.SecretariaResponseDTO;
import com.onePilates.agendamento.exception.*;
import com.onePilates.agendamento.model.Endereco;
import com.onePilates.agendamento.model.Role;
import com.onePilates.agendamento.model.Secretaria;
import com.onePilates.agendamento.repository.EnderecoRepository;
import com.onePilates.agendamento.repository.SecretariaRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class SecretariaService {

    private static final Logger logger = LoggerFactory.getLogger(SecretariaService.class);

    private final SecretariaRepository secretariaRepository;
    private final EnderecoRepository enderecoRepository;
    private final PasswordEncoder passwordEncoder;

    public SecretariaService(
            SecretariaRepository secretariaRepository,
            EnderecoRepository enderecoRepository,
            PasswordEncoder passwordEncoder
    ) {
        this.secretariaRepository = secretariaRepository;
        this.enderecoRepository = enderecoRepository;
        this.passwordEncoder = passwordEncoder;
    }

    @Transactional
    public Secretaria criarSecretaria(SecretariaDTO dto) {
        logger.info("Tentativa de criar secretária: {}", dto.getNome());
        try {
            if (secretariaRepository.existsByEmail(dto.getEmail())) {
                throw new EmailJaCadastradoException("Email já cadastrado");
            }
            if (secretariaRepository.existsByCpf(dto.getCpf())) {
                throw new CpfJaCadastradoException("CPF já cadastrado");
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

            Secretaria saved = secretariaRepository.save(secretaria);
            logger.info("Secretária criada com sucesso. ID: {}", saved.getId());
            return saved;
        } catch (BusinessException e) {
            logger.warn("Falha ao criar secretária: {}", e.getMessage());
            throw e;
        } catch (Exception e) {
            logger.error("Erro inesperado ao criar secretária", e);
            throw e;
        }
    }

    public List<SecretariaResponseDTO> listarTodosDTO() {
        logger.debug("Listando todas as secretárias");
        List<SecretariaResponseDTO> secretarias = secretariaRepository.findAll().stream()
                .map(this::toResponseDTO)
                .collect(Collectors.toList());
        logger.debug("Encontradas {} secretárias", secretarias.size());
        return secretarias;
    }

    public SecretariaResponseDTO buscarPorIdDTO(Long id) {
        logger.debug("Buscando secretária por ID: {}", id);
        Secretaria secretaria = secretariaRepository.findById(id)
                .orElseThrow(() -> new EntidadeNaoEncontradaException("Secretária não encontrada"));
        return toResponseDTO(secretaria);
    }

    @Transactional
    public SecretariaResponseDTO atualizarSecretaria(Long id, SecretariaDTO dto) {
        logger.info("Tentativa de atualizar secretária ID: {}", id);
        try {
            Secretaria secretaria = secretariaRepository.findById(id)
                    .orElseThrow(() -> new EntidadeNaoEncontradaException("Secretária não encontrada"));

            if (dto.getNome() != null) {
                secretaria.setNome(dto.getNome());
            }
            if (dto.getEmail() != null && !dto.getEmail().equals(secretaria.getEmail())) {
                if (secretariaRepository.existsByEmail(dto.getEmail())) {
                    throw new EmailJaCadastradoException("Email já cadastrado");
                }
                secretaria.setEmail(dto.getEmail());
            }
            if (dto.getCpf() != null && !dto.getCpf().equals(secretaria.getCpf())) {
                if (secretariaRepository.existsByCpf(dto.getCpf())) {
                    throw new CpfJaCadastradoException("CPF já cadastrado");
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

            SecretariaResponseDTO response = toResponseDTO(secretariaRepository.save(secretaria));
            logger.info("Secretária atualizada com sucesso. ID: {}", id);
            return response;
        } catch (BusinessException e) {
            logger.warn("Falha ao atualizar secretária ID {}: {}", id, e.getMessage());
            throw e;
        } catch (Exception e) {
            logger.error("Erro inesperado ao atualizar secretária ID: {}", id, e);
            throw e;
        }
    }

    @Transactional
    public void excluirSecretaria(Long id) {
        logger.info("Tentativa de excluir secretária ID: {}", id);
        try {
            if (!secretariaRepository.existsById(id)) {
                throw new EntidadeNaoEncontradaException("Secretária não encontrada");
            }
            secretariaRepository.deleteById(id);
            logger.info("Secretária excluída com sucesso. ID: {}", id);
        } catch (BusinessException e) {
            logger.warn("Falha ao excluir secretária ID {}: {}", id, e.getMessage());
            throw e;
        } catch (Exception e) {
            logger.error("Erro inesperado ao excluir secretária ID: {}", id, e);
            throw e;
        }
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
