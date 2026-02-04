package com.onePilates.agendamento.exception;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

class CpfJaCadastradoExceptionTest {

    @Test
    void construtor_DeveCriarExcecaoComCodigoCorreto() {
        CpfJaCadastradoException ex = new CpfJaCadastradoException("CPF já cadastrado");

        assertEquals("CPF já cadastrado", ex.getMessage());
        assertEquals("CPF_JA_CADASTRADO", ex.getCodigoErro());
        assertInstanceOf(BusinessException.class, ex);
    }
}


