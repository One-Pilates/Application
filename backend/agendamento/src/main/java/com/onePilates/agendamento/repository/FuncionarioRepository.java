package com.onePilates.agendamento.repository;

import com.onePilates.agendamento.model.Funcionario;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

public interface FuncionarioRepository extends JpaRepository<Funcionario,Long> {

    Funcionario findByEmailAndSenha(String email, String senha);


}
