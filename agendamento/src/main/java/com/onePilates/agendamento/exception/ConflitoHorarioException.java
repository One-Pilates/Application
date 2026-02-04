package com.onePilates.agendamento.exception;

public class ConflitoHorarioException extends BusinessException {
    public ConflitoHorarioException(String mensagem) {
        super(mensagem, "CONFLITO_HORARIO");
    }
}

