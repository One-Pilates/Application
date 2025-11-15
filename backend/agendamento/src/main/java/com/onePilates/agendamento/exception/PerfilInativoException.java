package com.onePilates.agendamento.exception;

public class PerfilInativoException extends BusinessException {
    public PerfilInativoException(String mensagem) {
        super(mensagem, "PERFIL_INATIVO");
    }
}

