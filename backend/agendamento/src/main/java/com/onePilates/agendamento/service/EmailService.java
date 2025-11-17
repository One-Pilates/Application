package com.onePilates.agendamento.service;

import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

@Service
public class EmailService {

    private static final Logger logger = LoggerFactory.getLogger(EmailService.class);

    private final JavaMailSender mailSender;
    private final String remetente;

    public EmailService(JavaMailSender mailSender, @Value("${spring.mail.username}") String remetente) {
        this.mailSender = mailSender;
        this.remetente = remetente;
    }


    public String enviarEmailAvisoDeAulaMarcada(String nomeProfessor, List<String> listaNomesAlunos, String email,
                                                LocalDateTime dataHoraAgendamento) {
        try {
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");

            helper.setFrom(remetente);
            helper.setTo(email);
            helper.setSubject("Novo Agendamento Confirmado - OnePilates");

            StringBuilder listaAlunosHtml = new StringBuilder();
            for (String aluno : listaNomesAlunos) {
                listaAlunosHtml
                        .append("""
                                    <tr>
                                        <td style="padding:10px 16px; background-color:#ffffff; border-left:3px solid #FF6600; border-radius:4px;">
                                            <p style="margin:0; font-size:15px; color:#1a1a1a; font-weight:500;">%s</p>
                                        </td>
                                    </tr>
                                """
                                .formatted(aluno));
            }

            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd 'de' MMMM 'de' yyyy 'às' HH:mm");
            String dataHoraFormatada = dataHoraAgendamento.format(formatter);

            String corpoHtml = """
                    <!DOCTYPE html>
                            <html>
                            <head>
                                <meta charset="UTF-8">
                                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                                <title>Email OnePilates - Novo Agendamento</title>
                                <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap" rel="stylesheet" />
                            </head>
                            <body style="margin:0; padding:0; font-family:'Poppins', Arial, Helvetica, sans-serif;">
                                <table role="presentation" width="100%%" cellpadding="0" cellspacing="0" border="0" style="background-color:#e5e5e5; font-family:'Poppins', Arial, Helvetica, sans-serif;">
                                    <tr>
                                        <td align="center" style="padding:40px 20px;">
                                            <table role="presentation" width="600" cellpadding="0" cellspacing="0" border="0" style="background-color:#ffffff; max-width:600px; font-family:'Poppins', Arial, Helvetica, sans-serif;">
                                                <tr>
                                                    <td align="center" style="padding:40px 40px 30px 40px; background-color:#ffffff;">
                                                        <img src="https://i.ibb.co/q39Mz6gR/logo-Original.png" alt="OnePilates" width="160" style="display:block; max-width:160px; height:auto; border:0;">
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="height:4px; background-color:#FF6600; font-size:0; line-height:0;">&nbsp;</td>
                                                </tr>
                                                <tr>
                                                    <td style="padding:40px 40px 30px 40px;">
                                                        <h1 style="margin:0 0 24px 0; font-size:22px; font-weight:600; color:#1a1a1a;">
                                                            Novo Agendamento Confirmado
                                                        </h1>
                                                        <p style="margin:0 0 16px 0; font-size:15px; line-height:1.6; color:#333333;">
                                                            Olá <strong>%s</strong>,
                                                        </p>
                                                        <p style="margin:0 0 24px 0; font-size:15px; line-height:1.6; color:#333333;">
                                                            Informamos que você possui um novo agendamento registrado em nosso sistema.
                                                        </p>
                                                        <table role="presentation" width="100%%" cellpadding="0" cellspacing="0" border="0" style="background-color:#f9f9f9; border:1px solid #e0e0e0; border-radius:6px; margin:0 0 24px 0;">
                                                            <tr>
                                                                <td style="padding:24px;">
                                                                    <table role="presentation" width="100%%" cellpadding="0" cellspacing="0" border="0">
                                                                        <tr>
                                                                            <td style="padding:0 0 16px 0;">
                                                                                <p style="margin:0 0 8px 0; font-size:13px; font-weight:600; color:#666666; text-transform:uppercase; letter-spacing:0.5px;">
                                                                                    Data e Horário
                                                                                </p>
                                                                                <p style="margin:0; font-size:16px; font-weight:600; color:#1a1a1a;">
                                                                                    %s
                                                                                </p>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td style="padding:16px 0 0 0; border-top:1px solid #e0e0e0;">
                                                                                <p style="margin:0 0 12px 0; font-size:13px; font-weight:600; color:#666666; text-transform:uppercase; letter-spacing:0.5px;">
                                                                                    Alunos Confirmados
                                                                                </p>
                                                                                <table role="presentation" width="100%%" cellpadding="0" cellspacing="0" border="0">
                                                                                    %s
                                                                                </table>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                        <p style="margin:0 0 8px 0; font-size:15px; line-height:1.6; color:#333333;">
                                                            Qualquer dúvida, estamos à disposição.
                                                        </p>
                                                        <p style="margin:0; font-size:15px; line-height:1.6; color:#666666;">
                                                            Atenciosamente,<br>
                                                            <strong style="color:#FF6600;">Equipe OnePilates</strong>
                                                        </p>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="padding:0 40px;">
                                                        <div style="height:1px; background-color:#e0e0e0;"></div>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="padding:24px 40px; background-color:#f9f9f9; border-top:1px solid #e0e0e0;">
                                                        <p style="margin:0; font-size:12px; line-height:1.6; color:#999999; text-align:center;">
                                                            Este é um e-mail automático, por favor não responda.<br>
                                                            © 2025 OnePilates. Todos os direitos reservados.
                                                        </p>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </body>
                            </html>
                    """
                    .formatted(nomeProfessor, dataHoraFormatada, listaAlunosHtml);

            helper.setText(corpoHtml, true);
            mailSender.send(message);

            logger.info("Email de aviso de aula marcada enviado com sucesso para: {}", email);
            return "Email profissional enviado com sucesso!";
        } catch (MessagingException e) {
            logger.error("Erro ao enviar email de aviso de aula marcada para: {}", email, e);
            return "Erro ao enviar email HTML: " + e.getMessage();
        }
    }

    public String enviarCodigoPorEmail(String nomeFuncionario, String codigo, String email) {
        try {
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");

            helper.setFrom(remetente);
            helper.setTo(email);
            helper.setSubject("Bem-vindo à OnePilates - Seu Código de Acesso");

            String corpoHtml = """
    <!DOCTYPE html>
    <html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Email OnePilates - Redefinição de Senha</title>
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap" rel="stylesheet" />
    </head>
    <body style="margin:0; padding:0; font-family:'Poppins', Arial, Helvetica, sans-serif;">
        <table role="presentation" width="100%%" cellpadding="0" cellspacing="0" border="0" style="background-color:#e5e5e5;">
            <tr>
                <td align="center" style="padding:40px 20px;">
                    <table role="presentation" width="600" cellpadding="0" cellspacing="0" border="0" style="background-color:#ffffff; border-radius:10px;">
                        <tr>
                            <td align="center" style="padding:40px;">
                                <img src="https://i.ibb.co/q39Mz6gR/logo-Original.png" alt="OnePilates" width="160" style="display:block; max-width:160px; height:auto; border:0;">
                            </td>
                        </tr>
                        <tr>
                            <td style="height:4px; background-color:#FF6600;"></td>
                        </tr>
                        <tr>
                            <td style="padding:40px;">
                                <h1 style="font-size:22px; font-weight:600; color:#1a1a1a;">Redefinição de senha</h1>
                                <p style="font-size:15px; color:#333;">Olá <strong>%s</strong>,</p>
                                <p style="font-size:15px; color:#333;">
                                    Recebemos uma solicitação para redefinir sua senha de acesso à <strong>OnePilates</strong>. <br>
                                    Utilize o código abaixo para prosseguir com a alteração:
                                </p>
                                <div style="margin:30px auto; display:inline-block; background-color:#FF6600; color:#ffffff; padding:16px 36px; border-radius:8px; font-size:24px; font-weight:600; letter-spacing:3px;">
                                    %s
                                </div>
                                <p style="font-size:14px; color:#666; margin-top:20px;">
                                    Este código é válido por 10 minutos. Caso você não tenha solicitado a redefinição, por favor ignore este e-mail.
                                </p>
                                <p style="margin-top:30px; font-size:14px; color:#666;">Atenciosamente,<br><strong style="color:#FF6600;">Equipe OnePilates</strong></p>
                            </td>
                        </tr>
                        <tr>
                            <td style="background-color:#f9f9f9; text-align:center; padding:16px; font-size:12px; color:#999;">
                                Este é um e-mail automático. © 2025 OnePilates. Todos os direitos reservados.
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </body>
    </html>
    """.formatted(nomeFuncionario, codigo);


            helper.setText(corpoHtml, true);
            mailSender.send(message);

            logger.info("Email de código de verificação enviado com sucesso para: {}", email);
            return "Email de boas-vindas enviado com sucesso!";
        } catch (MessagingException e) {
            logger.error("Erro ao enviar email de código de verificação para: {}", email, e);
            return "Erro ao enviar e-mail de boas-vindas: " + e.getMessage();
        }
    }
}

