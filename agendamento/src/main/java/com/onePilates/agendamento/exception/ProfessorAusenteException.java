package com.onePilates.agendamento.exception;

public class ProfessorAusenteException extends BusinessException {
    public ProfessorAusenteException(String mensagem) {
        super(mensagem, "PROFESSOR_AUSENTE");
    }
}

