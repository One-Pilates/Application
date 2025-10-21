package com.onePilates.agendamento.service;

import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

@Service
public class EmailService {

    @Autowired
    private JavaMailSender mailSender;

    @Value("${spring.mail.username}")
    private String remetente;


    public String enviarEmailAvisoDeAulaMarcada(String nomeProfessor, List<String> listaNomesAlunos, String email, LocalDateTime dataHoraAgendamento) {
        try {
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");

            helper.setFrom(remetente);
            helper.setTo(email);
            helper.setSubject("Novo agendamento");


            StringBuilder listaAlunosHtml = new StringBuilder();
            for (String aluno : listaNomesAlunos) {
                listaAlunosHtml.append("<li style='margin:5px 0;padding:5px;background:#fff3e6;border-radius:4px;'>")
                        .append(aluno)
                        .append("</li>");
            }


            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");
            String dataHoraFormatada = dataHoraAgendamento.format(formatter);


            String corpoHtml = """
            <html>
                <body style="font-family: Arial, sans-serif; background-color:#ffffff; margin:0; padding:0;">
                    <div style="max-width:600px; margin:20px auto; padding:20px; border:1px solid #ff6600; border-radius:8px; background-color:#ffffff;">
                        <h2 style="color:#FF6600; text-align:center;">Novo Agendamento</h2>
                        <p style="color:#333333;">Olá, <b>%s</b>!</p>
                        <p style="color:#333333;">Você recebeu um novo agendamento com os seguintes alunos:</p>
                        <ul style="list-style:none; padding:0;">%s</ul>
                        <p style="color:#333333;"><b>Data/Hora:</b> %s</p>
                        <p style="color:#333333;">Atenciosamente,<br><span style="color:#FF6600;">OnePilates</span></p>
                    </div>
                </body>
            </html>
            """.formatted(nomeProfessor, listaAlunosHtml, dataHoraFormatada);

            helper.setText(corpoHtml, true); // true indica HTML

            mailSender.send(message);

            System.out.println("Email HTML profissional enviado com sucesso!");
            return "Email HTML profissional enviado com sucesso!";
        } catch (MessagingException e) {
            e.printStackTrace();
            return "Erro ao enviar email HTML: " + e.getMessage();
        }
    }

}
