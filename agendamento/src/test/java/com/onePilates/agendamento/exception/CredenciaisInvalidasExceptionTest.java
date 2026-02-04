package com.onePilates.agendamento.exception;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

class CredenciaisInvalidasExceptionTest {

    @Test
    void construtor_DeveCriarExcecaoComCodigoCorreto() {
        CredenciaisInvalidasException ex = new CredenciaisInvalidasException("Credenciais inválidas");

        assertEquals("Credenciais inválidas", ex.getMessage());
        assertEquals("CREDENCIAIS_INVALIDAS", ex.getCodigoErro());
        assertInstanceOf(BusinessException.class, ex);
    }
}


