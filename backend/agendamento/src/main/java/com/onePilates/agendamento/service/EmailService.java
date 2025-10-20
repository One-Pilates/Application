package com.onePilates.agendamento.service;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

@Service
public class EmailService {

    @Autowired
    private JavaMailSender mailSender;

        @Value("${spring.mail.username}")
        private String remetente;

    public String enviarEmailTeste(String destinatario, String assunto, String corpo) {

        try {
            SimpleMailMessage message = new SimpleMailMessage();
            message.setFrom(remetente);
            message.setTo(destinatario);
            message.setSubject(assunto);
            message.setText(corpo);
            return "Email enviado com sucesso!";
        }catch(Exception e) {
            return e.getMessage();
        }
    }
}
