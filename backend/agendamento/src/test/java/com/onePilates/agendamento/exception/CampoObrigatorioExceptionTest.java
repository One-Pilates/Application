package com.onePilates.agendamento.exception;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

class CampoObrigatorioExceptionTest {

    @Test
    void construtor_DeveCriarExcecaoComCodigoCorreto() {
        CampoObrigatorioException ex = new CampoObrigatorioException("Campo obrigatório");

        assertEquals("Campo obrigatório", ex.getMessage());
        assertEquals("CAMPO_OBRIGATORIO", ex.getCodigoErro());
        assertInstanceOf(BusinessException.class, ex);
    }
}


