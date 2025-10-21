package com.onePilates.agendamento.observer;

import com.onePilates.agendamento.model.Agendamento;
import com.onePilates.agendamento.model.Aluno;
import com.onePilates.agendamento.service.EmailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class NotificacaoProfessorObserver implements AgendamentoObserver {

    @Autowired
    private EmailService emailService;

    @Override
    public void notificar(Agendamento agendamento) {
        List<String> nomesAlunos = agendamento.getAlunos().stream()
                .map(Aluno::getNome)
                .toList();

        System.out.println("🔔 Notificando professor " + agendamento.getProfessor().getNome() +
                " sobre novo agendamento com os alunos: " + String.join(", ", nomesAlunos));

        emailService.enviarEmailAvisoDeAulaMarcada(agendamento.getProfessor().getNome(), nomesAlunos, agendamento.getProfessor().getEmail(),agendamento.getDataHora());
    }


}
