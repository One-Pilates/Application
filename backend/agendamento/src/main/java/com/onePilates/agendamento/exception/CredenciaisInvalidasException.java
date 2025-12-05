package com.onePilates.agendamento.exception;

public class CredenciaisInvalidasException extends BusinessException {
    public CredenciaisInvalidasException(String mensagem) {
        super(mensagem, "CREDENCIAIS_INVALIDAS");
    }
}

