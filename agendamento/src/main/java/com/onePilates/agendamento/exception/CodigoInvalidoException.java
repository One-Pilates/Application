package com.onePilates.agendamento.exception;

public class CodigoInvalidoException extends BusinessException {
    public CodigoInvalidoException(String mensagem) {
        super(mensagem, "CODIGO_INVALIDO");
    }
}

