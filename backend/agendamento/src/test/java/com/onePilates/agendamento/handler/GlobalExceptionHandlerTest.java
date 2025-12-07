package com.onePilates.agendamento.handler;

import com.onePilates.agendamento.exception.BusinessException;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.MethodArgumentNotValidException;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class GlobalExceptionHandlerTest {

    @InjectMocks
    private GlobalExceptionHandler handler;

    @Test
    void tratarErrosDeValidacao_DeveRetornar400_ComErrosDeValidacao() {
        MethodArgumentNotValidException excecao = mock(MethodArgumentNotValidException.class);
        BindingResult bindingResult = mock(BindingResult.class);
        
        List<FieldError> fieldErrors = new ArrayList<>();
        fieldErrors.add(new FieldError("objeto", "campo1", "Erro no campo 1"));
        fieldErrors.add(new FieldError("objeto", "campo2", "Erro no campo 2"));
        
        when(excecao.getBindingResult()).thenReturn(bindingResult);
        when(bindingResult.getFieldErrors()).thenReturn(fieldErrors);

        ResponseEntity<Map<String, String>> response = handler.tratarErrosDeValidacao(excecao);

        assertEquals(HttpStatus.BAD_REQUEST, response.getStatusCode());
        assertNotNull(response.getBody());
        assertEquals("Erro no campo 1", response.getBody().get("campo1"));
        assertEquals("Erro no campo 2", response.getBody().get("campo2"));
    }

    @Test
    void tratarErrosDeValidacao_DeveRetornar400_QuandoNaoHaErros() {
        MethodArgumentNotValidException excecao = mock(MethodArgumentNotValidException.class);
        BindingResult bindingResult = mock(BindingResult.class);
        
        when(excecao.getBindingResult()).thenReturn(bindingResult);
        when(bindingResult.getFieldErrors()).thenReturn(new ArrayList<>());

        ResponseEntity<Map<String, String>> response = handler.tratarErrosDeValidacao(excecao);

        assertEquals(HttpStatus.BAD_REQUEST, response.getStatusCode());
        assertNotNull(response.getBody());
        assertTrue(response.getBody().isEmpty());
    }

    @Test
    void tratarErrosDeBanco_DeveRetornar409_QuandoErroCPF() {
        SQLException sqlException = new SQLException("Unique constraint violation: cpf_unique");
        DataIntegrityViolationException excecao = new DataIntegrityViolationException("Erro", sqlException);

        ResponseEntity<Map<String, String>> response = handler.tratarErrosDeBanco(excecao);

        assertEquals(HttpStatus.CONFLICT, response.getStatusCode());
        assertNotNull(response.getBody());
        assertEquals("Já existe um funcionário com esse CPF cadastrado.", response.getBody().get("erro"));
    }

    @Test
    void tratarErrosDeBanco_DeveRetornar409_QuandoErroEmail() {
        SQLException sqlException = new SQLException("Unique constraint violation: email_unique");
        DataIntegrityViolationException excecao = new DataIntegrityViolationException("Erro", sqlException);

        ResponseEntity<Map<String, String>> response = handler.tratarErrosDeBanco(excecao);

        assertEquals(HttpStatus.CONFLICT, response.getStatusCode());
        assertNotNull(response.getBody());
        assertEquals("Já existe um funcionário com esse e-mail cadastrado.", response.getBody().get("erro"));
    }

    @Test
    void tratarErrosDeBanco_DeveRetornar409_QuandoErroGenerico() {
        SQLException sqlException = new SQLException("Outro erro de integridade");
        DataIntegrityViolationException excecao = new DataIntegrityViolationException("Erro", sqlException);

        ResponseEntity<Map<String, String>> response = handler.tratarErrosDeBanco(excecao);

        assertEquals(HttpStatus.CONFLICT, response.getStatusCode());
        assertNotNull(response.getBody());
        assertEquals("Erro de integridade nos dados. Verifique os campos únicos.", response.getBody().get("erro"));
    }

    @Test
    void tratarErrosDeBanco_DeveRetornar409_QuandoMostSpecificCauseENull() {
        DataIntegrityViolationException excecao = new DataIntegrityViolationException("Erro", null);

        ResponseEntity<Map<String, String>> response = handler.tratarErrosDeBanco(excecao);

        assertEquals(HttpStatus.CONFLICT, response.getStatusCode());
        assertNotNull(response.getBody());
        assertEquals("Erro de integridade nos dados. Verifique os campos únicos.", response.getBody().get("erro"));
    }

    @Test
    void handleBusinessException_DeveRetornar400_ComMensagemECodigo() {
        BusinessException ex = new BusinessException("Erro de negócio", "CODIGO_ERRO");

        ResponseEntity<Map<String, String>> response = handler.handleBusinessException(ex);

        assertEquals(HttpStatus.BAD_REQUEST, response.getStatusCode());
        assertNotNull(response.getBody());
        assertEquals("Erro de negócio", response.getBody().get("erro"));
        assertEquals("CODIGO_ERRO", response.getBody().get("codigoErro"));
    }

    @Test
    void handleBusinessException_DeveRetornar400_ComCodigoPadrao() {
        BusinessException ex = new BusinessException("Erro de negócio");

        ResponseEntity<Map<String, String>> response = handler.handleBusinessException(ex);

        assertEquals(HttpStatus.BAD_REQUEST, response.getStatusCode());
        assertNotNull(response.getBody());
        assertEquals("Erro de negócio", response.getBody().get("erro"));
        assertEquals("BUSINESS_ERROR", response.getBody().get("codigoErro"));
    }

    @Test
    void handleAccessDenied_DeveRetornar403_ComMensagem() {
        AccessDeniedException ex = new AccessDeniedException("Acesso negado");

        ResponseEntity<String> response = handler.handleAccessDenied(ex);

        assertEquals(HttpStatus.FORBIDDEN, response.getStatusCode());
        assertEquals("Acesso negado", response.getBody());
    }

    @Test
    void handleAccessDenied_DeveRetornar403_ComMensagemPadrao_QuandoMensagemENull() {
        AccessDeniedException ex = new AccessDeniedException(null);

        ResponseEntity<String> response = handler.handleAccessDenied(ex);

        assertEquals(HttpStatus.FORBIDDEN, response.getStatusCode());
        assertEquals("Access Denied", response.getBody());
    }

    @Test
    void handleRuntime_DeveRetornar400_ComMensagem() {
        RuntimeException ex = new RuntimeException("Erro runtime");

        ResponseEntity<String> response = handler.handleRuntime(ex);

        assertEquals(HttpStatus.BAD_REQUEST, response.getStatusCode());
        assertEquals("Erro runtime", response.getBody());
    }

    @Test
    void handleRuntime_DeveRetornar400_ComMensagemPadrao_QuandoMensagemENull() {
        RuntimeException ex = new RuntimeException((String) null);

        ResponseEntity<String> response = handler.handleRuntime(ex);

        assertEquals(HttpStatus.BAD_REQUEST, response.getStatusCode());
        assertEquals("Erro", response.getBody());
    }

    @Test
    void tratarErroGenerico_DeveRetornar500() {
        Exception excecao = new Exception("Erro interno");

        ResponseEntity<Map<String, String>> response = handler.tratarErroGenerico(excecao);

        assertEquals(HttpStatus.INTERNAL_SERVER_ERROR, response.getStatusCode());
        assertNotNull(response.getBody());
        assertEquals("Erro interno no servidor. Por favor, tente novamente mais tarde.", response.getBody().get("erro"));
    }

    @Test
    void tratarErroGenerico_DeveRetornar500_QuandoExcecaoENull() {
        Exception excecao = new Exception();

        ResponseEntity<Map<String, String>> response = handler.tratarErroGenerico(excecao);

        assertEquals(HttpStatus.INTERNAL_SERVER_ERROR, response.getStatusCode());
        assertNotNull(response.getBody());
        assertEquals("Erro interno no servidor. Por favor, tente novamente mais tarde.", response.getBody().get("erro"));
    }
}

