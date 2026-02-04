package com.onePilates.agendamento.exception;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

class EmailJaCadastradoExceptionTest {

    @Test
    void construtor_DeveCriarExcecaoComCodigoCorreto() {
        EmailJaCadastradoException ex = new EmailJaCadastradoException("Email já cadastrado");

        assertEquals("Email já cadastrado", ex.getMessage());
        assertEquals("EMAIL_JA_CADASTRADO", ex.getCodigoErro());
        assertInstanceOf(BusinessException.class, ex);
    }
}


