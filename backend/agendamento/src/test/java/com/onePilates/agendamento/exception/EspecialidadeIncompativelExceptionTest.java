package com.onePilates.agendamento.exception;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

class EspecialidadeIncompativelExceptionTest {

    @Test
    void construtor_DeveCriarExcecaoComCodigoCorreto() {
        EspecialidadeIncompativelException ex = new EspecialidadeIncompativelException("Especialidade incompatível");

        assertEquals("Especialidade incompatível", ex.getMessage());
        assertEquals("ESPECIALIDADE_INCOMPATIVEL", ex.getCodigoErro());
        assertInstanceOf(BusinessException.class, ex);
    }
}


