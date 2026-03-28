package com.onePilates.agendamento.service;

import com.onePilates.agendamento.dto.AlunoDTO;
import com.onePilates.agendamento.dto.EnderecoDTO;
import com.onePilates.agendamento.dto.response.AlunoPaginadoResponseDTO;
import com.onePilates.agendamento.dto.response.AlunoResponseDTO;
import com.onePilates.agendamento.dto.response.EnderecoResponseDTO;
import com.onePilates.agendamento.exception.EntidadeNaoEncontradaException;
import com.onePilates.agendamento.model.Aluno;
import com.onePilates.agendamento.model.Endereco;
import com.onePilates.agendamento.repository.AlunoRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


@Service
public class AlunoService {

    private static final Logger logger = LoggerFactory.getLogger(AlunoService.class);

    private final AlunoRepository alunoRepository;

    public AlunoService(AlunoRepository alunoRepository) {
        this.alunoRepository = alunoRepository;
    }

    @Transactional
    public Aluno criarAluno(AlunoDTO dto) {
        logger.info("Tentativa de criar aluno: {}", dto.getNome());
        try {
            Aluno aluno = alunoRepository.save(mapDtoToEntity(dto));
            logger.info("Aluno criado com sucesso. ID: {}", aluno.getId());
            return aluno;
        } catch (Exception e) {
            logger.error("Erro ao criar aluno", e);
            throw e;
        }
    }

    public AlunoPaginadoResponseDTO listarTodosDTO(Pageable pageable, String nome) {
        logger.debug("Listando alunos com paginacao");
        var pagina = (nome != null && !nome.isBlank())
                ? alunoRepository.findByNomeContainingIgnoreCase(nome, pageable)
                : alunoRepository.findAll(pageable);
        var paginaDto = pagina.map(this::toResponseDTO);
        logger.debug("Encontrados {} alunos na pagina", paginaDto.getNumberOfElements());
        return new AlunoPaginadoResponseDTO(
                paginaDto.getContent(),
                paginaDto.getTotalElements(),
                paginaDto.getTotalPages()
        );
    }

    public AlunoResponseDTO buscarPorIdDTO(Long id) {
        logger.debug("Buscando aluno por ID: {}", id);
        return toResponseDTO(buscarPorId(id));
    }

    @Transactional
    public AlunoResponseDTO atualizarAluno(Long id, AlunoDTO dto) {
        logger.info("Tentativa de atualizar aluno ID: {}", id);
        try {
            Aluno aluno = buscarPorId(id);

            if (dto.getNome() != null) aluno.setNome(dto.getNome());
            if (dto.getEmail() != null) aluno.setEmail(dto.getEmail());
            if (dto.getCpf() != null) aluno.setCpf(dto.getCpf());
            if (dto.getDataNascimento() != null) aluno.setDataNascimento(dto.getDataNascimento());
            if (dto.getStatus() != null) aluno.setStatus(dto.getStatus());
            if (dto.getAlunoComLimitacoesFisicas() != null) aluno.setAlunoComLimitacoesFisicas(dto.getAlunoComLimitacoesFisicas());
            if (dto.getTipoContato() != null) aluno.setTipoContato(dto.getTipoContato());
            if (dto.getNotificacaoAtiva() != null) aluno.setNotificacaoAtiva(dto.getNotificacaoAtiva());
            if (dto.getObservacao() != null) aluno.setObservacao(dto.getObservacao());

            if (dto.getEndereco() != null) {
                Endereco endereco = aluno.getEndereco() != null ? aluno.getEndereco() : new Endereco();
                EnderecoDTO e = dto.getEndereco();
                if (e.getRua() != null) endereco.setRua(e.getRua());
                if (e.getCidade() != null) endereco.setCidade(e.getCidade());
                if (e.getEstado() != null) endereco.setEstado(e.getEstado());
                if (e.getCep() != null) endereco.setCep(e.getCep());
                aluno.setEndereco(endereco);
            }

            AlunoResponseDTO response = toResponseDTO(alunoRepository.save(aluno));
            logger.info("Aluno atualizado com sucesso. ID: {}", id);
            return response;
        } catch (Exception e) {
            logger.error("Erro ao atualizar aluno ID: {}", id, e);
            throw e;
        }
    }

    @Transactional
    public void excluirAluno(Long id) {
        logger.info("Tentativa de excluir aluno ID: {}", id);
        try {
            if (!alunoRepository.existsById(id)) {
                throw new EntidadeNaoEncontradaException("Aluno não encontrado");
            }
            alunoRepository.deleteById(id);
            logger.info("Aluno excluído com sucesso. ID: {}", id);
        } catch (Exception e) {
            logger.error("Erro ao excluir aluno ID: {}", id, e);
            throw e;
        }
    }

    private Aluno buscarPorId(Long id) {
        return alunoRepository.findById(id)
                .orElseThrow(() -> new EntidadeNaoEncontradaException("Aluno não encontrado"));
    }

    private Aluno mapDtoToEntity(AlunoDTO dto) {
        Aluno aluno = new Aluno();
        aluno.setNome(dto.getNome());
        aluno.setEmail(dto.getEmail());
        aluno.setCpf(dto.getCpf());
        aluno.setDataNascimento(dto.getDataNascimento());
        aluno.setStatus(dto.getStatus());
        aluno.setAlunoComLimitacoesFisicas(dto.getAlunoComLimitacoesFisicas());
        aluno.setTipoContato(dto.getTipoContato());
        aluno.setNotificacaoAtiva(dto.getNotificacaoAtiva());
        aluno.setObservacao(dto.getObservacao());

        System.out.println(dto.getEndereco().getBairro());

        EnderecoDTO enderecoDTO = dto.getEndereco();
        Endereco endereco = new Endereco();
        endereco.setRua(enderecoDTO.getRua());
        endereco.setCidade(enderecoDTO.getCidade());
        endereco.setEstado(enderecoDTO.getEstado());
        endereco.setCep(enderecoDTO.getCep());
        endereco.setBairro(enderecoDTO.getBairro());
        endereco.setUf(enderecoDTO.getUf());
        endereco.setNumero(enderecoDTO.getNumero());
        endereco.setBairro(enderecoDTO.getBairro());
        endereco.setUf(enderecoDTO.getUf());
        endereco.setNumero(enderecoDTO.getNumero());
        aluno.setEndereco(endereco);

        return aluno;
    }

    public AlunoResponseDTO toResponseDTO(Aluno aluno) {
        AlunoResponseDTO dto = new AlunoResponseDTO();
        dto.setId(aluno.getId());
        dto.setNome(aluno.getNome());
        dto.setEmail(aluno.getEmail());
        dto.setCpf(aluno.getCpf());
        dto.setDataNascimento(aluno.getDataNascimento());
        dto.setStatus(aluno.getStatus());
        dto.setAlunoComLimitacoesFisicas(aluno.getAlunoComLimitacoesFisicas());
        dto.setTipoContato(aluno.getTipoContato());
        dto.setNotificacaoAtiva(aluno.getNotificacaoAtiva());
        dto.setObservacao(aluno.getObservacao());

        EnderecoResponseDTO enderecoDTO = new EnderecoResponseDTO();
        enderecoDTO.setRua(aluno.getEndereco().getRua());
        enderecoDTO.setCidade(aluno.getEndereco().getCidade());
        enderecoDTO.setEstado(aluno.getEndereco().getEstado());
        enderecoDTO.setCep(aluno.getEndereco().getCep());
        enderecoDTO.setBairro(aluno.getEndereco().getBairro());
        enderecoDTO.setUf(aluno.getEndereco().getUf());
        enderecoDTO.setNumero(aluno.getEndereco().getNumero());
        dto.setEndereco(enderecoDTO);

        return dto;
    }
}
