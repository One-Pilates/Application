package com.onePilates.agendamento.exception;

public class BusinessException extends RuntimeException {
    private final String codigoErro;

    public BusinessException(String mensagem, String codigoErro) {
        super(mensagem);
        this.codigoErro = codigoErro;
    }

    public BusinessException(String mensagem) {
        super(mensagem);
        this.codigoErro = "BUSINESS_ERROR";
    }

    public String getCodigoErro() {
        return codigoErro;
    }
}

