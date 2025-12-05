-- ============================================
-- QUERIES DE TESTE PARA O ENDPOINT DASHBOARD
-- Execute estas queries diretamente no MySQL
-- ============================================

-- IMPORTANTE: Substitua os valores abaixo:
-- @PROFESSOR_ID: ID do professor que você quer testar (ex: 1, 2, 3...)
-- @QTD_DIAS: Quantidade de dias para buscar (ex: 7, 30, 90...)

-- ============================================
-- QUERY 1: Verificar se o professor existe
-- ============================================
SELECT 
    id,
    nome,
    email,
    status
FROM funcionario
WHERE id = @PROFESSOR_ID
  AND tipo = 'PROFESSOR';

-- ============================================
-- QUERY 2: Verificar TODOS os agendamentos do professor
-- ============================================
SELECT 
    a.id AS agendamento_id,
    a.professor_id,
    p.nome AS professor_nome,
    a.data_hora,
    a.sala_id,
    s.nome AS sala_nome,
    a.especialidade_id,
    e.nome AS especialidade_nome,
    DATE_FORMAT(a.data_hora, '%Y-%m-%d %H:%i:%s') AS data_hora_formatada,
    DAYNAME(a.data_hora) AS dia_semana
FROM agendamento a
LEFT JOIN funcionario p ON a.professor_id = p.id
LEFT JOIN sala s ON a.sala_id = s.id
LEFT JOIN especialidade e ON a.especialidade_id = e.id
WHERE a.professor_id = @PROFESSOR_ID
ORDER BY a.data_hora DESC;

-- ============================================
-- QUERY 3: Contar total de agendamentos do professor
-- ============================================
SELECT 
    COUNT(*) AS total_agendamentos
FROM agendamento
WHERE professor_id = @PROFESSOR_ID;

-- ============================================
-- QUERY 4: Verificar agendamentos no período (últimos X dias)
-- ============================================
SELECT 
    COUNT(*) AS total_no_periodo,
    MIN(data_hora) AS data_mais_antiga,
    MAX(data_hora) AS data_mais_recente
FROM agendamento
WHERE professor_id = @PROFESSOR_ID
  AND data_hora >= DATE_SUB(CURDATE(), INTERVAL @QTD_DIAS DAY)
  AND data_hora < DATE_ADD(CURDATE(), INTERVAL 1 DAY);

-- ============================================
-- QUERY 5: TESTE DA QUERY 1 DO ENDPOINT (Agendamentos por dia da semana)
-- Substitua @PROFESSOR_ID e @QTD_DIAS
-- ============================================
SELECT 
    DAYNAME(a.data_hora) AS diaSemana,
    CAST(COUNT(*) AS UNSIGNED) AS totalAgendamentos
FROM agendamento a
WHERE a.professor_id = @PROFESSOR_ID
  AND a.data_hora >= DATE_SUB(CURDATE(), INTERVAL @QTD_DIAS DAY)
  AND a.data_hora < DATE_ADD(CURDATE(), INTERVAL 1 DAY)
GROUP BY DAYNAME(a.data_hora)
ORDER BY 
    CASE DAYNAME(a.data_hora)
        WHEN 'Sunday' THEN 1
        WHEN 'Monday' THEN 2
        WHEN 'Tuesday' THEN 3
        WHEN 'Wednesday' THEN 4
        WHEN 'Thursday' THEN 5
        WHEN 'Friday' THEN 6
        WHEN 'Saturday' THEN 7
        ELSE 8
    END;

-- ============================================
-- QUERY 6: TESTE DA QUERY 2 DO ENDPOINT (Aulas por especialidade)
-- Substitua @PROFESSOR_ID e @QTD_DIAS
-- ============================================
SELECT 
    CAST(a.professor_id AS UNSIGNED) AS professorId,
    e.nome AS especialidade,
    CAST(ROUND(COUNT(*) * 100.0 / NULLIF(total.total_geral, 0), 2) AS DECIMAL(10,2)) AS percentualAulas
FROM agendamento a
JOIN especialidade e ON a.especialidade_id = e.id
JOIN (
    SELECT professor_id, COUNT(*) AS total_geral
    FROM agendamento
    WHERE data_hora >= DATE_SUB(CURDATE(), INTERVAL @QTD_DIAS DAY)
      AND data_hora < DATE_ADD(CURDATE(), INTERVAL 1 DAY)
      AND professor_id = @PROFESSOR_ID
    GROUP BY professor_id
) total ON total.professor_id = a.professor_id
WHERE a.data_hora >= DATE_SUB(CURDATE(), INTERVAL @QTD_DIAS DAY)
  AND a.data_hora < DATE_ADD(CURDATE(), INTERVAL 1 DAY)
  AND a.professor_id = @PROFESSOR_ID
GROUP BY a.professor_id, e.nome, total.total_geral;

-- ============================================
-- QUERY 7: Verificar subquery isoladamente (para debug da Query 2)
-- ============================================
SELECT 
    professor_id, 
    COUNT(*) AS total_geral
FROM agendamento
WHERE data_hora >= DATE_SUB(CURDATE(), INTERVAL @QTD_DIAS DAY)
  AND data_hora < DATE_ADD(CURDATE(), INTERVAL 1 DAY)
  AND professor_id = @PROFESSOR_ID
GROUP BY professor_id;

-- ============================================
-- QUERY 8: Verificar agendamentos com detalhes no período
-- ============================================
SELECT 
    a.id,
    a.professor_id,
    p.nome AS professor_nome,
    a.data_hora,
    DAYNAME(a.data_hora) AS dia_semana,
    a.especialidade_id,
    e.nome AS especialidade_nome,
    a.sala_id,
    s.nome AS sala_nome,
    CASE 
        WHEN a.data_hora >= DATE_SUB(CURDATE(), INTERVAL @QTD_DIAS DAY) 
         AND a.data_hora < DATE_ADD(CURDATE(), INTERVAL 1 DAY)
        THEN 'DENTRO DO PERÍODO'
        ELSE 'FORA DO PERÍODO'
    END AS status_periodo
FROM agendamento a
LEFT JOIN funcionario p ON a.professor_id = p.id
LEFT JOIN especialidade e ON a.especialidade_id = e.id
LEFT JOIN sala s ON a.sala_id = s.id
WHERE a.professor_id = @PROFESSOR_ID
ORDER BY a.data_hora DESC;

-- ============================================
-- QUERY 9: Verificar período calculado (para comparar com Java)
-- ============================================
SELECT 
    DATE_SUB(CURDATE(), INTERVAL @QTD_DIAS DAY) AS inicio_periodo,
    DATE_ADD(CURDATE(), INTERVAL 1 DAY) AS fim_periodo,
    CURDATE() AS data_atual,
    NOW() AS data_hora_atual;

-- ============================================
-- QUERY 10: Verificar se há agendamentos futuros (para criar dados de teste)
-- ============================================
SELECT 
    COUNT(*) AS agendamentos_futuros
FROM agendamento
WHERE professor_id = @PROFESSOR_ID
  AND data_hora >= CURDATE();

-- ============================================
-- EXEMPLO DE USO COM VALORES REAIS
-- ============================================
-- Substitua os valores abaixo pelos seus valores reais:

-- Exemplo: Professor ID = 1, últimos 7 dias
SELECT 
    DAYNAME(a.data_hora) AS diaSemana,
    CAST(COUNT(*) AS UNSIGNED) AS totalAgendamentos
FROM agendamento a
WHERE a.professor_id = 1
  AND a.data_hora >= DATE_SUB(CURDATE(), INTERVAL 7 DAY)
  AND a.data_hora < DATE_ADD(CURDATE(), INTERVAL 1 DAY)
GROUP BY DAYNAME(a.data_hora);

-- ============================================
-- QUERY PARA CRIAR DADOS DE TESTE (se necessário)
-- ============================================
-- ATENÇÃO: Esta query cria um agendamento de teste
-- Use apenas se não houver dados no banco
-- 
-- IMPORTANTE: Ajuste os IDs conforme seu banco de dados
-- 
-- INSERT INTO agendamento (data_hora, professor_id, sala_id, especialidade_id)
-- VALUES (
--     DATE_ADD(NOW(), INTERVAL 1 DAY),  -- Agendamento para amanhã
--     1,  -- ID do professor (ajuste conforme necessário)
--     1,  -- ID da sala (ajuste conforme necessário)
--     1   -- ID da especialidade (ajuste conforme necessário)
-- );

-- ============================================
-- FIM DAS QUERIES DE TESTE
-- ============================================

