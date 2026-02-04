package com.onePilates.agendamento.exception;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

class PerfilInativoExceptionTest {

    @Test
    void construtor_DeveCriarExcecaoComCodigoCorreto() {
        PerfilInativoException ex = new PerfilInativoException("Perfil inativo");

        assertEquals("Perfil inativo", ex.getMessage());
        assertEquals("PERFIL_INATIVO", ex.getCodigoErro());
        assertInstanceOf(BusinessException.class, ex);
    }
}


