package com.onePilates.agendamento.exception;

public class EmailJaCadastradoException extends BusinessException {
    public EmailJaCadastradoException(String mensagem) {
        super(mensagem, "EMAIL_JA_CADASTRADO");
    }
}

