package com.onePilates.agendamento.observer;

import com.onePilates.agendamento.model.Agendamento;
import com.onePilates.agendamento.model.Aluno;
import org.springframework.stereotype.Service;

@Service
public class NotificacaoProfessorObserver implements AgendamentoObserver {

    @Override
    public void notificar(Agendamento agendamento) {
        String nomesAlunos = agendamento.getAlunos().stream()
                .map(Aluno::getNome)
                .reduce((a, b) -> a + ", " + b)
                .orElse("nenhum aluno");

        System.out.println("🔔 Notificando professor " + agendamento.getProfessor().getNome() +
                " sobre novo agendamento com os alunos: " + nomesAlunos);

        // Aqui você pode integrar com e-mail, push, etc.
    }

}
