package com.onePilates.agendamento.exception;

public class EquipamentoPCDInsuficienteException extends BusinessException {
    public EquipamentoPCDInsuficienteException(String mensagem) {
        super(mensagem, "EQUIPAMENTO_PCD_INSUFICIENTE");
    }
}

