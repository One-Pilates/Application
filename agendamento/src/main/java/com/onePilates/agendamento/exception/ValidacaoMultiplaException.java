package com.onePilates.agendamento.exception;
import java.util.List;

public class ValidacaoMultiplaException extends RuntimeException {

    private final List<String> erros;

    public ValidacaoMultiplaException(List<String> erros) {
        super("Erro de validação");
        this.erros = erros;
    }

    public List<String> getErros() {
        return erros;
    }
}
