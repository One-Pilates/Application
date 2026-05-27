package com.onePilates.agendamento.controller;

import com.onePilates.agendamento.exception.EntidadeNaoEncontradaException;
import com.onePilates.agendamento.model.Funcionario;
import com.onePilates.agendamento.repository.FuncionarioRepository;
import com.onePilates.agendamento.service.S3Service;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.core.io.Resource;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/imagens")
@CrossOrigin(origins = "*")
public class ImagemController {

    private final FuncionarioRepository funcionarioRepository;
    private final S3Service s3Service;

    public ImagemController(FuncionarioRepository funcionarioRepository, S3Service s3Service) {
        this.funcionarioRepository = funcionarioRepository;
        this.s3Service = s3Service;
    }

    @GetMapping("/funcionarios/{id}")
    public ResponseEntity<Resource> servirImagemFuncionario(@PathVariable Long id) {
        Funcionario funcionario = funcionarioRepository.findById(id)
                .orElseThrow(() -> new EntidadeNaoEncontradaException("Funcionário não encontrado"));

        if (funcionario.getFoto() == null || funcionario.getFoto().isBlank()) {
            return ResponseEntity.notFound().build();
        }

        S3Service.DownloadS3Objeto download = s3Service.baixarObjeto(funcionario.getFoto());
        MediaType mediaType = download.contentType() != null && !download.contentType().isBlank()
                ? MediaType.parseMediaType(download.contentType())
                : MediaType.APPLICATION_OCTET_STREAM;

        return ResponseEntity.ok()
                .contentType(mediaType)
                .body(new ByteArrayResource(download.conteudo()));
    }
}
