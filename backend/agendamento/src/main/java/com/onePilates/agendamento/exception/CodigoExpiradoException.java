package com.onePilates.agendamento.exception;

public class CodigoExpiradoException extends BusinessException {
    public CodigoExpiradoException(String mensagem) {
        super(mensagem, "CODIGO_EXPIRADO");
    }
}

