package com.onePilates.agendamento.handler;

import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

import java.util.HashMap;
import java.util.Map;

@ControllerAdvice
public class GlobalExceptionHandler {

    @ExceptionHandler(MethodArgumentNotValidException.class)
    public ResponseEntity<Map<String, String>> tratarErrosDeValidacao(MethodArgumentNotValidException excecao) {
        Map<String, String> erros = new HashMap<>();
        for (FieldError erro : excecao.getBindingResult().getFieldErrors()) {
            erros.put(erro.getField(), erro.getDefaultMessage());
        }
        return new ResponseEntity<>(erros, HttpStatus.BAD_REQUEST);
    }

    @ExceptionHandler(DataIntegrityViolationException.class)
    public ResponseEntity<Map<String, String>> tratarErrosDeBanco(DataIntegrityViolationException excecao) {
        Map<String, String> erro = new HashMap<>();
        String mensagem = excecao.getMostSpecificCause() != null ? excecao.getMostSpecificCause().getMessage() : "";

        if (mensagem != null && mensagem.toLowerCase().contains("cpf")) {
            erro.put("erro", "Já existe um funcionário com esse CPF cadastrado.");
        } else if (mensagem != null && mensagem.toLowerCase().contains("email")) {
            erro.put("erro", "Já existe um funcionário com esse e-mail cadastrado.");
        } else {
            erro.put("erro", "Erro de integridade nos dados. Verifique os campos únicos.");
        }

        return new ResponseEntity<>(erro, HttpStatus.CONFLICT);
    }

    @ExceptionHandler(RuntimeException.class)
    public ResponseEntity<String> handleRuntime(RuntimeException ex) {
        String msg = ex.getMessage() == null ? "Erro" : ex.getMessage();
        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(msg);
    }

    // Único handler genérico para Exception no projeto
    @ExceptionHandler(Exception.class)
    public ResponseEntity<Map<String, String>> tratarErroGenerico(Exception excecao) {
        Map<String, String> erro = new HashMap<>();
        erro.put("erro", "Erro interno no servidor. Por favor, tente novamente mais tarde.");
        return new ResponseEntity<>(erro, HttpStatus.INTERNAL_SERVER_ERROR);
    }
}