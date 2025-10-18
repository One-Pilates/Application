package com.onePilates.agendamento.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;

@Component
public class SenhaTemp {
    @Autowired
    private PasswordEncoder passwordEncoder;

    public void criarSenhaCodificada() {
        String senhaCodificada = passwordEncoder.encode("12345678");
        System.out.println("Senha Codificada: " + senhaCodificada);
    }
}
