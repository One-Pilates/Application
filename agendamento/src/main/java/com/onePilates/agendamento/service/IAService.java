package com.onePilates.agendamento.service;

import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.time.Duration;
import java.util.List;
import java.util.Map;

@Service
public class IAService {

    @Value("${groq.api.key}")
    private String groqApiKey;

    private final ObjectMapper objectMapper = new ObjectMapper();
    private final HttpClient httpClient = HttpClient.newBuilder()
            .connectTimeout(Duration.ofSeconds(10))
            .build();

    public IAService() {
    }

    public String getRecomendacao(String nomeAluno, String observacao, String especialidade, List<Map<String, String>> historico, String mensagemUsuario) {
        
        List<Map<String, String>> messages;
        
        if (historico == null || historico.isEmpty()) {
            // Primeira vez: Usa o prompt estruturado (modelo padrão)
            String prompt = buildPrompt(nomeAluno, observacao, especialidade);
            messages = List.of(Map.of("role", "user", "content", prompt));
        } else {
            // Conversa em andamento: Mantém a personalidade de especialista, mas responde de forma livre/concisa
            String systemPrompt = String.format(
                "Você é um especialista em %s e reabilitação física. " +
                "Mantenha sua personalidade de especialista, mas responda de forma muito BREVE e DIRETA (máximo 3-4 linhas). " +
                "O foco é ajudar o professor com o aluno %s sobre a observação: \"%s\".",
                especialidade, nomeAluno, observacao
            );
            
            messages = new java.util.ArrayList<>();
            messages.add(Map.of("role", "system", "content", systemPrompt));
            messages.addAll(historico);
        }

        try {
            Map<String, Object> body = Map.of(
                    "model", "llama-3.3-70b-versatile",
                    "messages", messages,
                    "temperature", 0.7,
                    "max_tokens", 800
            );

            String jsonBody = objectMapper.writeValueAsString(body);

            HttpRequest request = HttpRequest.newBuilder()
                    .uri(URI.create("https://api.groq.com/openai/v1/chat/completions"))
                    .header("Content-Type", "application/json")
                    .header("Authorization", "Bearer " + groqApiKey.trim())
                    .POST(HttpRequest.BodyPublishers.ofString(jsonBody))
                    .timeout(Duration.ofSeconds(30))
                    .build();

            HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());

            if (response.statusCode() != 200) {
                throw new RuntimeException("API da Groq retornou erro " + response.statusCode() + ": " + response.body());
            }

            Map<String, Object> responseMap = objectMapper.readValue(response.body(), Map.class);
            
            @SuppressWarnings("unchecked")
            List<Map<String, Object>> choices = (List<Map<String, Object>>) responseMap.get("choices");
            
            if (choices == null || choices.isEmpty()) {
                throw new RuntimeException("Resposta da Groq não contém 'choices'");
            }

            @SuppressWarnings("unchecked")
            Map<String, Object> message = (Map<String, Object>) choices.get(0).get("message");
            
            if (message == null || !message.containsKey("content")) {
                throw new RuntimeException("Resposta da Groq não contém o conteúdo da mensagem");
            }

            return (String) message.get("content");

        } catch (Exception e) {
            throw new RuntimeException("Falha ao obter recomendação da IA: " + e.getMessage(), e);
        }
    }

    private String buildPrompt(String nomeAluno, String observacao, String especialidade) {
        String nomeSeguro = (nomeAluno != null && !nomeAluno.isBlank()) ? nomeAluno : "o aluno";
        String espSegura = (especialidade != null && !especialidade.isBlank()) ? especialidade : "Pilates";

        return String.join("\n",
                "Você é um especialista em " + espSegura + " e reabilitação física.",
                "",
                "REGRA IMPORTANTE: Se a observação abaixo não tiver nenhuma relação com saúde, corpo,",
                "movimento, dor, limitação física ou contexto de aula de " + espSegura + ",",
                "responda APENAS com esta mensagem exata:",
                "\"⚠️ Essa observação não parece ter relação com a aula de " + espSegura + ". Verifique se a informação está correta.\"",
                "Não invente recomendações para observações aleatórias ou sem sentido clínico.",
                "",
                "---",
                "",
                "Observação sobre " + nomeSeguro + ": \"" + (observacao != null ? observacao : "") + "\"",
                "",
                "Se a observação for relevante, responda de forma BREVE e DIRETA (o professor lê durante a aula).",
                "Comece com uma frase empática e natural sobre a situação — integre " + nomeSeguro + " na frase, sem título ou rótulo separado.",
                "Depois siga exatamente este formato:",
                "",
                "✅ Exercícios indicados:",
                "• [Nome]: [explicação em 1 linha]",
                "• [Nome]: [explicação em 1 linha]",
                "• [Nome]: [explicação em 1 linha]",
                "",
                "🚫 Evitar:",
                "• [movimento ou aparelho]",
                "• [movimento ou aparelho]",
                "",
                "⚠️ Atenção: [1 dica rápida de adaptação ou cuidado para o professor]",
                "",
                "Responda em português. Seja conciso."
        );
    }
}
