package com.onePilates.agendamento.exception;

public class SalaLotadaException extends BusinessException {
    public SalaLotadaException(String mensagem) {
        super(mensagem, "SALA_LOTADA");
    }
}

