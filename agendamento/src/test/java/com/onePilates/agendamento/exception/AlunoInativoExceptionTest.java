package com.onePilates.agendamento.exception;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

class AlunoInativoExceptionTest {

    @Test
    void construtor_DeveCriarExcecaoComCodigoCorreto() {
        AlunoInativoException ex = new AlunoInativoException("Aluno inativo");

        assertEquals("Aluno inativo", ex.getMessage());
        assertEquals("ALUNO_INATIVO", ex.getCodigoErro());
        assertInstanceOf(BusinessException.class, ex);
    }
}


