package com.onePilates.agendamento.exception;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

class BusinessExceptionTest {

    @Test
    void construtor_ComMensagemECodigo_DeveCriarExcecaoCorretamente() {
        BusinessException ex = new BusinessException("Mensagem de erro", "CODIGO_ERRO");

        assertEquals("Mensagem de erro", ex.getMessage());
        assertEquals("CODIGO_ERRO", ex.getCodigoErro());
    }

    @Test
    void construtor_ComMensagemApenas_DeveCriarExcecaoComCodigoPadrao() {
        BusinessException ex = new BusinessException("Mensagem de erro");

        assertEquals("Mensagem de erro", ex.getMessage());
        assertEquals("BUSINESS_ERROR", ex.getCodigoErro());
    }

    @Test
    void construtor_DeveHerdarDeRuntimeException() {
        BusinessException ex = new BusinessException("Erro");

        assertInstanceOf(RuntimeException.class, ex);
    }
}


