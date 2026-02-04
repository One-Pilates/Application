package com.onePilates.agendamento.exception;

public class OperacaoInvalidaException extends BusinessException {
    public OperacaoInvalidaException(String mensagem) {
        super(mensagem, "OPERACAO_INVALIDA");
    }
}

