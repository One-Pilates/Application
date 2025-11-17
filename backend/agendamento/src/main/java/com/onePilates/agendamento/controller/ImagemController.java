package com.onePilates.agendamento.controller;

import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import jakarta.servlet.http.HttpServletRequest;
import java.io.File;
import java.nio.file.Path;
import java.nio.file.Paths;

@RestController
@RequestMapping("/api/imagens")
@CrossOrigin(origins = "*")
public class ImagemController {

    private static final String UPLOAD_DIR = "imagens/";

    @GetMapping(value = "/**", produces = {MediaType.IMAGE_JPEG_VALUE, MediaType.IMAGE_PNG_VALUE, MediaType.IMAGE_GIF_VALUE, "image/webp"})
    @PreAuthorize("isAuthenticated()")
    public ResponseEntity<Resource> servirImagem(HttpServletRequest request) {
        try {
            // Extrair o caminho da URL (tudo após /api/imagens/)
            String requestPath = request.getRequestURI();
            String caminhoRelativo = requestPath.substring("/api/imagens/".length());
            
            // O caminho já vem completo (ex: "imagens/professor_3_1234567890.jpg")
            // Se vier sem "imagens/", adicionar
            String caminhoCompleto = caminhoRelativo.startsWith("imagens/") 
                ? caminhoRelativo 
                : UPLOAD_DIR + caminhoRelativo;
            
            // Construir o caminho completo do arquivo
            Path filePath = Paths.get(caminhoCompleto);
            File file = filePath.toFile();

            if (!file.exists() || !file.isFile()) {
                return ResponseEntity.notFound().build();
            }

            Resource resource = new FileSystemResource(file);

            // Determinar o tipo de conteúdo baseado na extensão
            String contentType = determinarContentType(file.getName());

            return ResponseEntity.ok()
                    .contentType(MediaType.parseMediaType(contentType))
                    .header(HttpHeaders.CONTENT_DISPOSITION, "inline; filename=\"" + file.getName() + "\"")
                    .body(resource);
        } catch (Exception e) {
            return ResponseEntity.notFound().build();
        }
    }

    private String determinarContentType(String fileName) {
        String lowerCase = fileName.toLowerCase();
        if (lowerCase.endsWith(".jpg") || lowerCase.endsWith(".jpeg")) {
            return "image/jpeg";
        } else if (lowerCase.endsWith(".png")) {
            return "image/png";
        } else if (lowerCase.endsWith(".gif")) {
            return "image/gif";
        } else if (lowerCase.endsWith(".webp")) {
            return "image/webp";
        }
        return "application/octet-stream";
    }
}

