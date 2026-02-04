package com.onePilates.agendamento.exception;

public class AlunoInativoException extends BusinessException {
    public AlunoInativoException(String mensagem) {
        super(mensagem, "ALUNO_INATIVO");
    }
}

