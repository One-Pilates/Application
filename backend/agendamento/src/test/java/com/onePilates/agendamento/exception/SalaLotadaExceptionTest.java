package com.onePilates.agendamento.exception;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

class SalaLotadaExceptionTest {

    @Test
    void construtor_DeveCriarExcecaoComCodigoCorreto() {
        SalaLotadaException ex = new SalaLotadaException("Sala lotada");

        assertEquals("Sala lotada", ex.getMessage());
        assertEquals("SALA_LOTADA", ex.getCodigoErro());
        assertInstanceOf(BusinessException.class, ex);
    }
}


