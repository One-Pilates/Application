package com.onePilates.agendamento.exception;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

class ProfessorInativoExceptionTest {

    @Test
    void construtor_DeveCriarExcecaoComCodigoCorreto() {
        ProfessorInativoException ex = new ProfessorInativoException("Professor inativo");

        assertEquals("Professor inativo", ex.getMessage());
        assertEquals("PROFESSOR_INATIVO", ex.getCodigoErro());
        assertInstanceOf(BusinessException.class, ex);
    }
}


