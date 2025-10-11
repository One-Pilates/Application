package com.onePilates.agendamento.service;

import com.onePilates.agendamento.dto.EnderecoDTO;
import com.onePilates.agendamento.model.Endereco;
import com.onePilates.agendamento.repository.EnderecoRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class EnderecoService {

    private final EnderecoRepository repository;

    public EnderecoService(EnderecoRepository repository) {
        this.repository = repository;
    }

    public Endereco cadastrarEndereco(EnderecoDTO dto) {
        Endereco endereco = new Endereco(
                dto.getLogradouro(),
                dto.getNumero(),
                dto.getBairro(),
                dto.getCidade(),
                dto.getEstado(),
                dto.getCep(),
                dto.getUf()
        );

        return repository.save(endereco);
    }

    public List<Endereco> verTodosOsEnderecos() {
        return repository.findAll();
    }
}

