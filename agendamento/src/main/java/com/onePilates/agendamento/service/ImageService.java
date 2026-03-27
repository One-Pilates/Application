package com.onePilates.agendamento.service;

import com.onePilates.agendamento.exception.BusinessException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Arrays;
import java.util.List;

@Service
public class ImageService {
    @Value("${app.upload.dir:imagens}")
    private String uploadDir;

    private static final Logger logger = LoggerFactory.getLogger(ImageService.class);
    private static final long MAX_FILE_SIZE = 5 * 1024 * 1024; // 5MB
    private static final List<String> ALLOWED_CONTENT_TYPES = Arrays.asList(
            "image/jpeg", "image/jpg", "image/png", "image/gif", "image/webp"
    );

    private String getUploadDirectory() {
        String dir = (uploadDir != null && !uploadDir.trim().isEmpty()) ? uploadDir : "imagens";

        File currentDir = new File(System.getProperty("user.dir"));
        File projectDir = currentDir;

        while (projectDir != null && !new File(projectDir, "pom.xml").exists()) {
            projectDir = projectDir.getParentFile();
        }

        if (projectDir != null && new File(projectDir, "pom.xml").exists()) {
            String projectPath = projectDir.getAbsolutePath();
            if (projectPath != null && !projectPath.isEmpty()) {
                Path uploadPath = Paths.get(projectPath, dir);
                return uploadPath.toString() + File.separator;
            }
        }

        String currentPath = currentDir.getAbsolutePath();
        if (currentPath != null && !currentPath.isEmpty()) {
            Path uploadPath = Paths.get(currentPath, dir);
            return uploadPath.toString() + File.separator;
        }

        return dir + File.separator;
    }

    public String salvarImagem(Long id, MultipartFile file, String tipoFuncionario) {
        if (file == null || file.isEmpty()) {
            throw new BusinessException("Arquivo de imagem não pode ser vazio");
        }

        validarArquivo(file);

        try {
            String uploadDirectory = getUploadDirectory();
            logger.info("Diretório de upload: {}", uploadDirectory);

            File dir = new File(uploadDirectory);
            if (!dir.exists()) {
                boolean criado = dir.mkdirs();
                if (!criado) {
                    logger.error("Não foi possível criar o diretório de imagens: {}", uploadDirectory);
                    throw new BusinessException("Erro ao criar diretório de imagens");
                }
                logger.info("Diretório de imagens criado: {}", uploadDirectory);
            }

            String extension = obterExtensao(file.getOriginalFilename());
            String fileName = String.format("%s_%d_%d.%s", tipoFuncionario, id, System.currentTimeMillis(), extension);
            Path filePath = Paths.get(uploadDirectory, fileName);

            Files.write(filePath, file.getBytes());
            logger.info("Imagem salva com sucesso: {}", filePath.toString());

            return fileName;
        } catch (IOException e) {
            logger.error("Erro ao salvar imagem: {}", e.getMessage(), e);
            throw new BusinessException("Erro ao salvar imagem: " + e.getMessage());
        }
    }

    public String atualizarImagem(Long id, MultipartFile file, String fotoAntiga, String tipoFuncionario) {
        if (fotoAntiga != null && !fotoAntiga.isBlank()) {
            removerImagem(fotoAntiga);
        }
        return salvarImagem(id, file, tipoFuncionario);
    }

    public void removerImagem(String caminhoImagem) {
        if (caminhoImagem == null || caminhoImagem.isBlank()) {
            return;
        }

        try {
            String uploadDirectory = getUploadDirectory();
            File arquivo;

            String nomeArquivo = caminhoImagem;

            if (nomeArquivo.startsWith("imagens/") || nomeArquivo.startsWith("imagens\\")) {
                nomeArquivo = nomeArquivo.substring("imagens/".length());
            }

            if (nomeArquivo.contains(File.separator) || nomeArquivo.contains("/") || nomeArquivo.contains("\\")) {
                if (nomeArquivo.length() > 2 && nomeArquivo.charAt(1) == ':') {
                    nomeArquivo = new File(nomeArquivo).getName();
                } else if (nomeArquivo.contains(File.separator) || nomeArquivo.contains("/") || nomeArquivo.contains("\\")) {
                    int lastIndex = Math.max(
                        nomeArquivo.lastIndexOf(File.separator),
                        Math.max(nomeArquivo.lastIndexOf("/"), nomeArquivo.lastIndexOf("\\"))
                    );
                    if (lastIndex >= 0 && lastIndex < nomeArquivo.length() - 1) {
                        nomeArquivo = nomeArquivo.substring(lastIndex + 1);
                    }
                }
            }

            if (nomeArquivo == null || nomeArquivo.trim().isEmpty()) {
                logger.warn("Não foi possível extrair o nome do arquivo de: {}", caminhoImagem);
                return;
            }

            if (!nomeArquivo.matches("^(professor|secretaria|administrador)_\\d+_\\d+\\.(jpg|jpeg|png|gif|webp)$")) {
                logger.warn("Tentativa de remover arquivo com formato inválido: {}. Arquivo não será removido por segurança.", nomeArquivo);
                return;
            }

            arquivo = new File(uploadDirectory, nomeArquivo);

            try {
                String arquivoCanonical = arquivo.getCanonicalPath();
                String uploadCanonical = new File(uploadDirectory).getCanonicalPath();

                if (!arquivoCanonical.startsWith(uploadCanonical)) {
                    logger.warn("Tentativa de remover arquivo fora do diretório de upload: {}. Operação bloqueada por segurança.", arquivoCanonical);
                    return;
                }
            } catch (IOException e) {
                logger.warn("Erro ao validar caminho do arquivo: {}", e.getMessage());
                return;
            }

            if (arquivo.exists()) {
                boolean deletado = arquivo.delete();
                if (!deletado) {
                    logger.warn("Não foi possível deletar a imagem: {}", arquivo.getAbsolutePath());
                } else {
                    logger.info("Imagem removida com sucesso: {}", arquivo.getAbsolutePath());
                }
            } else {
                logger.warn("Imagem não encontrada para remoção: {}", arquivo.getAbsolutePath());
            }
        } catch (Exception e) {
            logger.warn("Erro ao tentar remover imagem {}: {}", caminhoImagem, e.getMessage());
        }
    }

    private void validarArquivo(MultipartFile file) {
        if (file.getSize() > MAX_FILE_SIZE) {
            throw new BusinessException("Arquivo muito grande. Tamanho máximo: 5MB");
        }

        String contentType = file.getContentType();
        if (contentType == null || !ALLOWED_CONTENT_TYPES.contains(contentType.toLowerCase())) {
            throw new BusinessException("Tipo de arquivo não permitido. Use: JPEG, PNG, GIF ou WEBP");
        }
    }

    private String obterExtensao(String fileName) {
        if (fileName == null || fileName.isEmpty()) {
            return "jpg";
        }

        int lastDot = fileName.lastIndexOf('.');
        if (lastDot > 0 && lastDot < fileName.length() - 1) {
            return fileName.substring(lastDot + 1).toLowerCase();
        }
        return "jpg";
    }
}
