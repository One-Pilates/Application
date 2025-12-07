package com.onePilates.agendamento.exception;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

class ConflitoHorarioExceptionTest {

    @Test
    void construtor_DeveCriarExcecaoComCodigoCorreto() {
        ConflitoHorarioException ex = new ConflitoHorarioException("Conflito de horário");

        assertEquals("Conflito de horário", ex.getMessage());
        assertEquals("CONFLITO_HORARIO", ex.getCodigoErro());
        assertInstanceOf(BusinessException.class, ex);
    }
}


