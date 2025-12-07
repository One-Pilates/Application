package com.onePilates.agendamento.exception;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

class EquipamentoPCDInsuficienteExceptionTest {

    @Test
    void construtor_DeveCriarExcecaoComCodigoCorreto() {
        EquipamentoPCDInsuficienteException ex = new EquipamentoPCDInsuficienteException("Equipamento PCD insuficiente");

        assertEquals("Equipamento PCD insuficiente", ex.getMessage());
        assertEquals("EQUIPAMENTO_PCD_INSUFICIENTE", ex.getCodigoErro());
        assertInstanceOf(BusinessException.class, ex);
    }
}


