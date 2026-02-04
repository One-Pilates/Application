package com.onePilates.agendamento.observer;

import com.onePilates.agendamento.model.Agendamento;

public interface AgendamentoObserver {
    void notificar(Agendamento agendamento);
}
