package com.onePilates.agendamento.repository;

import com.onePilates.agendamento.model.Funcionario;
import com.onePilates.agendamento.model.Secretaria;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

public interface SecretariaRepository extends JpaRepository<Secretaria,Long> {

}
