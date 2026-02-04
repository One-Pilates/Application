package com.onePilates.agendamento.service;

import com.onePilates.agendamento.exception.BusinessException;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class ImageServiceTest {

    @InjectMocks
    private ImageService imageService;

    private MultipartFile file;

    @BeforeEach
    void setUp() {
        file = mock(MultipartFile.class);
    }

    @Test
    void salvarImagem_DeveLancarExcecao_QuandoArquivoNulo() {
        assertThrows(BusinessException.class, () -> {
            imageService.salvarImagem(1L, null, "professor");
        });
    }

    @Test
    void salvarImagem_DeveLancarExcecao_QuandoArquivoVazio() {
        when(file.isEmpty()).thenReturn(true);

        assertThrows(BusinessException.class, () -> {
            imageService.salvarImagem(1L, file, "professor");
        });
    }

    @Test
    void salvarImagem_DeveLancarExcecao_QuandoArquivoMuitoGrande() {
        when(file.isEmpty()).thenReturn(false);
        when(file.getSize()).thenReturn(10L * 1024 * 1024); // 10MB

        assertThrows(BusinessException.class, () -> {
            imageService.salvarImagem(1L, file, "professor");
        });
    }

    @Test
    void salvarImagem_DeveLancarExcecao_QuandoTipoNaoPermitido() {
        when(file.isEmpty()).thenReturn(false);
        when(file.getSize()).thenReturn(1024L); // 1KB
        when(file.getContentType()).thenReturn("application/pdf");

        assertThrows(BusinessException.class, () -> {
            imageService.salvarImagem(1L, file, "professor");
        });
    }

    @Test
    void salvarImagem_DeveLancarExcecao_QuandoContentTypeNulo() {
        when(file.isEmpty()).thenReturn(false);
        when(file.getSize()).thenReturn(1024L);
        when(file.getContentType()).thenReturn(null);

        assertThrows(BusinessException.class, () -> {
            imageService.salvarImagem(1L, file, "professor");
        });
    }

    @Test
    void atualizarImagem_DeveRemoverFotoAntiga_QuandoFotoAntigaExiste() throws Exception {
        MultipartFile novoFile = mock(MultipartFile.class);
        when(novoFile.isEmpty()).thenReturn(false);
        when(novoFile.getSize()).thenReturn(1024L);
        when(novoFile.getContentType()).thenReturn("image/jpeg");
        when(novoFile.getOriginalFilename()).thenReturn("test.jpg");
        when(novoFile.getBytes()).thenReturn(new byte[]{1, 2, 3});

        // Criar arquivo temporário para simular foto antiga
        File tempDir = new File("imagens");
        if (!tempDir.exists()) {
            tempDir.mkdirs();
        }
        File fotoAntiga = new File("imagens/foto_antiga.jpg");
        fotoAntiga.createNewFile();

        try {
            String result = imageService.atualizarImagem(1L, novoFile, "imagens/foto_antiga.jpg", "professor");
            assertNotNull(result);
            assertFalse(fotoAntiga.exists()); // Foto antiga deve ser removida
        } finally {
            if (fotoAntiga.exists()) {
                fotoAntiga.delete();
            }
        }
    }

    @Test
    void atualizarImagem_DeveSalvarNovaImagem_QuandoFotoAntigaNula() throws Exception {
        MultipartFile novoFile = mock(MultipartFile.class);
        when(novoFile.isEmpty()).thenReturn(false);
        when(novoFile.getSize()).thenReturn(1024L);
        when(novoFile.getContentType()).thenReturn("image/jpeg");
        when(novoFile.getOriginalFilename()).thenReturn("test.jpg");
        when(novoFile.getBytes()).thenReturn(new byte[]{1, 2, 3});

        String result = imageService.atualizarImagem(1L, novoFile, null, "professor");

        assertNotNull(result);
    }

    @Test
    void removerImagem_DeveRemoverArquivo_QuandoArquivoExiste() throws Exception {
        File tempDir = new File("imagens");
        if (!tempDir.exists()) {
            tempDir.mkdirs();
        }
        File arquivo = new File("imagens/teste.jpg");
        arquivo.createNewFile();

        try {
            imageService.removerImagem("imagens/teste.jpg");
            assertFalse(arquivo.exists());
        } finally {
            if (arquivo.exists()) {
                arquivo.delete();
            }
        }
    }

    @Test
    void removerImagem_DeveRetornarSemErro_QuandoCaminhoNulo() {
        assertDoesNotThrow(() -> {
            imageService.removerImagem(null);
        });
    }

    @Test
    void removerImagem_DeveRetornarSemErro_QuandoCaminhoVazio() {
        assertDoesNotThrow(() -> {
            imageService.removerImagem("");
        });
    }

    @Test
    void removerImagem_DeveRetornarSemErro_QuandoArquivoNaoExiste() {
        assertDoesNotThrow(() -> {
            imageService.removerImagem("imagens/arquivo_inexistente.jpg");
        });
    }
}

