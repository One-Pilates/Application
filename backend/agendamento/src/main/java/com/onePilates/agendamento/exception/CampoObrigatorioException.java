package com.onePilates.agendamento.exception;

public class CampoObrigatorioException extends BusinessException {
    public CampoObrigatorioException(String mensagem) {
        super(mensagem, "CAMPO_OBRIGATORIO");
    }
}

