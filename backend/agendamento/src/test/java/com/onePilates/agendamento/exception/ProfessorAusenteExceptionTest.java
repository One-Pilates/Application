package com.onePilates.agendamento.exception;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

class ProfessorAusenteExceptionTest {

    @Test
    void construtor_DeveCriarExcecaoComCodigoCorreto() {
        ProfessorAusenteException ex = new ProfessorAusenteException("Professor ausente");

        assertEquals("Professor ausente", ex.getMessage());
        assertEquals("PROFESSOR_AUSENTE", ex.getCodigoErro());
        assertInstanceOf(BusinessException.class, ex);
    }
}


