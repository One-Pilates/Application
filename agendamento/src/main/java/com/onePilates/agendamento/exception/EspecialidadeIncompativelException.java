package com.onePilates.agendamento.exception;

public class EspecialidadeIncompativelException extends BusinessException {
    public EspecialidadeIncompativelException(String mensagem) {
        super(mensagem, "ESPECIALIDADE_INCOMPATIVEL");
    }
}

