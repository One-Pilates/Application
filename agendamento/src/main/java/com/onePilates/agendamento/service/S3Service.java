package com.onePilates.agendamento.service;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import software.amazon.awssdk.core.sync.RequestBody;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.model.DeleteObjectRequest;
import software.amazon.awssdk.services.s3.model.PutObjectRequest;

@Service
public class S3Service {

    @Value("${aws.s3.bucket}")
    private String bucket;

    private final S3Client s3Client;

    public S3Service(S3Client s3Client) {
        this.s3Client = s3Client;
    }

    public String uploadFotoPerfil(MultipartFile file, Long professorId) {
        return uploadFoto(file, professorId, "professores");
    }

    public String uploadFotoSecretaria(MultipartFile file, Long secretariaId) {
        return uploadFoto(file, secretariaId, "secretarias");
    }

    public String uploadFotoAdministrador(MultipartFile file, Long administradorId) {
        return uploadFoto(file, administradorId, "administradores");
    }

    private String uploadFoto(MultipartFile file, Long entidadeId, String pasta) {
        try {
            if (file == null || file.isEmpty()) {
                throw new RuntimeException("Arquivo de imagem não pode ser vazio");
            }
            String extensao = obterExtensao(file.getOriginalFilename());
            // Gera key única para evitar cache no browser após atualização de foto.
            String key = pasta + "/" + entidadeId + "/foto-perfil-" + System.currentTimeMillis() + "." + extensao;


            PutObjectRequest request = PutObjectRequest.builder()
                    .bucket(bucket)
                    .key(key)
                    .contentType(file.getContentType())
                    .cacheControl("no-cache, no-store, must-revalidate")
                    .build();

            s3Client.putObject(request, RequestBody.fromBytes(file.getBytes()));

            return key;

        } catch (Exception e) {
            throw new RuntimeException("Erro ao fazer upload da foto", e);
        }
    }

    private String obterExtensao(String originalFilename) {
        if (originalFilename == null || originalFilename.isBlank()) {
            return "jpg";
        }

        int indicePonto = originalFilename.lastIndexOf('.');
        if (indicePonto < 0 || indicePonto == originalFilename.length() - 1) {
            return "jpg";
        }

        return originalFilename.substring(indicePonto + 1).toLowerCase();
    }

    public void removerObjeto(String key) {
        if (key == null || key.isBlank()) {
            return;
        }

        try {
            DeleteObjectRequest request = DeleteObjectRequest.builder()
                    .bucket(bucket)
                    .key(key)
                    .build();

            s3Client.deleteObject(request);
        } catch (Exception e) {
            throw new RuntimeException("Erro ao remover objeto do S3", e);
        }
    }
}