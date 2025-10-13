package com.onePilates.agendamento.service;

import com.onePilates.agendamento.dto.AlunoDTO;
import com.onePilates.agendamento.dto.EnderecoDTO;
import com.onePilates.agendamento.dto.response.AlunoResponseDTO;
import com.onePilates.agendamento.dto.response.EnderecoResponseDTO;
import com.onePilates.agendamento.model.Aluno;
import com.onePilates.agendamento.model.Endereco;
import com.onePilates.agendamento.repository.AlunoRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class AlunoService {

    @Autowired
    private AlunoRepository alunoRepository;

    public Aluno criarAluno(AlunoDTO dto) {
        return alunoRepository.save(mapDtoToEntity(dto));
    }

    public List<AlunoResponseDTO> listarTodosDTO() {
        return alunoRepository.findAll()
                .stream()
                .map(this::toResponseDTO)
                .collect(Collectors.toList());
    }

    public AlunoResponseDTO buscarPorIdDTO(Long id) {
        return toResponseDTO(buscarPorId(id));
    }

    public AlunoResponseDTO atualizarAluno(Long id, AlunoDTO dto) {
        Aluno aluno = mapDtoToEntity(dto);
        aluno.setId(id);
        return toResponseDTO(alunoRepository.save(aluno));
    }

    public void excluirAluno(Long id) {
        alunoRepository.deleteById(id);
    }

    private Aluno buscarPorId(Long id) {
        return alunoRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Aluno não encontrado"));
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

        EnderecoDTO enderecoDTO = dto.getEndereco();
        Endereco endereco = new Endereco();
        endereco.setRua(enderecoDTO.getRua());
        endereco.setCidade(enderecoDTO.getCidade());
        endereco.setEstado(enderecoDTO.getEstado());
        endereco.setCep(enderecoDTO.getCep());
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

        EnderecoResponseDTO enderecoDTO = new EnderecoResponseDTO();
        enderecoDTO.setRua(aluno.getEndereco().getRua());
        enderecoDTO.setCidade(aluno.getEndereco().getCidade());
        enderecoDTO.setEstado(aluno.getEndereco().getEstado());
        enderecoDTO.setCep(aluno.getEndereco().getCep());
        dto.setEndereco(enderecoDTO);

        return dto;
    }
}
