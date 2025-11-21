package com.onePilates.agendamento.service;

import com.onePilates.agendamento.exception.BusinessException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
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
    private static final String UPLOAD_DIR = "imagens/";
    private static final Logger logger = LoggerFactory.getLogger(ImageService.class);
    private static final long MAX_FILE_SIZE = 5 * 1024 * 1024; // 5MB
    private static final List<String> ALLOWED_CONTENT_TYPES = Arrays.asList(
            "image/jpeg", "image/jpg", "image/png", "image/gif", "image/webp"
    );

    /**
     * Salva uma imagem no disco e retorna o caminho do arquivo
     * @param id ID do funcionário
     * @param file Arquivo de imagem
     * @param tipoFuncionario Tipo do funcionário (professor, secretaria, administrador) para prefixo do arquivo
     * @return Caminho do arquivo salvo
     * @throws BusinessException Se houver erro na validação ou salvamento
     */
    public String salvarImagem(Long id, MultipartFile file, String tipoFuncionario) {
        if (file == null || file.isEmpty()) {
            throw new BusinessException("Arquivo de imagem não pode ser vazio");
        }

        validarArquivo(file);

        try {
            // Cria pasta se não existir
            File dir = new File(UPLOAD_DIR);
            if (!dir.exists()) {
                boolean criado = dir.mkdirs();
                if (!criado) {
                    logger.error("Não foi possível criar o diretório de imagens: {}", UPLOAD_DIR);
                    throw new BusinessException("Erro ao criar diretório de imagens");
                }
            }

            // Gera nome único para o arquivo
            String extension = obterExtensao(file.getOriginalFilename());
            String fileName = String.format("%s_%d_%d.%s", tipoFuncionario, id, System.currentTimeMillis(), extension);
            Path filePath = Paths.get(UPLOAD_DIR, fileName);

            // Salva arquivo no disco
            Files.write(filePath, file.getBytes());
            logger.info("Imagem salva com sucesso: {}", filePath.toString());

            return filePath.toString();
        } catch (IOException e) {
            logger.error("Erro ao salvar imagem: {}", e.getMessage(), e);
            throw new BusinessException("Erro ao salvar imagem: " + e.getMessage());
        }
    }

    /**
     * Atualiza a imagem de um funcionário, removendo a anterior se existir
     * @param id ID do funcionário
     * @param file Novo arquivo de imagem
     * @param fotoAntiga Caminho da foto antiga (pode ser null)
     * @param tipoFuncionario Tipo do funcionário para prefixo do arquivo
     * @return Caminho do novo arquivo salvo
     */
    public String atualizarImagem(Long id, MultipartFile file, String fotoAntiga, String tipoFuncionario) {
        // Remove foto anterior se existir
        if (fotoAntiga != null && !fotoAntiga.isBlank()) {
            removerImagem(fotoAntiga);
        }

        // Salva nova imagem
        return salvarImagem(id, file, tipoFuncionario);
    }

    /**
     * Remove uma imagem do disco
     * @param caminhoImagem Caminho da imagem a ser removida
     */
    public void removerImagem(String caminhoImagem) {
        if (caminhoImagem == null || caminhoImagem.isBlank()) {
            return;
        }

        try {
            File arquivo = new File(caminhoImagem);
            if (arquivo.exists()) {
                boolean deletado = arquivo.delete();
                if (!deletado) {
                    logger.warn("Não foi possível deletar a imagem: {}", caminhoImagem);
                } else {
                    logger.info("Imagem removida com sucesso: {}", caminhoImagem);
                }
            }
        } catch (Exception e) {
            logger.warn("Erro ao tentar remover imagem {}: {}", caminhoImagem, e.getMessage());
        }
    }

    /**
     * Valida o arquivo de imagem
     * @param file Arquivo a ser validado
     * @throws BusinessException Se o arquivo for inválido
     */
    private void validarArquivo(MultipartFile file) {
        if (file.getSize() > MAX_FILE_SIZE) {
            throw new BusinessException("Arquivo muito grande. Tamanho máximo: 5MB");
        }

        String contentType = file.getContentType();
        if (contentType == null || !ALLOWED_CONTENT_TYPES.contains(contentType.toLowerCase())) {
            throw new BusinessException("Tipo de arquivo não permitido. Use: JPEG, PNG, GIF ou WEBP");
        }
    }

    /**
     * Obtém a extensão do arquivo
     * @param fileName Nome do arquivo
     * @return Extensão do arquivo (sem o ponto)
     */
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

