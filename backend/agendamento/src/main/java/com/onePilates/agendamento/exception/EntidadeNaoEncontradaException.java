package com.onePilates.agendamento.exception;

public class EntidadeNaoEncontradaException extends BusinessException {
    public EntidadeNaoEncontradaException(String mensagem) {
        super(mensagem, "ENTIDADE_NAO_ENCONTRADA");
    }
}

