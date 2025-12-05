package com.onePilates.agendamento.exception;

public class ProfessorInativoException extends BusinessException {
    public ProfessorInativoException(String mensagem) {
        super(mensagem, "PROFESSOR_INATIVO");
    }
}

