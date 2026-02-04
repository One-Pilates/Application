package com.onePilates.agendamento.exception;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

class CodigoExpiradoExceptionTest {

    @Test
    void construtor_DeveCriarExcecaoComCodigoCorreto() {
        CodigoExpiradoException ex = new CodigoExpiradoException("Código expirado");

        assertEquals("Código expirado", ex.getMessage());
        assertEquals("CODIGO_EXPIRADO", ex.getCodigoErro());
        assertInstanceOf(BusinessException.class, ex);
    }
}


