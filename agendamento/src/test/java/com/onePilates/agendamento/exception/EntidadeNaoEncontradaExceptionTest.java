package com.onePilates.agendamento.exception;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

class EntidadeNaoEncontradaExceptionTest {

    @Test
    void construtor_DeveCriarExcecaoComCodigoCorreto() {
        EntidadeNaoEncontradaException ex = new EntidadeNaoEncontradaException("Entidade não encontrada");

        assertEquals("Entidade não encontrada", ex.getMessage());
        assertEquals("ENTIDADE_NAO_ENCONTRADA", ex.getCodigoErro());
        assertInstanceOf(BusinessException.class, ex);
    }
}


