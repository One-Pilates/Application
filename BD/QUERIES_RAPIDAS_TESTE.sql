-- ============================================
-- QUERIES RÁPIDAS PARA TESTE DIRETO NO BANCO
-- Copie e cole no MySQL Workbench ou cliente SQL
-- ============================================

-- ============================================
-- 1. LISTAR TODOS OS PROFESSORES (para pegar um ID válido)
-- ============================================
SELECT id, nome, email 
FROM funcionario 
WHERE tipo = 'PROFESSOR';

-- ============================================
-- 2. TESTE RÁPIDO: Verificar agendamentos de um professor
-- SUBSTITUA 1 pelo ID do professor que você quer testar
-- ============================================
SELECT 
    a.id,
    a.data_hora,
    DAYNAME(a.data_hora) AS dia_semana,
    e.nome AS especialidade,
    COUNT(*) OVER (PARTITION BY DAYNAME(a.data_hora)) AS total_por_dia
FROM agendamento a
LEFT JOIN especialidade e ON a.especialidade_id = e.id
WHERE a.professor_id = 1  -- <-- SUBSTITUA 1 pelo ID do professor
ORDER BY a.data_hora DESC
LIMIT 20;

-- ============================================
-- 3. TESTE DA QUERY 1 DO ENDPOINT
-- SUBSTITUA: 
--   - 1 pelo ID do professor
--   - 7 pela quantidade de dias
-- ============================================
SELECT 
    DAYNAME(a.data_hora) AS diaSemana,
    CAST(COUNT(*) AS UNSIGNED) AS totalAgendamentos
FROM agendamento a
WHERE a.professor_id = 1  -- <-- SUBSTITUA
  AND a.data_hora >= DATE_SUB(CURDATE(), INTERVAL 7 DAY)  -- <-- SUBSTITUA 7
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
    END;

-- ============================================
-- 4. TESTE DA QUERY 2 DO ENDPOINT
-- SUBSTITUA: 
--   - 1 pelo ID do professor
--   - 7 pela quantidade de dias
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
    WHERE data_hora >= DATE_SUB(CURDATE(), INTERVAL 7 DAY)  -- <-- SUBSTITUA 7
      AND data_hora < DATE_ADD(CURDATE(), INTERVAL 1 DAY)
      AND professor_id = 1  -- <-- SUBSTITUA 1
    GROUP BY professor_id
) total ON total.professor_id = a.professor_id
WHERE a.data_hora >= DATE_SUB(CURDATE(), INTERVAL 7 DAY)  -- <-- SUBSTITUA 7
  AND a.data_hora < DATE_ADD(CURDATE(), INTERVAL 1 DAY)
  AND a.professor_id = 1  -- <-- SUBSTITUA 1
GROUP BY a.professor_id, e.nome, total.total_geral;

-- ============================================
-- 5. VERIFICAR SE HÁ DADOS NO PERÍODO
-- SUBSTITUA 1 pelo ID do professor e 7 pelos dias
-- ============================================
SELECT 
    COUNT(*) AS total_agendamentos,
    MIN(data_hora) AS data_mais_antiga,
    MAX(data_hora) AS data_mais_recente,
    DATE_SUB(CURDATE(), INTERVAL 7 DAY) AS inicio_busca,  -- <-- SUBSTITUA 7
    DATE_ADD(CURDATE(), INTERVAL 1 DAY) AS fim_busca
FROM agendamento
WHERE professor_id = 1  -- <-- SUBSTITUA 1
  AND data_hora >= DATE_SUB(CURDATE(), INTERVAL 7 DAY)  -- <-- SUBSTITUA 7
  AND data_hora < DATE_ADD(CURDATE(), INTERVAL 1 DAY);

-- ============================================
-- 6. VER TODOS OS AGENDAMENTOS DO PROFESSOR (últimos 30 dias)
-- SUBSTITUA 1 pelo ID do professor
-- ============================================
SELECT 
    a.id,
    a.data_hora,
    DAYNAME(a.data_hora) AS dia_semana,
    e.nome AS especialidade,
    s.nome AS sala,
    CASE 
        WHEN a.data_hora >= DATE_SUB(CURDATE(), INTERVAL 7 DAY) 
         AND a.data_hora < DATE_ADD(CURDATE(), INTERVAL 1 DAY)
        THEN 'SIM'
        ELSE 'NÃO'
    END AS dentro_periodo_7_dias
FROM agendamento a
LEFT JOIN especialidade e ON a.especialidade_id = e.id
LEFT JOIN sala s ON a.sala_id = s.id
WHERE a.professor_id = 1  -- <-- SUBSTITUA 1
  AND a.data_hora >= DATE_SUB(CURDATE(), INTERVAL 30 DAY)
ORDER BY a.data_hora DESC;

-- ============================================
-- 7. DIAGNÓSTICO COMPLETO
-- Execute esta query para ver um resumo completo
-- SUBSTITUA 1 pelo ID do professor
-- ============================================
SELECT 
    'Total de agendamentos' AS tipo,
    COUNT(*) AS quantidade
FROM agendamento
WHERE professor_id = 1  -- <-- SUBSTITUA 1

UNION ALL

SELECT 
    'Agendamentos últimos 7 dias' AS tipo,
    COUNT(*) AS quantidade
FROM agendamento
WHERE professor_id = 1  -- <-- SUBSTITUA 1
  AND data_hora >= DATE_SUB(CURDATE(), INTERVAL 7 DAY)
  AND data_hora < DATE_ADD(CURDATE(), INTERVAL 1 DAY)

UNION ALL

SELECT 
    'Agendamentos últimos 30 dias' AS tipo,
    COUNT(*) AS quantidade
FROM agendamento
WHERE professor_id = 1  -- <-- SUBSTITUA 1
  AND data_hora >= DATE_SUB(CURDATE(), INTERVAL 30 DAY)
  AND data_hora < DATE_ADD(CURDATE(), INTERVAL 1 DAY)

UNION ALL

SELECT 
    'Agendamentos futuros' AS tipo,
    COUNT(*) AS quantidade
FROM agendamento
WHERE professor_id = 1  -- <-- SUBSTITUA 1
  AND data_hora >= CURDATE();

-- ============================================
-- INSTRUÇÕES DE USO:
-- ============================================
-- 1. Execute a Query 1 para listar os professores e pegar um ID válido
-- 2. Execute a Query 5 para verificar se há dados no período
-- 3. Se houver dados, execute as Queries 3 e 4 (que são as do endpoint)
-- 4. Se não houver dados, você precisa criar agendamentos de teste
-- 5. Use a Query 7 para um diagnóstico completo
-- ============================================

