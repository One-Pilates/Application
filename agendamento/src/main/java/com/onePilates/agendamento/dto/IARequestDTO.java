package com.onePilates.agendamento.dto;

import java.util.List;
import java.util.Map;

public record IARequestDTO(
    String nomeAluno,
    String observacao,
    String especialidade,
    List<Map<String, String>> historico,
    String mensagemUsuario
) {}
