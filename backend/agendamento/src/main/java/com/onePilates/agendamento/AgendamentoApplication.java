package com.onePilates.agendamento;

import com.onePilates.agendamento.security.SenhaTemp;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.ApplicationContext;

@SpringBootApplication
public class  AgendamentoApplication {

    public static void main(String[] args) {
        // Recupera o contexto da aplicação Spring
        ApplicationContext context = SpringApplication.run(AgendamentoApplication.class, args);

        // Recupera o bean SenhaTemp
        SenhaTemp senhaTemp = context.getBean(SenhaTemp.class);
        senhaTemp.criarSenhaCodificada();
    }

}