package com.onePilates.agendamento.controller;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import jakarta.servlet.http.HttpServletRequest;
import java.io.File;
import java.nio.file.Path;
import java.nio.file.Paths;

@RestController
@RequestMapping("/api/imagens")
@CrossOrigin(origins = "*")
public class ImagemController {

    @Value("${app.upload.dir:imagens}")
    private String uploadDir;

    @GetMapping(value = "/**", produces = {MediaType.IMAGE_JPEG_VALUE, MediaType.IMAGE_PNG_VALUE, MediaType.IMAGE_GIF_VALUE, "image/webp"})
    public ResponseEntity<Resource> servirImagem(HttpServletRequest request) {
        try {
            String requestPath = request.getRequestURI();
            String caminhoRelativo = requestPath.substring("/api/imagens/".length());

            if (caminhoRelativo.startsWith("imagens/")) {
                caminhoRelativo = caminhoRelativo.substring("imagens/".length());
            }

            String uploadDirectory = getUploadDirectory();

            Path filePath = Paths.get(uploadDirectory, caminhoRelativo).normalize();

            File file = filePath.toFile();

            if (!file.exists() || !file.isFile()) {
                return ResponseEntity.notFound().build();
            }

            Resource resource = new FileSystemResource(file);

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

    private String getUploadDirectory() {
        File currentDir = new File(System.getProperty("user.dir"));
        File projectDir = currentDir;

        while (projectDir != null && !new File(projectDir, "pom.xml").exists()) {
            projectDir = projectDir.getParentFile();
        }

        if (projectDir != null && new File(projectDir, "pom.xml").exists()) {
            Path uploadPath = Paths.get(projectDir.getAbsolutePath(), uploadDir);
            return uploadPath.toString() + File.separator;
        }

        Path uploadPath = Paths.get(currentDir.getAbsolutePath(), uploadDir);
        return uploadPath.toString() + File.separator;
    }
}
