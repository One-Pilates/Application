package com.onePilates.agendamento;

import io.github.cdimascio.dotenv.Dotenv;
import com.onePilates.agendamento.security.SenhaTemp;
import io.github.cdimascio.dotenv.DotenvEntry;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.ApplicationContext;



@SpringBootApplication
public class  AgendamentoApplication {

    private static final Dotenv DOTENV = Dotenv.configure()
            .ignoreIfMissing()
            .load();

    public static void main(String[] args) {
        carregarVariaveisDoEnv();

        // Recupera o contexto da aplicação Spring
        ApplicationContext context = SpringApplication.run(AgendamentoApplication.class, args);

        // Recupera o bean SenhaTemp
        SenhaTemp senhaTemp = context.getBean(SenhaTemp.class);
        senhaTemp.criarSenhaCodificada();
    }

    private static void carregarVariaveisDoEnv() {
        for (DotenvEntry entry : DOTENV.entries()) {
            System.getProperties().putIfAbsent(entry.getKey(), entry.getValue());
        }
    }

}