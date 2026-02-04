package com.onePilates.agendamento.exception;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

class CodigoInvalidoExceptionTest {

    @Test
    void construtor_DeveCriarExcecaoComCodigoCorreto() {
        CodigoInvalidoException ex = new CodigoInvalidoException("Código inválido");

        assertEquals("Código inválido", ex.getMessage());
        assertEquals("CODIGO_INVALIDO", ex.getCodigoErro());
        assertInstanceOf(BusinessException.class, ex);
    }
}


