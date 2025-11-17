package com.onePilates.agendamento.exception;

public class CpfJaCadastradoException extends BusinessException {
    public CpfJaCadastradoException(String mensagem) {
        super(mensagem, "CPF_JA_CADASTRADO");
    }
}

