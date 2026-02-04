package com.onePilates.agendamento.exception;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

class OperacaoInvalidaExceptionTest {

    @Test
    void construtor_DeveCriarExcecaoComCodigoCorreto() {
        OperacaoInvalidaException ex = new OperacaoInvalidaException("Operação inválida");

        assertEquals("Operação inválida", ex.getMessage());
        assertEquals("OPERACAO_INVALIDA", ex.getCodigoErro());
        assertInstanceOf(BusinessException.class, ex);
    }
}


