-- ============================================
-- Script de Dados Iniciais - One Pilates
-- Data: 2024-11-15
-- Descrição: Insere dados iniciais para desenvolvimento
-- ============================================
-- 
-- IMPORTANTE: Execute este script APÓS o banco ser criado pelas classes Java
-- Hash BCrypt da senha para todos os usuários: $2a$10$QosoIZARoPcs1uMI4UExI.ampEaJMB0B390y8QHhzY4gwV4IE2W16
-- ============================================


-- ============================================
-- VERIFICAÇÃO DA ESTRUTURA DA TABELA SALA
-- ============================================
-- IMPORTANTE: Antes de executar este script, verifique a estrutura da tabela sala:
-- DESCRIBE sala;
-- ou
-- SHOW COLUMNS FROM sala;
-- 
-- O nome da coluna pode variar dependendo de como o Hibernate mapeou:
-- - quantidade_equipamentos_pcd (padrão após correção na entidade Java)
-- - quantidade_equipamentos_p_c_d (se o Hibernate tratou PCD como acrônimo)
-- 
-- NOTA: A entidade Sala.java foi corrigida para usar explicitamente:
-- @Column(name = "quantidade_equipamentos_pcd")
-- 
-- Se você recriar o banco (DROP DATABASE), o Hibernate criará com o nome correto.
-- Se o banco já existe, verifique o nome real da coluna e ajuste o script abaixo.
-- ============================================

-- ============================================
-- 1. INSERIR ESPECIALIDADES
-- ============================================
INSERT IGNORE INTO especialidade (nome) VALUES
('Pilates'),
('Osteopatia'),
('RPG'),
('Microfisioterapia'),
('Shiatsu'),
('Drenagem Linfática'),
('Fisioterapia'),
('Acupuntura');

-- ============================================
-- 2. INSERIR SALAS
-- ============================================
-- Sala Grande 1
INSERT IGNORE INTO sala (nome, quantidade_maxima_alunos, quantidade_equipamentos_pcd) VALUES
('Sala Grande 1', 6, 2);

-- Sala Grande 2
INSERT IGNORE INTO sala (nome, quantidade_maxima_alunos, quantidade_equipamentos_pcd) VALUES
('Sala Grande 2', 6, 1);

-- Sala Pequena 1 (com Osteopatia e 1 equipamento PCD)
INSERT IGNORE INTO sala (nome, quantidade_maxima_alunos, quantidade_equipamentos_pcd) VALUES
('Sala Pequena 1', 1, 1);

-- Sala Pequena 2 (sem Osteopatia e sem equipamento PCD)
INSERT IGNORE INTO sala (nome, quantidade_maxima_alunos, quantidade_equipamentos_pcd) VALUES
('Sala Pequena 2', 1, 0);

-- ============================================
-- 3. RELACIONAR SALAS COM ESPECIALIDADES
-- ============================================
-- Sala Grande 1: Pilates, RPG, Fisioterapia
INSERT IGNORE INTO sala_especialidade (sala_id, especialidade_id) VALUES
(1, 1), -- Pilates
(1, 3), -- RPG
(1, 7); -- Fisioterapia

-- Sala Grande 2: Pilates, RPG, Fisioterapia
INSERT IGNORE INTO sala_especialidade (sala_id, especialidade_id) VALUES
(2, 1), -- Pilates
(2, 3), -- RPG
(2, 7); -- Fisioterapia

-- Sala Pequena 1: Osteopatia, RPG, Microfisioterapia, Shiatsu, Drenagem Linfática, Fisioterapia, Acupuntura
INSERT IGNORE INTO sala_especialidade (sala_id, especialidade_id) VALUES
(3, 2), -- Osteopatia
(3, 3), -- RPG
(3, 4), -- Microfisioterapia
(3, 5), -- Shiatsu
(3, 6), -- Drenagem Linfática
(3, 7), -- Fisioterapia
(3, 8); -- Acupuntura

-- Sala Pequena 2: RPG, Microfisioterapia, Shiatsu, Drenagem Linfática, Fisioterapia, Acupuntura
INSERT IGNORE INTO sala_especialidade (sala_id, especialidade_id) VALUES
(4, 3), -- RPG
(4, 4), -- Microfisioterapia
(4, 5), -- Shiatsu
(4, 6), -- Drenagem Linfática
(4, 7), -- Fisioterapia
(4, 8); -- Acupuntura

-- ============================================
-- 4. INSERIR ENDEREÇOS
-- ============================================
-- NOTA: IDs são incluídos explicitamente para garantir referências corretas nas outras tabelas
-- Endereço para Administrador (ID: 1)
INSERT IGNORE INTO endereco (id, rua, numero, bairro, cidade, estado, cep, uf) VALUES
(1, 'Rua das Flores', '123', 'Centro', 'São Paulo', 'São Paulo', '01310-100', 'SP');

-- Endereços para Professores (IDs: 2, 3)
INSERT IGNORE INTO endereco (id, rua, numero, bairro, cidade, estado, cep, uf) VALUES
(2, 'Av. Paulista', '1000', 'Bela Vista', 'São Paulo', 'São Paulo', '01310-100', 'SP'),
(3, 'Rua Augusta', '500', 'Consolação', 'São Paulo', 'São Paulo', '01305-100', 'SP');

-- Endereço para Secretária (ID: 4)
INSERT IGNORE INTO endereco (id, rua, numero, bairro, cidade, estado, cep, uf) VALUES
(4, 'Rua dos Três Irmãos', '456', 'Vila Progredior', 'São Paulo', 'São Paulo', '05615-190', 'SP');

-- Endereços para Alunos (IDs: 5 a 24 - 20 endereços)
INSERT IGNORE INTO endereco (id, rua, numero, bairro, cidade, estado, cep, uf) VALUES
(5, 'Rua A', '101', 'Bairro A', 'São Paulo', 'São Paulo', '01000-000', 'SP'),
(6, 'Rua B', '202', 'Bairro B', 'São Paulo', 'São Paulo', '02000-000', 'SP'),
(7, 'Rua C', '303', 'Bairro C', 'São Paulo', 'São Paulo', '03000-000', 'SP'),
(8, 'Rua D', '404', 'Bairro D', 'São Paulo', 'São Paulo', '04000-000', 'SP'),
(9, 'Rua E', '505', 'Bairro E', 'São Paulo', 'São Paulo', '05000-000', 'SP'),
(10, 'Rua F', '606', 'Bairro F', 'São Paulo', 'São Paulo', '06000-000', 'SP'),
(11, 'Rua G', '707', 'Bairro G', 'São Paulo', 'São Paulo', '07000-000', 'SP'),
(12, 'Rua H', '808', 'Bairro H', 'São Paulo', 'São Paulo', '08000-000', 'SP'),
(13, 'Rua I', '909', 'Bairro I', 'São Paulo', 'São Paulo', '09000-000', 'SP'),
(14, 'Rua J', '1010', 'Bairro J', 'São Paulo', 'São Paulo', '10000-000', 'SP'),
(15, 'Rua K', '1111', 'Bairro K', 'São Paulo', 'São Paulo', '11000-000', 'SP'),
(16, 'Rua L', '1212', 'Bairro L', 'São Paulo', 'São Paulo', '12000-000', 'SP'),
(17, 'Rua M', '1313', 'Bairro M', 'São Paulo', 'São Paulo', '13000-000', 'SP'),
(18, 'Rua N', '1414', 'Bairro N', 'São Paulo', 'São Paulo', '14000-000', 'SP'),
(19, 'Rua O', '1515', 'Bairro O', 'São Paulo', 'São Paulo', '15000-000', 'SP'),
(20, 'Rua P', '1616', 'Bairro P', 'São Paulo', 'São Paulo', '16000-000', 'SP'),
(21, 'Rua Q', '1717', 'Bairro Q', 'São Paulo', 'São Paulo', '17000-000', 'SP'),
(22, 'Rua R', '1818', 'Bairro R', 'São Paulo', 'São Paulo', '18000-000', 'SP'),
(23, 'Rua S', '1919', 'Bairro S', 'São Paulo', 'São Paulo', '19000-000', 'SP'),
(24, 'Rua T', '2020', 'Bairro T', 'São Paulo', 'São Paulo', '20000-000', 'SP');

-- ============================================
-- 5. INSERIR ADMINISTRADOR
-- ============================================
-- Hash BCrypt da senha: $2a$10$QosoIZARoPcs1uMI4UExI.ampEaJMB0B390y8QHhzY4gwV4IE2W16
INSERT IGNORE INTO funcionario (nome, email, senha, role, cpf, data_nascimento, status, notificacao_ativa, cargo, endereco_id, telefone, primeiro_acesso) VALUES
('Administrador', 'admin@onepilates.com', '$2a$10$QosoIZARoPcs1uMI4UExI.ampEaJMB0B390y8QHhzY4gwV4IE2W16', 'ADMINISTRADOR', '00000000000', '1980-01-01', TRUE, TRUE, 'Administrador', 1, '(11) 99999-0000', FALSE);


INSERT IGNORE INTO administrador (id) VALUES (1);

-- ============================================
-- 6. INSERIR PROFESSORES
-- ============================================
-- Professor 1: Andrei Scafi

INSERT IGNORE INTO funcionario (nome, email, senha, role, cpf, data_nascimento, status, notificacao_ativa, cargo, endereco_id, telefone, primeiro_acesso) VALUES
('Andrei Scafi', 'andreiscafi@gmail.com', '$2a$10$QosoIZARoPcs1uMI4UExI.ampEaJMB0B390y8QHhzY4gwV4IE2W16', 'PROFESSOR', '11122233300', '1990-05-15', TRUE, TRUE, 'Professor de Pilates', 2, '(11) 99999-1111', TRUE);

INSERT IGNORE INTO professor (id) VALUES (2);

-- Professor 2: Guilherme Queiroz
INSERT IGNORE INTO funcionario (nome, email, senha, role, cpf, data_nascimento, status, notificacao_ativa, cargo, endereco_id, telefone, primeiro_acesso) VALUES
('Guilherme Queiroz', 'andrei.vasconcelos@sptech.school', '$2a$10$QosoIZARoPcs1uMI4UExI.ampEaJMB0B390y8QHhzY4gwV4IE2W16', 'PROFESSOR', '22233344400', '1985-08-20', TRUE, TRUE, 'Professor de Pilates', 3, '(11) 99999-2222', TRUE);

INSERT IGNORE INTO professor (id) VALUES (3);

-- ============================================
-- 7. RELACIONAR PROFESSORES COM ESPECIALIDADES
-- ============================================
-- Andrei Scafi: Pilates, RPG, Fisioterapia
INSERT IGNORE INTO professor_especialidade (professor_id, especialidade_id) VALUES
(2, 1), -- Pilates
(2, 3), -- RPG
(2, 7); -- Fisioterapia

-- Guilherme Queiroz: Pilates, RPG, Fisioterapia
INSERT IGNORE INTO professor_especialidade (professor_id, especialidade_id) VALUES
(3, 1), -- Pilates
(3, 3), -- RPG
(3, 7); -- Fisioterapia

-- ============================================
-- 8. INSERIR SECRETÁRIA
-- ============================================
-- Secretária: Amanda

INSERT IGNORE INTO funcionario (nome, email, senha, role, cpf, data_nascimento, status, notificacao_ativa, cargo, endereco_id, telefone, primeiro_acesso) VALUES
('Amanda', 'amanda@email.com', '$2a$10$QosoIZARoPcs1uMI4UExI.ampEaJMB0B390y8QHhzY4gwV4IE2W16', 'SECRETARIA', '33344455500', '1992-03-10', TRUE, TRUE, 'Secretária', 4, '(11) 99999-3333', FALSE);

INSERT IGNORE INTO secretaria (id) VALUES (4);

-- ============================================
-- 9. INSERIR ALUNOS (20 alunos)
-- ============================================
INSERT IGNORE INTO aluno (nome, email, cpf, data_nascimento, status, aluno_com_limitacoes_fisicas, tipo_contato, notificacao_ativa, observacao, endereco_id) VALUES
('Ana Silva', 'ana.silva@email.com', '11111111111', '1995-01-15', TRUE, FALSE, 'EMAIL', TRUE, NULL, 5),
('Bruno Santos', 'bruno.santos@email.com', '22222222222', '1990-02-20', TRUE, FALSE, 'EMAIL', TRUE, NULL, 6),
('Carla Oliveira', 'carla.oliveira@email.com', '33333333333', '1988-03-25', TRUE, TRUE, 'EMAIL', TRUE, 'Usuária de cadeira de rodas', 7),
('Daniel Costa', 'daniel.costa@email.com', '44444444444', '1992-04-10', TRUE, FALSE, 'EMAIL', TRUE, NULL, 8),
('Elena Ferreira', 'elena.ferreira@email.com', '55555555555', '1994-05-05', TRUE, FALSE, 'EMAIL', TRUE, NULL, 9),
('Fernando Lima', 'fernando.lima@email.com', '66666666666', '1987-06-12', TRUE, FALSE, 'EMAIL', TRUE, NULL, 10),
('Gabriela Souza', 'gabriela.souza@email.com', '77777777777', '1991-07-18', TRUE, TRUE, 'EMAIL', TRUE, 'Limitação física leve', 11),
('Henrique Alves', 'henrique.alves@email.com', '88888888888', '1989-08-22', TRUE, FALSE, 'EMAIL', TRUE, NULL, 12),
('Isabela Martins', 'isabela.martins@email.com', '99999999999', '1993-09-30', TRUE, FALSE, 'EMAIL', TRUE, NULL, 13),
('João Pereira', 'joao.pereira@email.com', '10101010101', '1986-10-05', TRUE, FALSE, 'EMAIL', TRUE, NULL, 14),
('Karina Rocha', 'karina.rocha@email.com', '12121212121', '1996-11-15', TRUE, FALSE, 'EMAIL', TRUE, NULL, 15),
('Lucas Barbosa', 'lucas.barbosa@email.com', '13131313131', '1990-12-20', TRUE, TRUE, 'EMAIL', TRUE, 'Necessita equipamento PCD', 16),
('Mariana Dias', 'mariana.dias@email.com', '14141414141', '1992-01-25', TRUE, FALSE, 'EMAIL', TRUE, NULL, 17),
('Nicolas Ramos', 'nicolas.ramos@email.com', '15151515151', '1988-02-14', TRUE, FALSE, 'EMAIL', TRUE, NULL, 18),
('Olivia Cardoso', 'olivia.cardoso@email.com', '16161616161', '1994-03-08', TRUE, FALSE, 'EMAIL', TRUE, NULL, 19),
('Pedro Mendes', 'pedro.mendes@email.com', '17171717171', '1991-04-12', TRUE, FALSE, 'EMAIL', TRUE, NULL, 20),
('Quiteria Nunes', 'quiteria.nunes@email.com', '18181818181', '1989-05-18', TRUE, TRUE, 'EMAIL', TRUE, 'Limitação física moderada', 21),
('Rafael Teixeira', 'rafael.teixeira@email.com', '19191919191', '1993-06-22', TRUE, FALSE, 'EMAIL', TRUE, NULL, 22),
('Sofia Araújo', 'sofia.araujo@email.com', '20202020202', '1995-07-28', TRUE, FALSE, 'EMAIL', TRUE, NULL, 23),
('Thiago Campos', 'thiago.campos@email.com', '21212121212', '1990-08-30', TRUE, FALSE, 'EMAIL', TRUE, NULL, 24);

-- ============================================
-- 10. INSERIR AGENDAMENTOS PARA O PROFESSOR ANDREI SCAFI
-- ============================================
-- Professor Andrei (ID: 2) - Especialidades: Pilates (1), RPG (3), Fisioterapia (7)
-- Salas: Sala Grande 1 (1) ou Sala Grande 2 (2)
-- Regras: Segunda a Sexta, 9h-18h (hora cheia), excluindo 12h-13h (almoço)
-- IMPORTANTE: Respeitar conflitos com agendamentos do professor Guilherme (sala e alunos)
-- Estratégia: Andrei usa principalmente Sala Grande 1, Guilherme usa Sala Grande 2

-- AGOSTO 2025
INSERT IGNORE INTO agendamento (id, data_hora, professor_id, sala_id, especialidade_id) VALUES
(1, '2025-08-04 08:00:00', 2, 1, 1), -- Segunda - Pilates
(2, '2025-08-04 10:00:00', 2, 1, 3), -- Segunda - RPG
(3, '2025-08-05 08:00:00', 2, 1, 1), -- Terça - Pilates
(4, '2025-08-05 10:00:00', 2, 1, 3), -- Terça - RPG
(5, '2025-08-07 08:00:00', 2, 1, 1), -- Quinta - Pilates
(6, '2025-08-07 14:00:00', 2, 2, 7), -- Quinta - Fisioterapia
(7, '2025-08-08 09:00:00', 2, 1, 3), -- Sexta - RPG (ajustado de 09/08 sábado)
(8, '2025-08-11 08:00:00', 2, 1, 1), -- Segunda - Pilates
(9, '2025-08-11 14:00:00', 2, 2, 7), -- Segunda - Fisioterapia
(10, '2025-08-12 08:00:00', 2, 1, 1), -- Terça - Pilates
(11, '2025-08-14 10:00:00', 2, 2, 7), -- Quinta - Fisioterapia
(12, '2025-08-15 09:00:00', 2, 1, 3), -- Sexta - RPG (ajustado de 16/08 sábado)
(13, '2025-08-18 08:00:00', 2, 1, 1), -- Segunda - Pilates
(14, '2025-08-19 08:00:00', 2, 1, 1), -- Terça - Pilates
(15, '2025-08-21 14:00:00', 2, 2, 7), -- Quinta - Fisioterapia
(16, '2025-08-22 10:00:00', 2, 1, 3), -- Sexta - RPG (ajustado de 23/08 sábado)
(17, '2025-08-25 08:00:00', 2, 1, 1), -- Segunda - Pilates
(18, '2025-08-25 10:00:00', 2, 1, 3), -- Segunda - RPG
(19, '2025-08-26 08:00:00', 2, 1, 1), -- Terça - Pilates
(20, '2025-08-28 10:00:00', 2, 2, 7), -- Quinta - Fisioterapia
(21, '2025-08-29 09:00:00', 2, 1, 3); -- Sexta - RPG (ajustado de 30/08 sábado)

-- SETEMBRO 2025
INSERT IGNORE INTO agendamento (id, data_hora, professor_id, sala_id, especialidade_id) VALUES
(22, '2025-09-01 08:00:00', 2, 1, 1), -- Segunda - Pilates
(23, '2025-09-01 14:00:00', 2, 2, 7), -- Segunda - Fisioterapia
(24, '2025-09-02 08:00:00', 2, 1, 1), -- Terça - Pilates
(25, '2025-09-04 10:00:00', 2, 1, 3), -- Quinta - RPG
(26, '2025-09-05 14:00:00', 2, 2, 7), -- Sexta - Fisioterapia (ajustado de 06/09 sábado)
(27, '2025-09-08 08:00:00', 2, 1, 1), -- Segunda - Pilates
(28, '2025-09-08 10:00:00', 2, 1, 3), -- Segunda - RPG
(29, '2025-09-09 08:00:00', 2, 1, 1), -- Terça - Pilates
(30, '2025-09-11 10:00:00', 2, 2, 7), -- Quinta - Fisioterapia
(31, '2025-09-12 09:00:00', 2, 1, 3), -- Sexta - RPG (ajustado de 13/09 sábado)
(32, '2025-09-15 08:00:00', 2, 1, 1), -- Segunda - Pilates
(33, '2025-09-16 08:00:00', 2, 1, 1), -- Terça - Pilates
(34, '2025-09-18 14:00:00', 2, 2, 7), -- Quinta - Fisioterapia
(35, '2025-09-19 10:00:00', 2, 1, 3), -- Sexta - RPG (ajustado de 20/09 sábado)
(36, '2025-09-22 08:00:00', 2, 1, 1), -- Segunda - Pilates
(37, '2025-09-22 10:00:00', 2, 1, 3), -- Segunda - RPG
(38, '2025-09-23 08:00:00', 2, 1, 1), -- Terça - Pilates
(39, '2025-09-25 10:00:00', 2, 2, 7), -- Quinta - Fisioterapia
(40, '2025-09-26 09:00:00', 2, 1, 3); -- Sexta - RPG (ajustado de 27/09 sábado)

-- OUTUBRO 2025
INSERT IGNORE INTO agendamento (id, data_hora, professor_id, sala_id, especialidade_id) VALUES
(41, '2025-10-01 08:00:00', 2, 1, 1), -- Quarta - Pilates
(42, '2025-10-02 10:00:00', 2, 1, 3), -- Quinta - RPG
(43, '2025-10-03 14:00:00', 2, 2, 7), -- Sexta - Fisioterapia (ajustado de 04/10 sábado)
(44, '2025-10-06 08:00:00', 2, 1, 1), -- Segunda - Pilates
(45, '2025-10-06 10:00:00', 2, 1, 3), -- Segunda - RPG
(46, '2025-10-07 08:00:00', 2, 1, 1), -- Terça - Pilates
(47, '2025-10-09 10:00:00', 2, 2, 7), -- Quinta - Fisioterapia
(48, '2025-10-10 09:00:00', 2, 1, 3), -- Sexta - RPG (ajustado de 11/10 sábado)
(49, '2025-10-13 08:00:00', 2, 1, 1), -- Segunda - Pilates
(50, '2025-10-13 14:00:00', 2, 2, 7), -- Segunda - Fisioterapia
(51, '2025-10-14 08:00:00', 2, 1, 1), -- Terça - Pilates
(52, '2025-10-16 14:00:00', 2, 2, 7), -- Quinta - Fisioterapia
(53, '2025-10-17 10:00:00', 2, 1, 3), -- Sexta - RPG (ajustado de 18/10 sábado)
(54, '2025-10-20 08:00:00', 2, 1, 1), -- Segunda - Pilates
(55, '2025-10-21 08:00:00', 2, 1, 1), -- Terça - Pilates
(56, '2025-10-23 10:00:00', 2, 2, 7), -- Quinta - Fisioterapia
(57, '2025-10-24 09:00:00', 2, 1, 3), -- Sexta - RPG (ajustado de 25/10 sábado)
(58, '2025-10-27 08:00:00', 2, 1, 1), -- Segunda - Pilates
(59, '2025-10-27 10:00:00', 2, 1, 3), -- Segunda - RPG
(60, '2025-10-28 08:00:00', 2, 1, 1), -- Terça - Pilates
(61, '2025-10-30 14:00:00', 2, 2, 7); -- Quinta - Fisioterapia

-- NOVEMBRO 2025
INSERT IGNORE INTO agendamento (id, data_hora, professor_id, sala_id, especialidade_id) VALUES
(62, '2025-10-31 09:00:00', 2, 1, 3), -- Sexta - RPG (ajustado de 01/11 sábado)
(63, '2025-11-03 08:00:00', 2, 1, 1), -- Segunda - Pilates
(64, '2025-11-03 10:00:00', 2, 1, 3), -- Segunda - RPG
(65, '2025-11-04 08:00:00', 2, 1, 1), -- Terça - Pilates
(66, '2025-11-06 10:00:00', 2, 2, 7), -- Quinta - Fisioterapia
(67, '2025-11-07 09:00:00', 2, 1, 3), -- Sexta - RPG (ajustado de 08/11 sábado)
(68, '2025-11-10 08:00:00', 2, 1, 1), -- Segunda - Pilates
(69, '2025-11-10 14:00:00', 2, 2, 7), -- Segunda - Fisioterapia
(70, '2025-11-11 08:00:00', 2, 1, 1), -- Terça - Pilates
(71, '2025-11-13 14:00:00', 2, 2, 7), -- Quinta - Fisioterapia
(72, '2025-11-14 10:00:00', 2, 1, 3), -- Sexta - RPG (ajustado de 15/11 sábado)
(73, '2025-11-17 08:00:00', 2, 1, 1), -- Segunda - Pilates
(74, '2025-11-18 08:00:00', 2, 1, 1), -- Terça - Pilates
(75, '2025-11-20 10:00:00', 2, 2, 7), -- Quinta - Fisioterapia
(76, '2025-11-21 09:00:00', 2, 1, 3), -- Sexta - RPG (ajustado de 22/11 sábado)
(77, '2025-11-24 08:00:00', 2, 1, 1), -- Segunda - Pilates
(78, '2025-11-24 10:00:00', 2, 1, 3), -- Segunda - RPG
(79, '2025-11-25 08:00:00', 2, 1, 1), -- Terça - Pilates
(80, '2025-11-27 14:00:00', 2, 2, 7); -- Quinta - Fisioterapia

-- DEZEMBRO 2025
INSERT IGNORE INTO agendamento (id, data_hora, professor_id, sala_id, especialidade_id) VALUES
(81, '2025-12-01 08:00:00', 2, 1, 1), -- Segunda - Pilates
(82, '2025-12-01 10:00:00', 2, 1, 3), -- Segunda - RPG
(83, '2025-12-02 08:00:00', 2, 1, 1), -- Terça - Pilates
(84, '2025-12-04 10:00:00', 2, 1, 3), -- Quinta - RPG
(85, '2025-12-05 14:00:00', 2, 2, 7), -- Sexta - Fisioterapia (ajustado de 06/12 sábado)
(86, '2025-12-08 08:00:00', 2, 1, 1), -- Segunda - Pilates
(87, '2025-12-08 14:00:00', 2, 2, 7), -- Segunda - Fisioterapia
(88, '2025-12-09 08:00:00', 2, 1, 1), -- Terça - Pilates
(89, '2025-12-11 10:00:00', 2, 2, 7), -- Quinta - Fisioterapia
(90, '2025-12-12 09:00:00', 2, 1, 3), -- Sexta - RPG (ajustado de 13/12 sábado)
(91, '2025-12-15 08:00:00', 2, 1, 1), -- Segunda - Pilates
(92, '2025-12-15 10:00:00', 2, 1, 3), -- Segunda - RPG
(93, '2025-12-16 08:00:00', 2, 1, 1), -- Terça - Pilates
(94, '2025-12-18 14:00:00', 2, 2, 7), -- Quinta - Fisioterapia
(95, '2025-12-19 10:00:00', 2, 1, 3), -- Sexta - RPG (ajustado de 20/12 sábado)
(96, '2025-12-22 08:00:00', 2, 1, 1), -- Segunda - Pilates
(97, '2025-12-22 14:00:00', 2, 2, 7); -- Segunda - Fisioterapia

-- ============================================
-- 10B. INSERIR AGENDAMENTOS PARA O PROFESSOR GUILHERME QUEIROZ
-- ============================================
-- Professor Guilherme (ID: 3) - Especialidades: Pilates (1), RPG (3), Fisioterapia (7)
-- Salas: Sala Grande 2 (2) principalmente, ocasionalmente Sala Grande 1 (1)
-- Regras: Segunda a Sexta, 9h-18h (hora cheia), excluindo 12h-13h (almoço)
-- Estratégia: Guilherme usa principalmente Sala Grande 2 para evitar conflitos com Andrei

-- AGOSTO 2025
INSERT IGNORE INTO agendamento (id, data_hora, professor_id, sala_id, especialidade_id) VALUES
(98, '2025-08-04 09:00:00', 3, 2, 1), -- Segunda - Pilates
(99, '2025-08-04 11:00:00', 3, 2, 3), -- Segunda - RPG
(100, '2025-08-04 13:00:00', 3, 2, 7), -- Segunda - Fisioterapia
(101, '2025-08-04 15:00:00', 3, 2, 1), -- Segunda - Pilates
(102, '2025-08-05 09:00:00', 3, 2, 3), -- Terça - RPG
(103, '2025-08-05 11:00:00', 3, 2, 1), -- Terça - Pilates
(104, '2025-08-05 14:00:00', 3, 2, 7), -- Terça - Fisioterapia
(105, '2025-08-05 16:00:00', 3, 2, 1), -- Terça - Pilates
(106, '2025-08-06 09:00:00', 3, 2, 1), -- Quarta - Pilates
(107, '2025-08-06 11:00:00', 3, 2, 3), -- Quarta - RPG
(108, '2025-08-06 13:00:00', 3, 2, 7), -- Quarta - Fisioterapia
(109, '2025-08-06 15:00:00', 3, 2, 1), -- Quarta - Pilates
(110, '2025-08-07 09:00:00', 3, 2, 3), -- Quinta - RPG
(111, '2025-08-07 11:00:00', 3, 2, 1), -- Quinta - Pilates
(112, '2025-08-07 15:00:00', 3, 2, 7), -- Quinta - Fisioterapia
(113, '2025-08-07 17:00:00', 3, 2, 1), -- Quinta - Pilates
(114, '2025-08-08 09:00:00', 3, 2, 1), -- Sexta - Pilates
(115, '2025-08-08 11:00:00', 3, 2, 3), -- Sexta - RPG
(116, '2025-08-08 13:00:00', 3, 2, 7), -- Sexta - Fisioterapia
(117, '2025-08-08 15:00:00', 3, 2, 1), -- Sexta - Pilates
(118, '2025-08-11 09:00:00', 3, 2, 3), -- Segunda - RPG
(119, '2025-08-11 11:00:00', 3, 2, 1), -- Segunda - Pilates
(120, '2025-08-11 15:00:00', 3, 2, 7), -- Segunda - Fisioterapia
(121, '2025-08-11 17:00:00', 3, 2, 1), -- Segunda - Pilates
(122, '2025-08-12 09:00:00', 3, 2, 1), -- Terça - Pilates
(123, '2025-08-12 11:00:00', 3, 2, 3), -- Terça - RPG
(124, '2025-08-12 13:00:00', 3, 2, 7), -- Terça - Fisioterapia
(125, '2025-08-12 15:00:00', 3, 2, 1), -- Terça - Pilates
(126, '2025-08-13 09:00:00', 3, 2, 1), -- Quarta - Pilates
(127, '2025-08-13 11:00:00', 3, 2, 3), -- Quarta - RPG
(128, '2025-08-13 14:00:00', 3, 2, 7), -- Quarta - Fisioterapia
(129, '2025-08-13 16:00:00', 3, 2, 1), -- Quarta - Pilates
(130, '2025-08-14 09:00:00', 3, 2, 1), -- Quinta - Pilates
(131, '2025-08-14 11:00:00', 3, 2, 3), -- Quinta - RPG
(132, '2025-08-14 15:00:00', 3, 2, 1), -- Quinta - Pilates
(133, '2025-08-14 17:00:00', 3, 2, 7), -- Quinta - Fisioterapia
(134, '2025-08-15 09:00:00', 3, 2, 3), -- Sexta - RPG
(135, '2025-08-15 11:00:00', 3, 2, 1), -- Sexta - Pilates
(136, '2025-08-15 13:00:00', 3, 2, 7), -- Sexta - Fisioterapia
(137, '2025-08-15 15:00:00', 3, 2, 1), -- Sexta - Pilates
(138, '2025-08-18 09:00:00', 3, 2, 1), -- Segunda - Pilates
(139, '2025-08-18 11:00:00', 3, 2, 3), -- Segunda - RPG
(140, '2025-08-18 13:00:00', 3, 2, 7), -- Segunda - Fisioterapia
(141, '2025-08-18 15:00:00', 3, 2, 1), -- Segunda - Pilates
(142, '2025-08-19 09:00:00', 3, 2, 3), -- Terça - RPG
(143, '2025-08-19 11:00:00', 3, 2, 1), -- Terça - Pilates
(144, '2025-08-19 14:00:00', 3, 2, 7), -- Terça - Fisioterapia
(145, '2025-08-19 16:00:00', 3, 2, 1); -- Terça - Pilates

-- SETEMBRO 2025
INSERT IGNORE INTO agendamento (id, data_hora, professor_id, sala_id, especialidade_id) VALUES
(146, '2025-09-01 09:00:00', 3, 2, 1), -- Segunda - Pilates
(147, '2025-09-01 11:00:00', 3, 2, 3), -- Segunda - RPG
(148, '2025-09-01 15:00:00', 3, 2, 7), -- Segunda - Fisioterapia
(149, '2025-09-01 17:00:00', 3, 2, 1), -- Segunda - Pilates
(150, '2025-09-02 09:00:00', 3, 2, 1), -- Terça - Pilates
(151, '2025-09-02 11:00:00', 3, 2, 3), -- Terça - RPG
(152, '2025-09-02 13:00:00', 3, 2, 7), -- Terça - Fisioterapia
(153, '2025-09-02 15:00:00', 3, 2, 1), -- Terça - Pilates
(154, '2025-09-03 09:00:00', 3, 2, 1), -- Quarta - Pilates
(155, '2025-09-03 11:00:00', 3, 2, 3), -- Quarta - RPG
(156, '2025-09-03 14:00:00', 3, 2, 7), -- Quarta - Fisioterapia
(157, '2025-09-03 16:00:00', 3, 2, 1), -- Quarta - Pilates
(158, '2025-09-04 09:00:00', 3, 2, 1), -- Quinta - Pilates
(159, '2025-09-04 11:00:00', 3, 2, 3), -- Quinta - RPG
(160, '2025-09-04 15:00:00', 3, 2, 1), -- Quinta - Pilates
(161, '2025-09-04 17:00:00', 3, 2, 7), -- Quinta - Fisioterapia
(162, '2025-09-05 09:00:00', 3, 2, 3), -- Sexta - RPG
(163, '2025-09-05 11:00:00', 3, 2, 1), -- Sexta - Pilates
(164, '2025-09-05 13:00:00', 3, 2, 7), -- Sexta - Fisioterapia
(165, '2025-09-05 15:00:00', 3, 2, 1), -- Sexta - Pilates
(166, '2025-09-08 09:00:00', 3, 2, 1), -- Segunda - Pilates
(167, '2025-09-08 11:00:00', 3, 2, 3), -- Segunda - RPG
(168, '2025-09-08 15:00:00', 3, 2, 7), -- Segunda - Fisioterapia
(169, '2025-09-08 17:00:00', 3, 2, 1), -- Segunda - Pilates
(170, '2025-09-09 09:00:00', 3, 2, 3), -- Terça - RPG
(171, '2025-09-09 11:00:00', 3, 2, 1), -- Terça - Pilates
(172, '2025-09-09 13:00:00', 3, 2, 7), -- Terça - Fisioterapia
(173, '2025-09-09 15:00:00', 3, 2, 1), -- Terça - Pilates
(174, '2025-09-10 09:00:00', 3, 2, 1), -- Quarta - Pilates
(175, '2025-09-10 11:00:00', 3, 2, 3), -- Quarta - RPG
(176, '2025-09-10 14:00:00', 3, 2, 7), -- Quarta - Fisioterapia
(177, '2025-09-10 16:00:00', 3, 2, 1), -- Quarta - Pilates
(178, '2025-09-11 09:00:00', 3, 2, 1), -- Quinta - Pilates
(179, '2025-09-11 11:00:00', 3, 2, 3), -- Quinta - RPG
(180, '2025-09-11 15:00:00', 3, 2, 1), -- Quinta - Pilates
(181, '2025-09-11 17:00:00', 3, 2, 7), -- Quinta - Fisioterapia
(182, '2025-09-12 09:00:00', 3, 2, 3), -- Sexta - RPG
(183, '2025-09-12 11:00:00', 3, 2, 1), -- Sexta - Pilates
(184, '2025-09-12 13:00:00', 3, 2, 7), -- Sexta - Fisioterapia
(185, '2025-09-12 15:00:00', 3, 2, 1), -- Sexta - Pilates
(186, '2025-09-15 09:00:00', 3, 2, 1), -- Segunda - Pilates
(187, '2025-09-15 11:00:00', 3, 2, 3), -- Segunda - RPG
(188, '2025-09-15 15:00:00', 3, 2, 7), -- Segunda - Fisioterapia
(189, '2025-09-15 17:00:00', 3, 2, 1), -- Segunda - Pilates
(190, '2025-09-16 09:00:00', 3, 2, 3), -- Terça - RPG
(191, '2025-09-16 11:00:00', 3, 2, 1), -- Terça - Pilates
(192, '2025-09-16 13:00:00', 3, 2, 7), -- Terça - Fisioterapia
(193, '2025-09-16 15:00:00', 3, 2, 1), -- Terça - Pilates
(194, '2025-09-17 09:00:00', 3, 2, 1), -- Quarta - Pilates
(195, '2025-09-17 11:00:00', 3, 2, 3), -- Quarta - RPG
(196, '2025-09-17 14:00:00', 3, 2, 7), -- Quarta - Fisioterapia
(197, '2025-09-17 16:00:00', 3, 2, 1), -- Quarta - Pilates
(198, '2025-09-18 09:00:00', 3, 2, 1), -- Quinta - Pilates
(199, '2025-09-18 11:00:00', 3, 2, 3), -- Quinta - RPG
(200, '2025-09-18 15:00:00', 3, 2, 1), -- Quinta - Pilates
(201, '2025-09-18 17:00:00', 3, 2, 7), -- Quinta - Fisioterapia
(202, '2025-09-19 09:00:00', 3, 2, 3), -- Sexta - RPG
(203, '2025-09-19 11:00:00', 3, 2, 1), -- Sexta - Pilates
(204, '2025-09-19 13:00:00', 3, 2, 7), -- Sexta - Fisioterapia
(205, '2025-09-19 15:00:00', 3, 2, 1), -- Sexta - Pilates
(206, '2025-09-22 09:00:00', 3, 2, 1), -- Segunda - Pilates
(207, '2025-09-22 11:00:00', 3, 2, 3), -- Segunda - RPG
(208, '2025-09-22 15:00:00', 3, 2, 7), -- Segunda - Fisioterapia
(209, '2025-09-22 17:00:00', 3, 2, 1), -- Segunda - Pilates
(210, '2025-09-23 09:00:00', 3, 2, 3), -- Terça - RPG
(211, '2025-09-23 11:00:00', 3, 2, 1), -- Terça - Pilates
(212, '2025-09-23 13:00:00', 3, 2, 7), -- Terça - Fisioterapia
(213, '2025-09-23 15:00:00', 3, 2, 1), -- Terça - Pilates
(214, '2025-09-24 09:00:00', 3, 2, 1), -- Quarta - Pilates
(215, '2025-09-24 11:00:00', 3, 2, 3), -- Quarta - RPG
(216, '2025-09-24 14:00:00', 3, 2, 7), -- Quarta - Fisioterapia
(217, '2025-09-24 16:00:00', 3, 2, 1), -- Quarta - Pilates
(218, '2025-09-25 09:00:00', 3, 2, 1), -- Quinta - Pilates
(219, '2025-09-25 11:00:00', 3, 2, 3), -- Quinta - RPG
(220, '2025-09-25 15:00:00', 3, 2, 1), -- Quinta - Pilates
(221, '2025-09-25 17:00:00', 3, 2, 7), -- Quinta - Fisioterapia
(222, '2025-09-26 09:00:00', 3, 2, 3), -- Sexta - RPG
(223, '2025-09-26 11:00:00', 3, 2, 1), -- Sexta - Pilates
(224, '2025-09-26 13:00:00', 3, 2, 7), -- Sexta - Fisioterapia
(225, '2025-09-26 15:00:00', 3, 2, 1); -- Sexta - Pilates

-- OUTUBRO 2025
INSERT IGNORE INTO agendamento (id, data_hora, professor_id, sala_id, especialidade_id) VALUES
(226, '2025-10-01 09:00:00', 3, 2, 1), -- Quarta - Pilates
(227, '2025-10-01 11:00:00', 3, 2, 3), -- Quarta - RPG
(228, '2025-10-01 14:00:00', 3, 2, 7), -- Quarta - Fisioterapia
(229, '2025-10-01 16:00:00', 3, 2, 1), -- Quarta - Pilates
(230, '2025-10-02 09:00:00', 3, 2, 1), -- Quinta - Pilates
(231, '2025-10-02 11:00:00', 3, 2, 3), -- Quinta - RPG
(232, '2025-10-02 15:00:00', 3, 2, 1), -- Quinta - Pilates
(233, '2025-10-02 17:00:00', 3, 2, 7), -- Quinta - Fisioterapia
(234, '2025-10-03 09:00:00', 3, 2, 3), -- Sexta - RPG
(235, '2025-10-03 11:00:00', 3, 2, 1), -- Sexta - Pilates
(236, '2025-10-03 13:00:00', 3, 2, 7), -- Sexta - Fisioterapia
(237, '2025-10-03 15:00:00', 3, 2, 1), -- Sexta - Pilates
(238, '2025-10-06 09:00:00', 3, 2, 1), -- Segunda - Pilates
(239, '2025-10-06 11:00:00', 3, 2, 3), -- Segunda - RPG
(240, '2025-10-06 15:00:00', 3, 2, 7), -- Segunda - Fisioterapia
(241, '2025-10-06 17:00:00', 3, 2, 1), -- Segunda - Pilates
(242, '2025-10-07 09:00:00', 3, 2, 3), -- Terça - RPG
(243, '2025-10-07 11:00:00', 3, 2, 1), -- Terça - Pilates
(244, '2025-10-07 13:00:00', 3, 2, 7), -- Terça - Fisioterapia
(245, '2025-10-07 15:00:00', 3, 2, 1), -- Terça - Pilates
(246, '2025-10-08 09:00:00', 3, 2, 1), -- Quarta - Pilates
(247, '2025-10-08 11:00:00', 3, 2, 3), -- Quarta - RPG
(248, '2025-10-08 14:00:00', 3, 2, 7), -- Quarta - Fisioterapia
(249, '2025-10-08 16:00:00', 3, 2, 1), -- Quarta - Pilates
(250, '2025-10-09 09:00:00', 3, 2, 1), -- Quinta - Pilates
(251, '2025-10-09 11:00:00', 3, 2, 3), -- Quinta - RPG
(252, '2025-10-09 15:00:00', 3, 2, 1), -- Quinta - Pilates
(253, '2025-10-09 17:00:00', 3, 2, 7), -- Quinta - Fisioterapia
(254, '2025-10-10 09:00:00', 3, 2, 3), -- Sexta - RPG
(255, '2025-10-10 11:00:00', 3, 2, 1), -- Sexta - Pilates
(256, '2025-10-10 13:00:00', 3, 2, 7), -- Sexta - Fisioterapia
(257, '2025-10-10 15:00:00', 3, 2, 1), -- Sexta - Pilates
(258, '2025-10-13 09:00:00', 3, 2, 1), -- Segunda - Pilates
(259, '2025-10-13 11:00:00', 3, 2, 3), -- Segunda - RPG
(260, '2025-10-13 15:00:00', 3, 2, 7), -- Segunda - Fisioterapia
(261, '2025-10-13 17:00:00', 3, 2, 1), -- Segunda - Pilates
(262, '2025-10-14 09:00:00', 3, 2, 3), -- Terça - RPG
(263, '2025-10-14 11:00:00', 3, 2, 1), -- Terça - Pilates
(264, '2025-10-14 13:00:00', 3, 2, 7), -- Terça - Fisioterapia
(265, '2025-10-14 15:00:00', 3, 2, 1), -- Terça - Pilates
(266, '2025-10-15 09:00:00', 3, 2, 1), -- Quarta - Pilates
(267, '2025-10-15 11:00:00', 3, 2, 3), -- Quarta - RPG
(268, '2025-10-15 14:00:00', 3, 2, 7), -- Quarta - Fisioterapia
(269, '2025-10-15 16:00:00', 3, 2, 1), -- Quarta - Pilates
(270, '2025-10-16 09:00:00', 3, 2, 1), -- Quinta - Pilates
(271, '2025-10-16 11:00:00', 3, 2, 3), -- Quinta - RPG
(272, '2025-10-16 15:00:00', 3, 2, 1), -- Quinta - Pilates
(273, '2025-10-16 17:00:00', 3, 2, 7), -- Quinta - Fisioterapia
(274, '2025-10-17 09:00:00', 3, 2, 3), -- Sexta - RPG
(275, '2025-10-17 11:00:00', 3, 2, 1), -- Sexta - Pilates
(276, '2025-10-17 13:00:00', 3, 2, 7), -- Sexta - Fisioterapia
(277, '2025-10-17 15:00:00', 3, 2, 1), -- Sexta - Pilates
(278, '2025-10-20 09:00:00', 3, 2, 1), -- Segunda - Pilates
(279, '2025-10-20 11:00:00', 3, 2, 3), -- Segunda - RPG
(280, '2025-10-20 15:00:00', 3, 2, 7), -- Segunda - Fisioterapia
(281, '2025-10-20 17:00:00', 3, 2, 1), -- Segunda - Pilates
(282, '2025-10-21 09:00:00', 3, 2, 3), -- Terça - RPG
(283, '2025-10-21 11:00:00', 3, 2, 1), -- Terça - Pilates
(284, '2025-10-21 13:00:00', 3, 2, 7), -- Terça - Fisioterapia
(285, '2025-10-21 15:00:00', 3, 2, 1), -- Terça - Pilates
(286, '2025-10-22 09:00:00', 3, 2, 1), -- Quarta - Pilates
(287, '2025-10-22 11:00:00', 3, 2, 3), -- Quarta - RPG
(288, '2025-10-22 14:00:00', 3, 2, 7), -- Quarta - Fisioterapia
(289, '2025-10-22 16:00:00', 3, 2, 1), -- Quarta - Pilates
(290, '2025-10-23 09:00:00', 3, 2, 1), -- Quinta - Pilates
(291, '2025-10-23 11:00:00', 3, 2, 3), -- Quinta - RPG
(292, '2025-10-23 15:00:00', 3, 2, 1), -- Quinta - Pilates
(293, '2025-10-23 17:00:00', 3, 2, 7), -- Quinta - Fisioterapia
(294, '2025-10-24 09:00:00', 3, 2, 3), -- Sexta - RPG
(295, '2025-10-24 11:00:00', 3, 2, 1), -- Sexta - Pilates
(296, '2025-10-24 13:00:00', 3, 2, 7), -- Sexta - Fisioterapia
(297, '2025-10-24 15:00:00', 3, 2, 1), -- Sexta - Pilates
(298, '2025-10-27 09:00:00', 3, 2, 1), -- Segunda - Pilates
(299, '2025-10-27 11:00:00', 3, 2, 3), -- Segunda - RPG
(300, '2025-10-27 15:00:00', 3, 2, 7), -- Segunda - Fisioterapia
(301, '2025-10-27 17:00:00', 3, 2, 1), -- Segunda - Pilates
(302, '2025-10-28 09:00:00', 3, 2, 3), -- Terça - RPG
(303, '2025-10-28 11:00:00', 3, 2, 1), -- Terça - Pilates
(304, '2025-10-28 13:00:00', 3, 2, 7), -- Terça - Fisioterapia
(305, '2025-10-28 15:00:00', 3, 2, 1), -- Terça - Pilates
(306, '2025-10-29 09:00:00', 3, 2, 1), -- Quarta - Pilates
(307, '2025-10-29 11:00:00', 3, 2, 3), -- Quarta - RPG
(308, '2025-10-29 14:00:00', 3, 2, 7), -- Quarta - Fisioterapia
(309, '2025-10-29 16:00:00', 3, 2, 1), -- Quarta - Pilates
(310, '2025-10-30 09:00:00', 3, 2, 1), -- Quinta - Pilates
(311, '2025-10-30 11:00:00', 3, 2, 3), -- Quinta - RPG
(312, '2025-10-30 15:00:00', 3, 2, 1), -- Quinta - Pilates
(313, '2025-10-30 17:00:00', 3, 2, 7), -- Quinta - Fisioterapia
(314, '2025-10-31 09:00:00', 3, 2, 3), -- Sexta - RPG
(315, '2025-10-31 11:00:00', 3, 2, 1), -- Sexta - Pilates
(316, '2025-10-31 13:00:00', 3, 2, 7), -- Sexta - Fisioterapia
(317, '2025-10-31 15:00:00', 3, 2, 1); -- Sexta - Pilates

-- NOVEMBRO 2025
INSERT IGNORE INTO agendamento (id, data_hora, professor_id, sala_id, especialidade_id) VALUES
(318, '2025-11-03 09:00:00', 3, 2, 1), -- Segunda - Pilates
(319, '2025-11-03 11:00:00', 3, 2, 3), -- Segunda - RPG
(320, '2025-11-03 15:00:00', 3, 2, 7), -- Segunda - Fisioterapia
(321, '2025-11-03 17:00:00', 3, 2, 1), -- Segunda - Pilates
(322, '2025-11-04 09:00:00', 3, 2, 3), -- Terça - RPG
(323, '2025-11-04 11:00:00', 3, 2, 1), -- Terça - Pilates
(324, '2025-11-04 13:00:00', 3, 2, 7), -- Terça - Fisioterapia
(325, '2025-11-04 15:00:00', 3, 2, 1), -- Terça - Pilates
(326, '2025-11-05 09:00:00', 3, 2, 1), -- Quarta - Pilates
(327, '2025-11-05 11:00:00', 3, 2, 3), -- Quarta - RPG
(328, '2025-11-05 14:00:00', 3, 2, 7), -- Quarta - Fisioterapia
(329, '2025-11-05 16:00:00', 3, 2, 1), -- Quarta - Pilates
(330, '2025-11-06 09:00:00', 3, 2, 1), -- Quinta - Pilates
(331, '2025-11-06 11:00:00', 3, 2, 3), -- Quinta - RPG
(332, '2025-11-06 15:00:00', 3, 2, 1), -- Quinta - Pilates
(333, '2025-11-06 17:00:00', 3, 2, 7), -- Quinta - Fisioterapia
(334, '2025-11-07 09:00:00', 3, 2, 3), -- Sexta - RPG
(335, '2025-11-07 11:00:00', 3, 2, 1), -- Sexta - Pilates
(336, '2025-11-07 13:00:00', 3, 2, 7), -- Sexta - Fisioterapia
(337, '2025-11-07 15:00:00', 3, 2, 1), -- Sexta - Pilates
(338, '2025-11-10 09:00:00', 3, 2, 1), -- Segunda - Pilates
(339, '2025-11-10 11:00:00', 3, 2, 3), -- Segunda - RPG
(340, '2025-11-10 15:00:00', 3, 2, 7), -- Segunda - Fisioterapia
(341, '2025-11-10 17:00:00', 3, 2, 1), -- Segunda - Pilates
(342, '2025-11-11 09:00:00', 3, 2, 3), -- Terça - RPG
(343, '2025-11-11 11:00:00', 3, 2, 1), -- Terça - Pilates
(344, '2025-11-11 13:00:00', 3, 2, 7), -- Terça - Fisioterapia
(345, '2025-11-11 15:00:00', 3, 2, 1), -- Terça - Pilates
(346, '2025-11-12 09:00:00', 3, 2, 1), -- Quarta - Pilates
(347, '2025-11-12 11:00:00', 3, 2, 3), -- Quarta - RPG
(348, '2025-11-12 14:00:00', 3, 2, 7), -- Quarta - Fisioterapia
(349, '2025-11-12 16:00:00', 3, 2, 1), -- Quarta - Pilates
(350, '2025-11-13 09:00:00', 3, 2, 1), -- Quinta - Pilates
(351, '2025-11-13 11:00:00', 3, 2, 3), -- Quinta - RPG
(352, '2025-11-13 15:00:00', 3, 2, 1), -- Quinta - Pilates
(353, '2025-11-13 17:00:00', 3, 2, 7), -- Quinta - Fisioterapia
(354, '2025-11-14 09:00:00', 3, 2, 3), -- Sexta - RPG
(355, '2025-11-14 11:00:00', 3, 2, 1), -- Sexta - Pilates
(356, '2025-11-14 13:00:00', 3, 2, 7), -- Sexta - Fisioterapia
(357, '2025-11-14 15:00:00', 3, 2, 1), -- Sexta - Pilates
(358, '2025-11-17 09:00:00', 3, 2, 1), -- Segunda - Pilates
(359, '2025-11-17 11:00:00', 3, 2, 3), -- Segunda - RPG
(360, '2025-11-17 15:00:00', 3, 2, 7), -- Segunda - Fisioterapia
(361, '2025-11-17 17:00:00', 3, 2, 1), -- Segunda - Pilates
(362, '2025-11-18 09:00:00', 3, 2, 3), -- Terça - RPG
(363, '2025-11-18 11:00:00', 3, 2, 1), -- Terça - Pilates
(364, '2025-11-18 13:00:00', 3, 2, 7), -- Terça - Fisioterapia
(365, '2025-11-18 15:00:00', 3, 2, 1), -- Terça - Pilates
(366, '2025-11-19 09:00:00', 3, 2, 1), -- Quarta - Pilates
(367, '2025-11-19 11:00:00', 3, 2, 3), -- Quarta - RPG
(368, '2025-11-19 14:00:00', 3, 2, 7), -- Quarta - Fisioterapia
(369, '2025-11-19 16:00:00', 3, 2, 1), -- Quarta - Pilates
(370, '2025-11-20 09:00:00', 3, 2, 1), -- Quinta - Pilates
(371, '2025-11-20 11:00:00', 3, 2, 3), -- Quinta - RPG
(372, '2025-11-20 15:00:00', 3, 2, 1), -- Quinta - Pilates
(373, '2025-11-20 17:00:00', 3, 2, 7), -- Quinta - Fisioterapia
(374, '2025-11-21 09:00:00', 3, 2, 3), -- Sexta - RPG
(375, '2025-11-21 11:00:00', 3, 2, 1), -- Sexta - Pilates
(376, '2025-11-21 13:00:00', 3, 2, 7), -- Sexta - Fisioterapia
(377, '2025-11-21 15:00:00', 3, 2, 1), -- Sexta - Pilates
(378, '2025-11-24 09:00:00', 3, 2, 1), -- Segunda - Pilates
(379, '2025-11-24 11:00:00', 3, 2, 3), -- Segunda - RPG
(380, '2025-11-24 15:00:00', 3, 2, 7), -- Segunda - Fisioterapia
(381, '2025-11-24 17:00:00', 3, 2, 1), -- Segunda - Pilates
(382, '2025-11-25 09:00:00', 3, 2, 3), -- Terça - RPG
(383, '2025-11-25 11:00:00', 3, 2, 1), -- Terça - Pilates
(384, '2025-11-25 13:00:00', 3, 2, 7), -- Terça - Fisioterapia
(385, '2025-11-25 15:00:00', 3, 2, 1), -- Terça - Pilates
(386, '2025-11-26 09:00:00', 3, 2, 1), -- Quarta - Pilates
(387, '2025-11-26 11:00:00', 3, 2, 3), -- Quarta - RPG
(388, '2025-11-26 14:00:00', 3, 2, 7), -- Quarta - Fisioterapia
(389, '2025-11-26 16:00:00', 3, 2, 1), -- Quarta - Pilates
(390, '2025-11-27 09:00:00', 3, 2, 1), -- Quinta - Pilates
(391, '2025-11-27 11:00:00', 3, 2, 3), -- Quinta - RPG
(392, '2025-11-27 15:00:00', 3, 2, 1), -- Quinta - Pilates
(393, '2025-11-27 17:00:00', 3, 2, 7); -- Quinta - Fisioterapia

-- DEZEMBRO 2025
INSERT IGNORE INTO agendamento (id, data_hora, professor_id, sala_id, especialidade_id) VALUES
(394, '2025-12-01 09:00:00', 3, 2, 1), -- Segunda - Pilates
(395, '2025-12-01 11:00:00', 3, 2, 3), -- Segunda - RPG
(396, '2025-12-01 15:00:00', 3, 2, 7), -- Segunda - Fisioterapia
(397, '2025-12-01 17:00:00', 3, 2, 1), -- Segunda - Pilates
(398, '2025-12-02 09:00:00', 3, 2, 3), -- Terça - RPG
(399, '2025-12-02 11:00:00', 3, 2, 1), -- Terça - Pilates
(400, '2025-12-02 13:00:00', 3, 2, 7), -- Terça - Fisioterapia
(401, '2025-12-02 15:00:00', 3, 2, 1), -- Terça - Pilates
(402, '2025-12-03 09:00:00', 3, 2, 1), -- Quarta - Pilates
(403, '2025-12-03 11:00:00', 3, 2, 3), -- Quarta - RPG
(404, '2025-12-03 14:00:00', 3, 2, 7), -- Quarta - Fisioterapia
(405, '2025-12-03 16:00:00', 3, 2, 1), -- Quarta - Pilates
(406, '2025-12-04 09:00:00', 3, 2, 1), -- Quinta - Pilates
(407, '2025-12-04 11:00:00', 3, 2, 3), -- Quinta - RPG
(408, '2025-12-04 15:00:00', 3, 2, 1), -- Quinta - Pilates
(409, '2025-12-04 17:00:00', 3, 2, 7), -- Quinta - Fisioterapia
(410, '2025-12-05 09:00:00', 3, 2, 3), -- Sexta - RPG
(411, '2025-12-05 11:00:00', 3, 2, 1), -- Sexta - Pilates
(412, '2025-12-05 13:00:00', 3, 2, 7), -- Sexta - Fisioterapia
(413, '2025-12-05 15:00:00', 3, 2, 1), -- Sexta - Pilates
(414, '2025-12-08 09:00:00', 3, 2, 1), -- Segunda - Pilates
(415, '2025-12-08 11:00:00', 3, 2, 3), -- Segunda - RPG
(416, '2025-12-08 15:00:00', 3, 2, 7), -- Segunda - Fisioterapia
(417, '2025-12-08 17:00:00', 3, 2, 1), -- Segunda - Pilates
(418, '2025-12-09 09:00:00', 3, 2, 3), -- Terça - RPG
(419, '2025-12-09 11:00:00', 3, 2, 1), -- Terça - Pilates
(420, '2025-12-09 13:00:00', 3, 2, 7), -- Terça - Fisioterapia
(421, '2025-12-09 15:00:00', 3, 2, 1), -- Terça - Pilates
(422, '2025-12-10 09:00:00', 3, 2, 1), -- Quarta - Pilates
(423, '2025-12-10 11:00:00', 3, 2, 3), -- Quarta - RPG
(424, '2025-12-10 14:00:00', 3, 2, 7), -- Quarta - Fisioterapia
(425, '2025-12-10 16:00:00', 3, 2, 1), -- Quarta - Pilates
(426, '2025-12-11 09:00:00', 3, 2, 1), -- Quinta - Pilates
(427, '2025-12-11 11:00:00', 3, 2, 3), -- Quinta - RPG
(428, '2025-12-11 15:00:00', 3, 2, 1), -- Quinta - Pilates
(429, '2025-12-11 17:00:00', 3, 2, 7), -- Quinta - Fisioterapia
(430, '2025-12-12 09:00:00', 3, 2, 3), -- Sexta - RPG
(431, '2025-12-12 11:00:00', 3, 2, 1), -- Sexta - Pilates
(432, '2025-12-12 13:00:00', 3, 2, 7), -- Sexta - Fisioterapia
(433, '2025-12-12 15:00:00', 3, 2, 1), -- Sexta - Pilates
(434, '2025-12-15 09:00:00', 3, 2, 1), -- Segunda - Pilates
(435, '2025-12-15 11:00:00', 3, 2, 3), -- Segunda - RPG
(436, '2025-12-15 15:00:00', 3, 2, 7), -- Segunda - Fisioterapia
(437, '2025-12-15 17:00:00', 3, 2, 1), -- Segunda - Pilates
(438, '2025-12-16 09:00:00', 3, 2, 3), -- Terça - RPG
(439, '2025-12-16 11:00:00', 3, 2, 1), -- Terça - Pilates
(440, '2025-12-16 13:00:00', 3, 2, 7), -- Terça - Fisioterapia
(441, '2025-12-16 15:00:00', 3, 2, 1), -- Terça - Pilates
(442, '2025-12-17 09:00:00', 3, 2, 1), -- Quarta - Pilates
(443, '2025-12-17 11:00:00', 3, 2, 3), -- Quarta - RPG
(444, '2025-12-17 14:00:00', 3, 2, 7), -- Quarta - Fisioterapia
(445, '2025-12-17 16:00:00', 3, 2, 1), -- Quarta - Pilates
(446, '2025-12-18 09:00:00', 3, 2, 1), -- Quinta - Pilates
(447, '2025-12-18 11:00:00', 3, 2, 3), -- Quinta - RPG
(448, '2025-12-18 15:00:00', 3, 2, 1), -- Quinta - Pilates
(449, '2025-12-18 17:00:00', 3, 2, 7), -- Quinta - Fisioterapia
(450, '2025-12-19 09:00:00', 3, 2, 3), -- Sexta - RPG
(451, '2025-12-19 11:00:00', 3, 2, 1), -- Sexta - Pilates
(452, '2025-12-19 13:00:00', 3, 2, 7), -- Sexta - Fisioterapia
(453, '2025-12-19 15:00:00', 3, 2, 1), -- Sexta - Pilates
(454, '2025-12-22 09:00:00', 3, 2, 1), -- Segunda - Pilates
(455, '2025-12-22 11:00:00', 3, 2, 3), -- Segunda - RPG
(456, '2025-12-22 15:00:00', 3, 2, 7), -- Segunda - Fisioterapia
(457, '2025-12-22 17:00:00', 3, 2, 1); -- Segunda - Pilates

-- ============================================
-- 10C. AGENDAMENTOS ANDREI SCAFI - JAN-JUN 2026
-- ============================================
-- Andrei (ID 2): Sala Grande 1, Seg/Ter/Qui/Sex
-- Especialidades: Pilates(1), RPG(3), Fisioterapia(7)
-- Alunos: 11-20 (sem conflito com Guilherme que usa 1-10)

-- JANEIRO 2026
INSERT IGNORE INTO agendamento (id, data_hora, professor_id, sala_id, especialidade_id) VALUES
(458, '2026-01-02 09:00:00', 2, 1, 3),
(459, '2026-01-05 08:00:00', 2, 1, 1),
(460, '2026-01-05 10:00:00', 2, 1, 3),
(461, '2026-01-06 08:00:00', 2, 1, 1),
(462, '2026-01-08 14:00:00', 2, 1, 7),
(463, '2026-01-09 09:00:00', 2, 1, 3),
(464, '2026-01-12 08:00:00', 2, 1, 1),
(465, '2026-01-12 10:00:00', 2, 1, 3),
(466, '2026-01-13 08:00:00', 2, 1, 1),
(467, '2026-01-15 14:00:00', 2, 1, 7),
(468, '2026-01-16 09:00:00', 2, 1, 3),
(469, '2026-01-19 08:00:00', 2, 1, 1),
(470, '2026-01-19 10:00:00', 2, 1, 3),
(471, '2026-01-20 08:00:00', 2, 1, 1),
(472, '2026-01-22 14:00:00', 2, 1, 7),
(473, '2026-01-23 09:00:00', 2, 1, 3),
(474, '2026-01-26 08:00:00', 2, 1, 1),
(475, '2026-01-26 10:00:00', 2, 1, 3),
(476, '2026-01-27 08:00:00', 2, 1, 1),
(477, '2026-01-29 14:00:00', 2, 1, 7),
(478, '2026-01-30 09:00:00', 2, 1, 3);

-- FEVEREIRO 2026
INSERT IGNORE INTO agendamento (id, data_hora, professor_id, sala_id, especialidade_id) VALUES
(479, '2026-02-02 08:00:00', 2, 1, 1),
(480, '2026-02-02 10:00:00', 2, 1, 3),
(481, '2026-02-03 08:00:00', 2, 1, 1),
(482, '2026-02-05 14:00:00', 2, 1, 7),
(483, '2026-02-06 09:00:00', 2, 1, 3),
(484, '2026-02-09 08:00:00', 2, 1, 1),
(485, '2026-02-09 10:00:00', 2, 1, 3),
(486, '2026-02-10 08:00:00', 2, 1, 1),
(487, '2026-02-12 14:00:00', 2, 1, 7),
(488, '2026-02-13 09:00:00', 2, 1, 3),
(489, '2026-02-16 08:00:00', 2, 1, 1),
(490, '2026-02-16 10:00:00', 2, 1, 3),
(491, '2026-02-17 08:00:00', 2, 1, 1),
(492, '2026-02-19 14:00:00', 2, 1, 7),
(493, '2026-02-20 09:00:00', 2, 1, 3),
(494, '2026-02-23 08:00:00', 2, 1, 1),
(495, '2026-02-23 10:00:00', 2, 1, 3),
(496, '2026-02-24 08:00:00', 2, 1, 1),
(497, '2026-02-26 14:00:00', 2, 1, 7),
(498, '2026-02-27 09:00:00', 2, 1, 3);

-- MARCO 2026
INSERT IGNORE INTO agendamento (id, data_hora, professor_id, sala_id, especialidade_id) VALUES
(499, '2026-03-02 08:00:00', 2, 1, 1),
(500, '2026-03-02 10:00:00', 2, 1, 3),
(501, '2026-03-03 08:00:00', 2, 1, 1),
(502, '2026-03-05 14:00:00', 2, 1, 7),
(503, '2026-03-06 09:00:00', 2, 1, 3),
(504, '2026-03-09 08:00:00', 2, 1, 1),
(505, '2026-03-09 10:00:00', 2, 1, 3),
(506, '2026-03-10 08:00:00', 2, 1, 1),
(507, '2026-03-12 14:00:00', 2, 1, 7),
(508, '2026-03-13 09:00:00', 2, 1, 3),
(509, '2026-03-16 08:00:00', 2, 1, 1),
(510, '2026-03-16 10:00:00', 2, 1, 3),
(511, '2026-03-17 08:00:00', 2, 1, 1),
(512, '2026-03-19 14:00:00', 2, 1, 7),
(513, '2026-03-20 09:00:00', 2, 1, 3),
(514, '2026-03-23 08:00:00', 2, 1, 1),
(515, '2026-03-23 10:00:00', 2, 1, 3),
(516, '2026-03-24 08:00:00', 2, 1, 1),
(517, '2026-03-26 14:00:00', 2, 1, 7),
(518, '2026-03-27 09:00:00', 2, 1, 3),
(519, '2026-03-30 08:00:00', 2, 1, 1),
(520, '2026-03-30 10:00:00', 2, 1, 3),
(521, '2026-03-31 08:00:00', 2, 1, 1);

-- ABRIL 2026 (03/04 Sexta Santa; 21/04 Tiradentes)
INSERT IGNORE INTO agendamento (id, data_hora, professor_id, sala_id, especialidade_id) VALUES
(522, '2026-04-02 14:00:00', 2, 1, 7),
(523, '2026-04-06 08:00:00', 2, 1, 1),
(524, '2026-04-06 10:00:00', 2, 1, 3),
(525, '2026-04-07 08:00:00', 2, 1, 1),
(526, '2026-04-09 14:00:00', 2, 1, 7),
(527, '2026-04-10 09:00:00', 2, 1, 3),
(528, '2026-04-13 08:00:00', 2, 1, 1),
(529, '2026-04-13 10:00:00', 2, 1, 3),
(530, '2026-04-14 08:00:00', 2, 1, 1),
(531, '2026-04-16 14:00:00', 2, 1, 7),
(532, '2026-04-17 09:00:00', 2, 1, 3),
(533, '2026-04-20 08:00:00', 2, 1, 1),
(534, '2026-04-20 10:00:00', 2, 1, 3),
(535, '2026-04-23 14:00:00', 2, 1, 7),
(536, '2026-04-24 09:00:00', 2, 1, 3),
(537, '2026-04-27 08:00:00', 2, 1, 1),
(538, '2026-04-27 10:00:00', 2, 1, 3),
(539, '2026-04-28 08:00:00', 2, 1, 1),
(540, '2026-04-30 14:00:00', 2, 1, 7);

-- MAIO 2026 (01/05 Dia do Trabalho)
INSERT IGNORE INTO agendamento (id, data_hora, professor_id, sala_id, especialidade_id) VALUES
(541, '2026-05-04 08:00:00', 2, 1, 1),
(542, '2026-05-04 10:00:00', 2, 1, 3),
(543, '2026-05-05 08:00:00', 2, 1, 1),
(544, '2026-05-07 14:00:00', 2, 1, 7),
(545, '2026-05-08 09:00:00', 2, 1, 3),
(546, '2026-05-11 08:00:00', 2, 1, 1),
(547, '2026-05-11 10:00:00', 2, 1, 3),
(548, '2026-05-12 08:00:00', 2, 1, 1),
(549, '2026-05-14 14:00:00', 2, 1, 7),
(550, '2026-05-15 09:00:00', 2, 1, 3),
(551, '2026-05-18 08:00:00', 2, 1, 1),
(552, '2026-05-18 10:00:00', 2, 1, 3),
(553, '2026-05-19 08:00:00', 2, 1, 1),
(554, '2026-05-21 14:00:00', 2, 1, 7),
(555, '2026-05-22 09:00:00', 2, 1, 3),
(556, '2026-05-25 08:00:00', 2, 1, 1),
(557, '2026-05-25 10:00:00', 2, 1, 3),
(558, '2026-05-26 08:00:00', 2, 1, 1),
(559, '2026-05-28 14:00:00', 2, 1, 7),
(560, '2026-05-29 09:00:00', 2, 1, 3);

-- JUNHO 2026 (04/06 Corpus Christi)
INSERT IGNORE INTO agendamento (id, data_hora, professor_id, sala_id, especialidade_id) VALUES
(561, '2026-06-01 08:00:00', 2, 1, 1),
(562, '2026-06-01 10:00:00', 2, 1, 3),
(563, '2026-06-02 08:00:00', 2, 1, 1),
(564, '2026-06-05 09:00:00', 2, 1, 3),
(565, '2026-06-08 08:00:00', 2, 1, 1),
(566, '2026-06-08 10:00:00', 2, 1, 3),
(567, '2026-06-09 08:00:00', 2, 1, 1),
(568, '2026-06-11 14:00:00', 2, 1, 7),
(569, '2026-06-12 09:00:00', 2, 1, 3),
(570, '2026-06-15 08:00:00', 2, 1, 1),
(571, '2026-06-15 10:00:00', 2, 1, 3),
(572, '2026-06-16 08:00:00', 2, 1, 1),
(573, '2026-06-18 14:00:00', 2, 1, 7),
(574, '2026-06-19 09:00:00', 2, 1, 3),
(575, '2026-06-22 08:00:00', 2, 1, 1),
(576, '2026-06-22 10:00:00', 2, 1, 3),
(577, '2026-06-23 08:00:00', 2, 1, 1),
(578, '2026-06-25 14:00:00', 2, 1, 7),
(579, '2026-06-26 09:00:00', 2, 1, 3),
(580, '2026-06-29 08:00:00', 2, 1, 1),
(581, '2026-06-29 10:00:00', 2, 1, 3),
(582, '2026-06-30 08:00:00', 2, 1, 1);

-- ============================================
-- 10D. AGENDAMENTOS GUILHERME QUEIROZ - JAN-JUN 2026
-- ============================================
-- Guilherme (ID 3): Sala Grande 2, Seg-Sex 4 aulas/dia
-- Padrao: Seg/Qua 09:00P 11:00RPG 14:00F 16:00P
--         Ter/Qui 09:00RPG 11:00P 15:00P 17:00F
--         Sex     09:00P  11:00RPG 13:00F 15:00P
-- Alunos: 1-10 (sem conflito com Andrei que usa 11-20)

-- JANEIRO 2026
INSERT IGNORE INTO agendamento (id, data_hora, professor_id, sala_id, especialidade_id) VALUES
(583, '2026-01-02 09:00:00', 3, 2, 1),(584, '2026-01-02 11:00:00', 3, 2, 3),(585, '2026-01-02 13:00:00', 3, 2, 7),(586, '2026-01-02 15:00:00', 3, 2, 1),
(587, '2026-01-05 09:00:00', 3, 2, 1),(588, '2026-01-05 11:00:00', 3, 2, 3),(589, '2026-01-05 14:00:00', 3, 2, 7),(590, '2026-01-05 16:00:00', 3, 2, 1),
(591, '2026-01-06 09:00:00', 3, 2, 3),(592, '2026-01-06 11:00:00', 3, 2, 1),(593, '2026-01-06 15:00:00', 3, 2, 1),(594, '2026-01-06 17:00:00', 3, 2, 7),
(595, '2026-01-07 09:00:00', 3, 2, 1),(596, '2026-01-07 11:00:00', 3, 2, 3),(597, '2026-01-07 14:00:00', 3, 2, 7),(598, '2026-01-07 16:00:00', 3, 2, 1),
(599, '2026-01-08 09:00:00', 3, 2, 3),(600, '2026-01-08 11:00:00', 3, 2, 1),(601, '2026-01-08 15:00:00', 3, 2, 1),(602, '2026-01-08 17:00:00', 3, 2, 7),
(603, '2026-01-09 09:00:00', 3, 2, 1),(604, '2026-01-09 11:00:00', 3, 2, 3),(605, '2026-01-09 13:00:00', 3, 2, 7),(606, '2026-01-09 15:00:00', 3, 2, 1),
(607, '2026-01-12 09:00:00', 3, 2, 1),(608, '2026-01-12 11:00:00', 3, 2, 3),(609, '2026-01-12 14:00:00', 3, 2, 7),(610, '2026-01-12 16:00:00', 3, 2, 1),
(611, '2026-01-13 09:00:00', 3, 2, 3),(612, '2026-01-13 11:00:00', 3, 2, 1),(613, '2026-01-13 15:00:00', 3, 2, 1),(614, '2026-01-13 17:00:00', 3, 2, 7),
(615, '2026-01-14 09:00:00', 3, 2, 1),(616, '2026-01-14 11:00:00', 3, 2, 3),(617, '2026-01-14 14:00:00', 3, 2, 7),(618, '2026-01-14 16:00:00', 3, 2, 1),
(619, '2026-01-15 09:00:00', 3, 2, 3),(620, '2026-01-15 11:00:00', 3, 2, 1),(621, '2026-01-15 15:00:00', 3, 2, 1),(622, '2026-01-15 17:00:00', 3, 2, 7),
(623, '2026-01-16 09:00:00', 3, 2, 1),(624, '2026-01-16 11:00:00', 3, 2, 3),(625, '2026-01-16 13:00:00', 3, 2, 7),(626, '2026-01-16 15:00:00', 3, 2, 1),
(627, '2026-01-19 09:00:00', 3, 2, 1),(628, '2026-01-19 11:00:00', 3, 2, 3),(629, '2026-01-19 14:00:00', 3, 2, 7),(630, '2026-01-19 16:00:00', 3, 2, 1),
(631, '2026-01-20 09:00:00', 3, 2, 3),(632, '2026-01-20 11:00:00', 3, 2, 1),(633, '2026-01-20 15:00:00', 3, 2, 1),(634, '2026-01-20 17:00:00', 3, 2, 7),
(635, '2026-01-21 09:00:00', 3, 2, 1),(636, '2026-01-21 11:00:00', 3, 2, 3),(637, '2026-01-21 14:00:00', 3, 2, 7),(638, '2026-01-21 16:00:00', 3, 2, 1),
(639, '2026-01-22 09:00:00', 3, 2, 3),(640, '2026-01-22 11:00:00', 3, 2, 1),(641, '2026-01-22 15:00:00', 3, 2, 1),(642, '2026-01-22 17:00:00', 3, 2, 7),
(643, '2026-01-23 09:00:00', 3, 2, 1),(644, '2026-01-23 11:00:00', 3, 2, 3),(645, '2026-01-23 13:00:00', 3, 2, 7),(646, '2026-01-23 15:00:00', 3, 2, 1),
(647, '2026-01-26 09:00:00', 3, 2, 1),(648, '2026-01-26 11:00:00', 3, 2, 3),(649, '2026-01-26 14:00:00', 3, 2, 7),(650, '2026-01-26 16:00:00', 3, 2, 1),
(651, '2026-01-27 09:00:00', 3, 2, 3),(652, '2026-01-27 11:00:00', 3, 2, 1),(653, '2026-01-27 15:00:00', 3, 2, 1),(654, '2026-01-27 17:00:00', 3, 2, 7),
(655, '2026-01-28 09:00:00', 3, 2, 1),(656, '2026-01-28 11:00:00', 3, 2, 3),(657, '2026-01-28 14:00:00', 3, 2, 7),(658, '2026-01-28 16:00:00', 3, 2, 1),
(659, '2026-01-29 09:00:00', 3, 2, 3),(660, '2026-01-29 11:00:00', 3, 2, 1),(661, '2026-01-29 15:00:00', 3, 2, 1),(662, '2026-01-29 17:00:00', 3, 2, 7),
(663, '2026-01-30 09:00:00', 3, 2, 1),(664, '2026-01-30 11:00:00', 3, 2, 3),(665, '2026-01-30 13:00:00', 3, 2, 7),(666, '2026-01-30 15:00:00', 3, 2, 1);

-- FEVEREIRO 2026
INSERT IGNORE INTO agendamento (id, data_hora, professor_id, sala_id, especialidade_id) VALUES
(667, '2026-02-02 09:00:00', 3, 2, 1),(668, '2026-02-02 11:00:00', 3, 2, 3),(669, '2026-02-02 14:00:00', 3, 2, 7),(670, '2026-02-02 16:00:00', 3, 2, 1),
(671, '2026-02-03 09:00:00', 3, 2, 3),(672, '2026-02-03 11:00:00', 3, 2, 1),(673, '2026-02-03 15:00:00', 3, 2, 1),(674, '2026-02-03 17:00:00', 3, 2, 7),
(675, '2026-02-04 09:00:00', 3, 2, 1),(676, '2026-02-04 11:00:00', 3, 2, 3),(677, '2026-02-04 14:00:00', 3, 2, 7),(678, '2026-02-04 16:00:00', 3, 2, 1),
(679, '2026-02-05 09:00:00', 3, 2, 3),(680, '2026-02-05 11:00:00', 3, 2, 1),(681, '2026-02-05 15:00:00', 3, 2, 1),(682, '2026-02-05 17:00:00', 3, 2, 7),
(683, '2026-02-06 09:00:00', 3, 2, 1),(684, '2026-02-06 11:00:00', 3, 2, 3),(685, '2026-02-06 13:00:00', 3, 2, 7),(686, '2026-02-06 15:00:00', 3, 2, 1),
(687, '2026-02-09 09:00:00', 3, 2, 1),(688, '2026-02-09 11:00:00', 3, 2, 3),(689, '2026-02-09 14:00:00', 3, 2, 7),(690, '2026-02-09 16:00:00', 3, 2, 1),
(691, '2026-02-10 09:00:00', 3, 2, 3),(692, '2026-02-10 11:00:00', 3, 2, 1),(693, '2026-02-10 15:00:00', 3, 2, 1),(694, '2026-02-10 17:00:00', 3, 2, 7),
(695, '2026-02-11 09:00:00', 3, 2, 1),(696, '2026-02-11 11:00:00', 3, 2, 3),(697, '2026-02-11 14:00:00', 3, 2, 7),(698, '2026-02-11 16:00:00', 3, 2, 1),
(699, '2026-02-12 09:00:00', 3, 2, 3),(700, '2026-02-12 11:00:00', 3, 2, 1),(701, '2026-02-12 15:00:00', 3, 2, 1),(702, '2026-02-12 17:00:00', 3, 2, 7),
(703, '2026-02-13 09:00:00', 3, 2, 1),(704, '2026-02-13 11:00:00', 3, 2, 3),(705, '2026-02-13 13:00:00', 3, 2, 7),(706, '2026-02-13 15:00:00', 3, 2, 1),
(707, '2026-02-16 09:00:00', 3, 2, 1),(708, '2026-02-16 11:00:00', 3, 2, 3),(709, '2026-02-16 14:00:00', 3, 2, 7),(710, '2026-02-16 16:00:00', 3, 2, 1),
(711, '2026-02-17 09:00:00', 3, 2, 3),(712, '2026-02-17 11:00:00', 3, 2, 1),(713, '2026-02-17 15:00:00', 3, 2, 1),(714, '2026-02-17 17:00:00', 3, 2, 7),
(715, '2026-02-18 09:00:00', 3, 2, 1),(716, '2026-02-18 11:00:00', 3, 2, 3),(717, '2026-02-18 14:00:00', 3, 2, 7),(718, '2026-02-18 16:00:00', 3, 2, 1),
(719, '2026-02-19 09:00:00', 3, 2, 3),(720, '2026-02-19 11:00:00', 3, 2, 1),(721, '2026-02-19 15:00:00', 3, 2, 1),(722, '2026-02-19 17:00:00', 3, 2, 7),
(723, '2026-02-20 09:00:00', 3, 2, 1),(724, '2026-02-20 11:00:00', 3, 2, 3),(725, '2026-02-20 13:00:00', 3, 2, 7),(726, '2026-02-20 15:00:00', 3, 2, 1),
(727, '2026-02-23 09:00:00', 3, 2, 1),(728, '2026-02-23 11:00:00', 3, 2, 3),(729, '2026-02-23 14:00:00', 3, 2, 7),(730, '2026-02-23 16:00:00', 3, 2, 1),
(731, '2026-02-24 09:00:00', 3, 2, 3),(732, '2026-02-24 11:00:00', 3, 2, 1),(733, '2026-02-24 15:00:00', 3, 2, 1),(734, '2026-02-24 17:00:00', 3, 2, 7),
(735, '2026-02-25 09:00:00', 3, 2, 1),(736, '2026-02-25 11:00:00', 3, 2, 3),(737, '2026-02-25 14:00:00', 3, 2, 7),(738, '2026-02-25 16:00:00', 3, 2, 1),
(739, '2026-02-26 09:00:00', 3, 2, 3),(740, '2026-02-26 11:00:00', 3, 2, 1),(741, '2026-02-26 15:00:00', 3, 2, 1),(742, '2026-02-26 17:00:00', 3, 2, 7),
(743, '2026-02-27 09:00:00', 3, 2, 1),(744, '2026-02-27 11:00:00', 3, 2, 3),(745, '2026-02-27 13:00:00', 3, 2, 7),(746, '2026-02-27 15:00:00', 3, 2, 1);

-- MARCO 2026
INSERT IGNORE INTO agendamento (id, data_hora, professor_id, sala_id, especialidade_id) VALUES
(747, '2026-03-02 09:00:00', 3, 2, 1),(748, '2026-03-02 11:00:00', 3, 2, 3),(749, '2026-03-02 14:00:00', 3, 2, 7),(750, '2026-03-02 16:00:00', 3, 2, 1),
(751, '2026-03-03 09:00:00', 3, 2, 3),(752, '2026-03-03 11:00:00', 3, 2, 1),(753, '2026-03-03 15:00:00', 3, 2, 1),(754, '2026-03-03 17:00:00', 3, 2, 7),
(755, '2026-03-04 09:00:00', 3, 2, 1),(756, '2026-03-04 11:00:00', 3, 2, 3),(757, '2026-03-04 14:00:00', 3, 2, 7),(758, '2026-03-04 16:00:00', 3, 2, 1),
(759, '2026-03-05 09:00:00', 3, 2, 3),(760, '2026-03-05 11:00:00', 3, 2, 1),(761, '2026-03-05 15:00:00', 3, 2, 1),(762, '2026-03-05 17:00:00', 3, 2, 7),
(763, '2026-03-06 09:00:00', 3, 2, 1),(764, '2026-03-06 11:00:00', 3, 2, 3),(765, '2026-03-06 13:00:00', 3, 2, 7),(766, '2026-03-06 15:00:00', 3, 2, 1),
(767, '2026-03-09 09:00:00', 3, 2, 1),(768, '2026-03-09 11:00:00', 3, 2, 3),(769, '2026-03-09 14:00:00', 3, 2, 7),(770, '2026-03-09 16:00:00', 3, 2, 1),
(771, '2026-03-10 09:00:00', 3, 2, 3),(772, '2026-03-10 11:00:00', 3, 2, 1),(773, '2026-03-10 15:00:00', 3, 2, 1),(774, '2026-03-10 17:00:00', 3, 2, 7),
(775, '2026-03-11 09:00:00', 3, 2, 1),(776, '2026-03-11 11:00:00', 3, 2, 3),(777, '2026-03-11 14:00:00', 3, 2, 7),(778, '2026-03-11 16:00:00', 3, 2, 1),
(779, '2026-03-12 09:00:00', 3, 2, 3),(780, '2026-03-12 11:00:00', 3, 2, 1),(781, '2026-03-12 15:00:00', 3, 2, 1),(782, '2026-03-12 17:00:00', 3, 2, 7),
(783, '2026-03-13 09:00:00', 3, 2, 1),(784, '2026-03-13 11:00:00', 3, 2, 3),(785, '2026-03-13 13:00:00', 3, 2, 7),(786, '2026-03-13 15:00:00', 3, 2, 1),
(787, '2026-03-16 09:00:00', 3, 2, 1),(788, '2026-03-16 11:00:00', 3, 2, 3),(789, '2026-03-16 14:00:00', 3, 2, 7),(790, '2026-03-16 16:00:00', 3, 2, 1),
(791, '2026-03-17 09:00:00', 3, 2, 3),(792, '2026-03-17 11:00:00', 3, 2, 1),(793, '2026-03-17 15:00:00', 3, 2, 1),(794, '2026-03-17 17:00:00', 3, 2, 7),
(795, '2026-03-18 09:00:00', 3, 2, 1),(796, '2026-03-18 11:00:00', 3, 2, 3),(797, '2026-03-18 14:00:00', 3, 2, 7),(798, '2026-03-18 16:00:00', 3, 2, 1),
(799, '2026-03-19 09:00:00', 3, 2, 3),(800, '2026-03-19 11:00:00', 3, 2, 1),(801, '2026-03-19 15:00:00', 3, 2, 1),(802, '2026-03-19 17:00:00', 3, 2, 7),
(803, '2026-03-20 09:00:00', 3, 2, 1),(804, '2026-03-20 11:00:00', 3, 2, 3),(805, '2026-03-20 13:00:00', 3, 2, 7),(806, '2026-03-20 15:00:00', 3, 2, 1),
(807, '2026-03-23 09:00:00', 3, 2, 1),(808, '2026-03-23 11:00:00', 3, 2, 3),(809, '2026-03-23 14:00:00', 3, 2, 7),(810, '2026-03-23 16:00:00', 3, 2, 1),
(811, '2026-03-24 09:00:00', 3, 2, 3),(812, '2026-03-24 11:00:00', 3, 2, 1),(813, '2026-03-24 15:00:00', 3, 2, 1),(814, '2026-03-24 17:00:00', 3, 2, 7),
(815, '2026-03-25 09:00:00', 3, 2, 1),(816, '2026-03-25 11:00:00', 3, 2, 3),(817, '2026-03-25 14:00:00', 3, 2, 7),(818, '2026-03-25 16:00:00', 3, 2, 1),
(819, '2026-03-26 09:00:00', 3, 2, 3),(820, '2026-03-26 11:00:00', 3, 2, 1),(821, '2026-03-26 15:00:00', 3, 2, 1),(822, '2026-03-26 17:00:00', 3, 2, 7),
(823, '2026-03-27 09:00:00', 3, 2, 1),(824, '2026-03-27 11:00:00', 3, 2, 3),(825, '2026-03-27 13:00:00', 3, 2, 7),(826, '2026-03-27 15:00:00', 3, 2, 1),
(827, '2026-03-30 09:00:00', 3, 2, 1),(828, '2026-03-30 11:00:00', 3, 2, 3),(829, '2026-03-30 14:00:00', 3, 2, 7),(830, '2026-03-30 16:00:00', 3, 2, 1),
(831, '2026-03-31 09:00:00', 3, 2, 3),(832, '2026-03-31 11:00:00', 3, 2, 1),(833, '2026-03-31 15:00:00', 3, 2, 1),(834, '2026-03-31 17:00:00', 3, 2, 7);

-- ABRIL 2026 (03/04 Sexta Santa; 21/04 Tiradentes)
INSERT IGNORE INTO agendamento (id, data_hora, professor_id, sala_id, especialidade_id) VALUES
(835, '2026-04-01 09:00:00', 3, 2, 1),(836, '2026-04-01 11:00:00', 3, 2, 3),(837, '2026-04-01 14:00:00', 3, 2, 7),(838, '2026-04-01 16:00:00', 3, 2, 1),
(839, '2026-04-02 09:00:00', 3, 2, 3),(840, '2026-04-02 11:00:00', 3, 2, 1),(841, '2026-04-02 15:00:00', 3, 2, 1),(842, '2026-04-02 17:00:00', 3, 2, 7),
(843, '2026-04-06 09:00:00', 3, 2, 1),(844, '2026-04-06 11:00:00', 3, 2, 3),(845, '2026-04-06 14:00:00', 3, 2, 7),(846, '2026-04-06 16:00:00', 3, 2, 1),
(847, '2026-04-07 09:00:00', 3, 2, 3),(848, '2026-04-07 11:00:00', 3, 2, 1),(849, '2026-04-07 15:00:00', 3, 2, 1),(850, '2026-04-07 17:00:00', 3, 2, 7),
(851, '2026-04-08 09:00:00', 3, 2, 1),(852, '2026-04-08 11:00:00', 3, 2, 3),(853, '2026-04-08 14:00:00', 3, 2, 7),(854, '2026-04-08 16:00:00', 3, 2, 1),
(855, '2026-04-09 09:00:00', 3, 2, 3),(856, '2026-04-09 11:00:00', 3, 2, 1),(857, '2026-04-09 15:00:00', 3, 2, 1),(858, '2026-04-09 17:00:00', 3, 2, 7),
(859, '2026-04-10 09:00:00', 3, 2, 1),(860, '2026-04-10 11:00:00', 3, 2, 3),(861, '2026-04-10 13:00:00', 3, 2, 7),(862, '2026-04-10 15:00:00', 3, 2, 1),
(863, '2026-04-13 09:00:00', 3, 2, 1),(864, '2026-04-13 11:00:00', 3, 2, 3),(865, '2026-04-13 14:00:00', 3, 2, 7),(866, '2026-04-13 16:00:00', 3, 2, 1),
(867, '2026-04-14 09:00:00', 3, 2, 3),(868, '2026-04-14 11:00:00', 3, 2, 1),(869, '2026-04-14 15:00:00', 3, 2, 1),(870, '2026-04-14 17:00:00', 3, 2, 7),
(871, '2026-04-15 09:00:00', 3, 2, 1),(872, '2026-04-15 11:00:00', 3, 2, 3),(873, '2026-04-15 14:00:00', 3, 2, 7),(874, '2026-04-15 16:00:00', 3, 2, 1),
(875, '2026-04-16 09:00:00', 3, 2, 3),(876, '2026-04-16 11:00:00', 3, 2, 1),(877, '2026-04-16 15:00:00', 3, 2, 1),(878, '2026-04-16 17:00:00', 3, 2, 7),
(879, '2026-04-17 09:00:00', 3, 2, 1),(880, '2026-04-17 11:00:00', 3, 2, 3),(881, '2026-04-17 13:00:00', 3, 2, 7),(882, '2026-04-17 15:00:00', 3, 2, 1),
(883, '2026-04-20 09:00:00', 3, 2, 1),(884, '2026-04-20 11:00:00', 3, 2, 3),(885, '2026-04-20 14:00:00', 3, 2, 7),(886, '2026-04-20 16:00:00', 3, 2, 1),
(887, '2026-04-22 09:00:00', 3, 2, 1),(888, '2026-04-22 11:00:00', 3, 2, 3),(889, '2026-04-22 14:00:00', 3, 2, 7),(890, '2026-04-22 16:00:00', 3, 2, 1),
(891, '2026-04-23 09:00:00', 3, 2, 3),(892, '2026-04-23 11:00:00', 3, 2, 1),(893, '2026-04-23 15:00:00', 3, 2, 1),(894, '2026-04-23 17:00:00', 3, 2, 7),
(895, '2026-04-24 09:00:00', 3, 2, 1),(896, '2026-04-24 11:00:00', 3, 2, 3),(897, '2026-04-24 13:00:00', 3, 2, 7),(898, '2026-04-24 15:00:00', 3, 2, 1),
(899, '2026-04-27 09:00:00', 3, 2, 1),(900, '2026-04-27 11:00:00', 3, 2, 3),(901, '2026-04-27 14:00:00', 3, 2, 7),(902, '2026-04-27 16:00:00', 3, 2, 1),
(903, '2026-04-28 09:00:00', 3, 2, 3),(904, '2026-04-28 11:00:00', 3, 2, 1),(905, '2026-04-28 15:00:00', 3, 2, 1),(906, '2026-04-28 17:00:00', 3, 2, 7),
(907, '2026-04-29 09:00:00', 3, 2, 1),(908, '2026-04-29 11:00:00', 3, 2, 3),(909, '2026-04-29 14:00:00', 3, 2, 7),(910, '2026-04-29 16:00:00', 3, 2, 1),
(911, '2026-04-30 09:00:00', 3, 2, 3),(912, '2026-04-30 11:00:00', 3, 2, 1),(913, '2026-04-30 15:00:00', 3, 2, 1),(914, '2026-04-30 17:00:00', 3, 2, 7);

-- MAIO 2026 (01/05 Dia do Trabalho)
INSERT IGNORE INTO agendamento (id, data_hora, professor_id, sala_id, especialidade_id) VALUES
(915, '2026-05-04 09:00:00', 3, 2, 1),(916, '2026-05-04 11:00:00', 3, 2, 3),(917, '2026-05-04 14:00:00', 3, 2, 7),(918, '2026-05-04 16:00:00', 3, 2, 1),
(919, '2026-05-05 09:00:00', 3, 2, 3),(920, '2026-05-05 11:00:00', 3, 2, 1),(921, '2026-05-05 15:00:00', 3, 2, 1),(922, '2026-05-05 17:00:00', 3, 2, 7),
(923, '2026-05-06 09:00:00', 3, 2, 1),(924, '2026-05-06 11:00:00', 3, 2, 3),(925, '2026-05-06 14:00:00', 3, 2, 7),(926, '2026-05-06 16:00:00', 3, 2, 1),
(927, '2026-05-07 09:00:00', 3, 2, 3),(928, '2026-05-07 11:00:00', 3, 2, 1),(929, '2026-05-07 15:00:00', 3, 2, 1),(930, '2026-05-07 17:00:00', 3, 2, 7),
(931, '2026-05-08 09:00:00', 3, 2, 1),(932, '2026-05-08 11:00:00', 3, 2, 3),(933, '2026-05-08 13:00:00', 3, 2, 7),(934, '2026-05-08 15:00:00', 3, 2, 1),
(935, '2026-05-11 09:00:00', 3, 2, 1),(936, '2026-05-11 11:00:00', 3, 2, 3),(937, '2026-05-11 14:00:00', 3, 2, 7),(938, '2026-05-11 16:00:00', 3, 2, 1),
(939, '2026-05-12 09:00:00', 3, 2, 3),(940, '2026-05-12 11:00:00', 3, 2, 1),(941, '2026-05-12 15:00:00', 3, 2, 1),(942, '2026-05-12 17:00:00', 3, 2, 7),
(943, '2026-05-13 09:00:00', 3, 2, 1),(944, '2026-05-13 11:00:00', 3, 2, 3),(945, '2026-05-13 14:00:00', 3, 2, 7),(946, '2026-05-13 16:00:00', 3, 2, 1),
(947, '2026-05-14 09:00:00', 3, 2, 3),(948, '2026-05-14 11:00:00', 3, 2, 1),(949, '2026-05-14 15:00:00', 3, 2, 1),(950, '2026-05-14 17:00:00', 3, 2, 7),
(951, '2026-05-15 09:00:00', 3, 2, 1),(952, '2026-05-15 11:00:00', 3, 2, 3),(953, '2026-05-15 13:00:00', 3, 2, 7),(954, '2026-05-15 15:00:00', 3, 2, 1),
(955, '2026-05-18 09:00:00', 3, 2, 1),(956, '2026-05-18 11:00:00', 3, 2, 3),(957, '2026-05-18 14:00:00', 3, 2, 7),(958, '2026-05-18 16:00:00', 3, 2, 1),
(959, '2026-05-19 09:00:00', 3, 2, 3),(960, '2026-05-19 11:00:00', 3, 2, 1),(961, '2026-05-19 15:00:00', 3, 2, 1),(962, '2026-05-19 17:00:00', 3, 2, 7),
(963, '2026-05-20 09:00:00', 3, 2, 1),(964, '2026-05-20 11:00:00', 3, 2, 3),(965, '2026-05-20 14:00:00', 3, 2, 7),(966, '2026-05-20 16:00:00', 3, 2, 1),
(967, '2026-05-21 09:00:00', 3, 2, 3),(968, '2026-05-21 11:00:00', 3, 2, 1),(969, '2026-05-21 15:00:00', 3, 2, 1),(970, '2026-05-21 17:00:00', 3, 2, 7),
(971, '2026-05-22 09:00:00', 3, 2, 1),(972, '2026-05-22 11:00:00', 3, 2, 3),(973, '2026-05-22 13:00:00', 3, 2, 7),(974, '2026-05-22 15:00:00', 3, 2, 1),
(975, '2026-05-25 09:00:00', 3, 2, 1),(976, '2026-05-25 11:00:00', 3, 2, 3),(977, '2026-05-25 14:00:00', 3, 2, 7),(978, '2026-05-25 16:00:00', 3, 2, 1),
(979, '2026-05-26 09:00:00', 3, 2, 3),(980, '2026-05-26 11:00:00', 3, 2, 1),(981, '2026-05-26 15:00:00', 3, 2, 1),(982, '2026-05-26 17:00:00', 3, 2, 7),
(983, '2026-05-27 09:00:00', 3, 2, 1),(984, '2026-05-27 11:00:00', 3, 2, 3),(985, '2026-05-27 14:00:00', 3, 2, 7),(986, '2026-05-27 16:00:00', 3, 2, 1),
(987, '2026-05-28 09:00:00', 3, 2, 3),(988, '2026-05-28 11:00:00', 3, 2, 1),(989, '2026-05-28 15:00:00', 3, 2, 1),(990, '2026-05-28 17:00:00', 3, 2, 7),
(991, '2026-05-29 09:00:00', 3, 2, 1),(992, '2026-05-29 11:00:00', 3, 2, 3),(993, '2026-05-29 13:00:00', 3, 2, 7),(994, '2026-05-29 15:00:00', 3, 2, 1);

-- JUNHO 2026 (04/06 Corpus Christi)
INSERT IGNORE INTO agendamento (id, data_hora, professor_id, sala_id, especialidade_id) VALUES
(995,  '2026-06-01 09:00:00', 3, 2, 1),(996,  '2026-06-01 11:00:00', 3, 2, 3),(997,  '2026-06-01 14:00:00', 3, 2, 7),(998,  '2026-06-01 16:00:00', 3, 2, 1),
(999,  '2026-06-02 09:00:00', 3, 2, 3),(1000, '2026-06-02 11:00:00', 3, 2, 1),(1001, '2026-06-02 15:00:00', 3, 2, 1),(1002, '2026-06-02 17:00:00', 3, 2, 7),
(1003, '2026-06-03 09:00:00', 3, 2, 1),(1004, '2026-06-03 11:00:00', 3, 2, 3),(1005, '2026-06-03 14:00:00', 3, 2, 7),(1006, '2026-06-03 16:00:00', 3, 2, 1),
(1007, '2026-06-05 09:00:00', 3, 2, 1),(1008, '2026-06-05 11:00:00', 3, 2, 3),(1009, '2026-06-05 13:00:00', 3, 2, 7),(1010, '2026-06-05 15:00:00', 3, 2, 1),
(1011, '2026-06-08 09:00:00', 3, 2, 1),(1012, '2026-06-08 11:00:00', 3, 2, 3),(1013, '2026-06-08 14:00:00', 3, 2, 7),(1014, '2026-06-08 16:00:00', 3, 2, 1),
(1015, '2026-06-09 09:00:00', 3, 2, 3),(1016, '2026-06-09 11:00:00', 3, 2, 1),(1017, '2026-06-09 15:00:00', 3, 2, 1),(1018, '2026-06-09 17:00:00', 3, 2, 7),
(1019, '2026-06-10 09:00:00', 3, 2, 1),(1020, '2026-06-10 11:00:00', 3, 2, 3),(1021, '2026-06-10 14:00:00', 3, 2, 7),(1022, '2026-06-10 16:00:00', 3, 2, 1),
(1023, '2026-06-11 09:00:00', 3, 2, 3),(1024, '2026-06-11 11:00:00', 3, 2, 1),(1025, '2026-06-11 15:00:00', 3, 2, 1),(1026, '2026-06-11 17:00:00', 3, 2, 7),
(1027, '2026-06-12 09:00:00', 3, 2, 1),(1028, '2026-06-12 11:00:00', 3, 2, 3),(1029, '2026-06-12 13:00:00', 3, 2, 7),(1030, '2026-06-12 15:00:00', 3, 2, 1),
(1031, '2026-06-15 09:00:00', 3, 2, 1),(1032, '2026-06-15 11:00:00', 3, 2, 3),(1033, '2026-06-15 14:00:00', 3, 2, 7),(1034, '2026-06-15 16:00:00', 3, 2, 1),
(1035, '2026-06-16 09:00:00', 3, 2, 3),(1036, '2026-06-16 11:00:00', 3, 2, 1),(1037, '2026-06-16 15:00:00', 3, 2, 1),(1038, '2026-06-16 17:00:00', 3, 2, 7),
(1039, '2026-06-17 09:00:00', 3, 2, 1),(1040, '2026-06-17 11:00:00', 3, 2, 3),(1041, '2026-06-17 14:00:00', 3, 2, 7),(1042, '2026-06-17 16:00:00', 3, 2, 1),
(1043, '2026-06-18 09:00:00', 3, 2, 3),(1044, '2026-06-18 11:00:00', 3, 2, 1),(1045, '2026-06-18 15:00:00', 3, 2, 1),(1046, '2026-06-18 17:00:00', 3, 2, 7),
(1047, '2026-06-19 09:00:00', 3, 2, 1),(1048, '2026-06-19 11:00:00', 3, 2, 3),(1049, '2026-06-19 13:00:00', 3, 2, 7),(1050, '2026-06-19 15:00:00', 3, 2, 1),
(1051, '2026-06-22 09:00:00', 3, 2, 1),(1052, '2026-06-22 11:00:00', 3, 2, 3),(1053, '2026-06-22 14:00:00', 3, 2, 7),(1054, '2026-06-22 16:00:00', 3, 2, 1),
(1055, '2026-06-23 09:00:00', 3, 2, 3),(1056, '2026-06-23 11:00:00', 3, 2, 1),(1057, '2026-06-23 15:00:00', 3, 2, 1),(1058, '2026-06-23 17:00:00', 3, 2, 7),
(1059, '2026-06-24 09:00:00', 3, 2, 1),(1060, '2026-06-24 11:00:00', 3, 2, 3),(1061, '2026-06-24 14:00:00', 3, 2, 7),(1062, '2026-06-24 16:00:00', 3, 2, 1),
(1063, '2026-06-25 09:00:00', 3, 2, 3),(1064, '2026-06-25 11:00:00', 3, 2, 1),(1065, '2026-06-25 15:00:00', 3, 2, 1),(1066, '2026-06-25 17:00:00', 3, 2, 7),
(1067, '2026-06-26 09:00:00', 3, 2, 1),(1068, '2026-06-26 11:00:00', 3, 2, 3),(1069, '2026-06-26 13:00:00', 3, 2, 7),(1070, '2026-06-26 15:00:00', 3, 2, 1),
(1071, '2026-06-29 09:00:00', 3, 2, 1),(1072, '2026-06-29 11:00:00', 3, 2, 3),(1073, '2026-06-29 14:00:00', 3, 2, 7),(1074, '2026-06-29 16:00:00', 3, 2, 1),
(1075, '2026-06-30 09:00:00', 3, 2, 3),(1076, '2026-06-30 11:00:00', 3, 2, 1),(1077, '2026-06-30 15:00:00', 3, 2, 1),(1078, '2026-06-30 17:00:00', 3, 2, 7);

-- ============================================
-- 11. INSERIR RELACIONAMENTOS AGENDAMENTO-ALUNO
-- ============================================
-- NOTA: StatusPresenca é um ENUM com valores: PENDENTE, PRESENTE, FALTA
-- Agendamentos passados (até 14/11/2025): PRESENTE ou FALTA
-- Agendamentos futuros (após 14/11/2025): PENDENTE
-- IMPORTANTE: Distribuir alunos evitando conflitos de horário entre professores

-- ============================================
-- AGENDAMENTOS DO PROFESSOR ANDREI (IDs 1-97)
-- ============================================
-- Estratégia: Andrei usa principalmente alunos 11-20 para evitar conflitos com Guilherme
-- Agendamentos de agosto do Andrei (IDs 1-21) - PASSADOS
INSERT IGNORE INTO agendamento_aluno (agendamento_id, aluno_id, status_presenca) VALUES
-- Agendamento 1 (04/08 08:00 - Segunda - Pilates)
(1, 11, 'PRESENTE'), (1, 12, 'PRESENTE'), (1, 13, 'PRESENTE'), (1, 14, 'FALTA'),
-- Agendamento 2 (04/08 10:00 - Segunda - RPG)
(2, 12, 'PRESENTE'), (2, 13, 'PRESENTE'), (2, 14, 'PRESENTE'), (2, 15, 'FALTA'),
-- Agendamento 3 (05/08 08:00 - Terça - Pilates)
(3, 13, 'PRESENTE'), (3, 14, 'PRESENTE'), (3, 15, 'PRESENTE'), (3, 16, 'FALTA'),
-- Agendamento 4 (05/08 10:00 - Terça - RPG)
(4, 14, 'PRESENTE'), (4, 15, 'PRESENTE'), (4, 16, 'PRESENTE'), (4, 17, 'FALTA'),
-- Agendamento 5 (07/08 08:00 - Quinta - Pilates)
(5, 15, 'PRESENTE'), (5, 16, 'PRESENTE'), (5, 17, 'PRESENTE'), (5, 18, 'FALTA'),
-- Agendamento 6 (07/08 14:00 - Quinta - Fisioterapia)
(6, 16, 'PRESENTE'), (6, 17, 'PRESENTE'), (6, 18, 'PRESENTE'), (6, 19, 'FALTA'),
-- Agendamento 7 (08/08 09:00 - Sexta - RPG)
(7, 17, 'PRESENTE'), (7, 18, 'PRESENTE'), (7, 19, 'PRESENTE'), (7, 20, 'FALTA'),
-- Agendamento 8 (11/08 08:00 - Segunda - Pilates)
(8, 18, 'PRESENTE'), (8, 19, 'PRESENTE'), (8, 20, 'PRESENTE'), (8, 11, 'FALTA'),
-- Agendamento 9 (11/08 14:00 - Segunda - Fisioterapia)
(9, 19, 'PRESENTE'), (9, 20, 'PRESENTE'), (9, 11, 'PRESENTE'), (9, 12, 'FALTA'),
-- Agendamento 10 (12/08 08:00 - Terça - Pilates)
(10, 20, 'PRESENTE'), (10, 11, 'PRESENTE'), (10, 12, 'PRESENTE'), (10, 13, 'FALTA'),
-- Agendamento 11 (14/08 10:00 - Quinta - Fisioterapia)
(11, 11, 'PRESENTE'), (11, 12, 'PRESENTE'), (11, 13, 'PRESENTE'), (11, 14, 'FALTA'),
-- Agendamento 12 (15/08 09:00 - Sexta - RPG)
(12, 12, 'PRESENTE'), (12, 13, 'PRESENTE'), (12, 14, 'PRESENTE'), (12, 15, 'FALTA'),
-- Agendamento 13 (18/08 08:00 - Segunda - Pilates)
(13, 13, 'PRESENTE'), (13, 14, 'PRESENTE'), (13, 15, 'PRESENTE'), (13, 16, 'FALTA'),
-- Agendamento 14 (19/08 08:00 - Terça - Pilates)
(14, 14, 'PRESENTE'), (14, 15, 'PRESENTE'), (14, 16, 'PRESENTE'), (14, 17, 'FALTA'),
-- Agendamento 15 (21/08 14:00 - Quinta - Fisioterapia)
(15, 15, 'PRESENTE'), (15, 16, 'PRESENTE'), (15, 17, 'PRESENTE'), (15, 18, 'FALTA'),
-- Agendamento 16 (22/08 10:00 - Sexta - RPG)
(16, 16, 'PRESENTE'), (16, 17, 'PRESENTE'), (16, 18, 'PRESENTE'), (16, 19, 'FALTA'),
-- Agendamento 17 (25/08 08:00 - Segunda - Pilates)
(17, 17, 'PRESENTE'), (17, 18, 'PRESENTE'), (17, 19, 'PRESENTE'), (17, 20, 'FALTA'),
-- Agendamento 18 (25/08 10:00 - Segunda - RPG)
(18, 18, 'PRESENTE'), (18, 19, 'PRESENTE'), (18, 20, 'PRESENTE'), (18, 11, 'FALTA'),
-- Agendamento 19 (26/08 08:00 - Terça - Pilates)
(19, 19, 'PRESENTE'), (19, 20, 'PRESENTE'), (19, 11, 'PRESENTE'), (19, 12, 'FALTA'),
-- Agendamento 20 (28/08 10:00 - Quinta - Fisioterapia)
(20, 20, 'PRESENTE'), (20, 11, 'PRESENTE'), (20, 12, 'PRESENTE'), (20, 13, 'FALTA'),
-- Agendamento 21 (29/08 09:00 - Sexta - RPG)
(21, 11, 'PRESENTE'), (21, 12, 'PRESENTE'), (21, 13, 'PRESENTE'), (21, 14, 'FALTA'),
-- Agendamento 22 (11/08 11:00 - Segunda - Pilates)
(22, 2, 'PRESENTE'), (22, 3, 'PRESENTE'), (22, 4, 'PRESENTE'), (22, 5, 'FALTA'),
-- Agendamento 23 (11/08 15:00 - Segunda - Fisioterapia)
(23, 3, 'PRESENTE'), (23, 4, 'PRESENTE'), (23, 5, 'PRESENTE'), (23, 6, 'FALTA'),
-- Agendamento 24 (11/08 17:00 - Segunda - Pilates)
(24, 4, 'PRESENTE'), (24, 5, 'PRESENTE'), (24, 6, 'PRESENTE'), (24, 7, 'FALTA'),
-- Agendamento 25 (12/08 09:00 - Terça - Pilates)
(25, 5, 'PRESENTE'), (25, 6, 'PRESENTE'), (25, 7, 'PRESENTE'), (25, 8, 'FALTA'),
-- Agendamento 26 (12/08 11:00 - Terça - RPG)
(26, 6, 'PRESENTE'), (26, 7, 'PRESENTE'), (26, 8, 'PRESENTE'), (26, 9, 'FALTA'),
-- Agendamento 27 (12/08 13:00 - Terça - Fisioterapia)
(27, 7, 'PRESENTE'), (27, 8, 'PRESENTE'), (27, 9, 'PRESENTE'), (27, 10, 'FALTA'),
-- Agendamento 28 (12/08 15:00 - Terça - Pilates)
(28, 8, 'PRESENTE'), (28, 9, 'PRESENTE'), (28, 10, 'PRESENTE'), (28, 1, 'FALTA'),
-- Agendamento 29 (13/08 09:00 - Quarta - Pilates)
(29, 9, 'PRESENTE'), (29, 10, 'PRESENTE'), (29, 1, 'PRESENTE'), (29, 2, 'FALTA'),
-- Agendamento 30 (13/08 11:00 - Quarta - RPG)
(30, 10, 'PRESENTE'), (30, 1, 'PRESENTE'), (30, 2, 'PRESENTE'), (30, 3, 'FALTA'),
-- Agendamento 31 (13/08 14:00 - Quarta - Fisioterapia)
(31, 1, 'PRESENTE'), (31, 2, 'PRESENTE'), (31, 3, 'PRESENTE'), (31, 4, 'FALTA'),
-- Agendamento 32 (13/08 16:00 - Quarta - Pilates)
(32, 2, 'PRESENTE'), (32, 3, 'PRESENTE'), (32, 4, 'PRESENTE'), (32, 5, 'FALTA'),
-- Agendamento 33 (14/08 09:00 - Quinta - Pilates)
(33, 3, 'PRESENTE'), (33, 4, 'PRESENTE'), (33, 5, 'PRESENTE'), (33, 6, 'FALTA'),
-- Agendamento 34 (14/08 11:00 - Quinta - RPG)
(34, 4, 'PRESENTE'), (34, 5, 'PRESENTE'), (34, 6, 'PRESENTE'), (34, 7, 'FALTA'),
-- Agendamento 35 (14/08 15:00 - Quinta - Pilates)
(35, 5, 'PRESENTE'), (35, 6, 'PRESENTE'), (35, 7, 'PRESENTE'), (35, 8, 'FALTA'),
-- Agendamento 36 (14/08 17:00 - Quinta - Fisioterapia)
(36, 6, 'PRESENTE'), (36, 7, 'PRESENTE'), (36, 8, 'PRESENTE'), (36, 9, 'FALTA'),
-- Agendamento 37 (15/08 09:00 - Sexta - RPG)
(37, 7, 'PRESENTE'), (37, 8, 'PRESENTE'), (37, 9, 'PRESENTE'), (37, 10, 'FALTA'),
-- Agendamento 38 (15/08 11:00 - Sexta - Pilates)
(38, 8, 'PRESENTE'), (38, 9, 'PRESENTE'), (38, 10, 'PRESENTE'), (38, 1, 'FALTA'),
-- Agendamento 39 (15/08 13:00 - Sexta - Fisioterapia)
(39, 9, 'PRESENTE'), (39, 10, 'PRESENTE'), (39, 1, 'PRESENTE'), (39, 2, 'FALTA'),
-- Agendamento 40 (15/08 15:00 - Sexta - Pilates)
(40, 10, 'PRESENTE'), (40, 1, 'PRESENTE'), (40, 2, 'PRESENTE'), (40, 3, 'FALTA'),
-- Agendamento 41 (18/08 09:00 - Segunda - Pilates)
(41, 1, 'PRESENTE'), (41, 2, 'PRESENTE'), (41, 3, 'PRESENTE'), (41, 4, 'FALTA'),
-- Agendamento 42 (18/08 11:00 - Segunda - RPG)
(42, 2, 'PRESENTE'), (42, 3, 'PRESENTE'), (42, 4, 'PRESENTE'), (42, 5, 'FALTA'),
-- Agendamento 43 (18/08 13:00 - Segunda - Fisioterapia)
(43, 3, 'PRESENTE'), (43, 4, 'PRESENTE'), (43, 5, 'PRESENTE'), (43, 6, 'FALTA'),
-- Agendamento 44 (18/08 15:00 - Segunda - Pilates)
(44, 4, 'PRESENTE'), (44, 5, 'PRESENTE'), (44, 6, 'PRESENTE'), (44, 7, 'FALTA'),
-- Agendamento 45 (19/08 09:00 - Terça - RPG)
(45, 5, 'PRESENTE'), (45, 6, 'PRESENTE'), (45, 7, 'PRESENTE'), (45, 8, 'FALTA'),
-- Agendamento 46 (19/08 11:00 - Terça - Pilates)
(46, 6, 'PRESENTE'), (46, 7, 'PRESENTE'), (46, 8, 'PRESENTE'), (46, 9, 'FALTA'),
-- Agendamento 47 (19/08 14:00 - Terça - Fisioterapia)
(47, 7, 'PRESENTE'), (47, 8, 'PRESENTE'), (47, 9, 'PRESENTE'), (47, 10, 'FALTA'),
-- Agendamento 48 (19/08 16:00 - Terça - Pilates)
(48, 8, 'PRESENTE'), (48, 9, 'PRESENTE'), (48, 10, 'PRESENTE'), (48, 1, 'FALTA');

-- Agendamentos de setembro do Andrei (IDs 22-40) - PASSADOS
INSERT IGNORE INTO agendamento_aluno (agendamento_id, aluno_id, status_presenca) VALUES
-- Agendamento 22 (01/09 08:00 - Segunda - Pilates)
(22, 11, 'PRESENTE'), (22, 12, 'PRESENTE'), (22, 13, 'PRESENTE'), (22, 14, 'FALTA'),
-- Agendamento 23 (01/09 14:00 - Segunda - Fisioterapia)
(23, 12, 'PRESENTE'), (23, 13, 'PRESENTE'), (23, 14, 'PRESENTE'), (23, 15, 'FALTA'),
-- Agendamento 24 (02/09 08:00 - Terça - Pilates)
(24, 13, 'PRESENTE'), (24, 14, 'PRESENTE'), (24, 15, 'PRESENTE'), (24, 16, 'FALTA'),
-- Agendamento 25 (04/09 10:00 - Quinta - RPG)
(25, 14, 'PRESENTE'), (25, 15, 'PRESENTE'), (25, 16, 'PRESENTE'), (25, 17, 'FALTA'),
-- Agendamento 26 (05/09 14:00 - Sexta - Fisioterapia)
(26, 15, 'PRESENTE'), (26, 16, 'PRESENTE'), (26, 17, 'PRESENTE'), (26, 18, 'FALTA'),
-- Agendamento 27 (08/09 08:00 - Segunda - Pilates)
(27, 16, 'PRESENTE'), (27, 17, 'PRESENTE'), (27, 18, 'PRESENTE'), (27, 19, 'FALTA'),
-- Agendamento 28 (08/09 10:00 - Segunda - RPG)
(28, 17, 'PRESENTE'), (28, 18, 'PRESENTE'), (28, 19, 'PRESENTE'), (28, 20, 'FALTA'),
-- Agendamento 29 (09/09 08:00 - Terça - Pilates)
(29, 18, 'PRESENTE'), (29, 19, 'PRESENTE'), (29, 20, 'PRESENTE'), (29, 11, 'FALTA'),
-- Agendamento 30 (11/09 10:00 - Quinta - Fisioterapia)
(30, 19, 'PRESENTE'), (30, 20, 'PRESENTE'), (30, 11, 'PRESENTE'), (30, 12, 'FALTA'),
-- Agendamento 31 (12/09 09:00 - Sexta - RPG)
(31, 20, 'PRESENTE'), (31, 11, 'PRESENTE'), (31, 12, 'PRESENTE'), (31, 13, 'FALTA'),
-- Agendamento 32 (15/09 08:00 - Segunda - Pilates)
(32, 11, 'PRESENTE'), (32, 12, 'PRESENTE'), (32, 13, 'PRESENTE'), (32, 14, 'FALTA'),
-- Agendamento 33 (16/09 08:00 - Terça - Pilates)
(33, 12, 'PRESENTE'), (33, 13, 'PRESENTE'), (33, 14, 'PRESENTE'), (33, 15, 'FALTA'),
-- Agendamento 34 (18/09 14:00 - Quinta - Fisioterapia)
(34, 13, 'PRESENTE'), (34, 14, 'PRESENTE'), (34, 15, 'PRESENTE'), (34, 16, 'FALTA'),
-- Agendamento 35 (19/09 10:00 - Sexta - RPG)
(35, 14, 'PRESENTE'), (35, 15, 'PRESENTE'), (35, 16, 'PRESENTE'), (35, 17, 'FALTA'),
-- Agendamento 36 (22/09 08:00 - Segunda - Pilates)
(36, 15, 'PRESENTE'), (36, 16, 'PRESENTE'), (36, 17, 'PRESENTE'), (36, 18, 'FALTA'),
-- Agendamento 37 (22/09 10:00 - Segunda - RPG)
(37, 16, 'PRESENTE'), (37, 17, 'PRESENTE'), (37, 18, 'PRESENTE'), (37, 19, 'FALTA'),
-- Agendamento 38 (23/09 08:00 - Terça - Pilates)
(38, 17, 'PRESENTE'), (38, 18, 'PRESENTE'), (38, 19, 'PRESENTE'), (38, 20, 'FALTA'),
-- Agendamento 39 (25/09 10:00 - Quinta - Fisioterapia)
(39, 18, 'PRESENTE'), (39, 19, 'PRESENTE'), (39, 20, 'PRESENTE'), (39, 11, 'FALTA'),
-- Agendamento 40 (26/09 09:00 - Sexta - RPG)
(40, 19, 'PRESENTE'), (40, 20, 'PRESENTE'), (40, 11, 'PRESENTE'), (40, 12, 'FALTA');

-- Agendamentos de outubro do Andrei (IDs 41-61) - PASSADOS
INSERT IGNORE INTO agendamento_aluno (agendamento_id, aluno_id, status_presenca) VALUES
-- Agendamento 41 (01/10 08:00 - Quarta - Pilates)
(41, 12, 'PRESENTE'), (41, 13, 'PRESENTE'), (41, 14, 'PRESENTE'), (41, 15, 'FALTA'),
-- Agendamento 42 (02/10 10:00 - Quinta - RPG)
(42, 13, 'PRESENTE'), (42, 14, 'PRESENTE'), (42, 15, 'PRESENTE'), (42, 16, 'FALTA'),
-- Agendamento 43 (03/10 14:00 - Sexta - Fisioterapia)
(43, 14, 'PRESENTE'), (43, 15, 'PRESENTE'), (43, 16, 'PRESENTE'), (43, 17, 'FALTA'),
-- Agendamento 44 (06/10 08:00 - Segunda - Pilates)
(44, 15, 'PRESENTE'), (44, 16, 'PRESENTE'), (44, 17, 'PRESENTE'), (44, 18, 'FALTA'),
-- Agendamento 45 (06/10 10:00 - Segunda - RPG)
(45, 16, 'PRESENTE'), (45, 17, 'PRESENTE'), (45, 18, 'PRESENTE'), (45, 19, 'FALTA'),
-- Agendamento 46 (07/10 08:00 - Terça - Pilates)
(46, 17, 'PRESENTE'), (46, 18, 'PRESENTE'), (46, 19, 'PRESENTE'), (46, 20, 'FALTA'),
-- Agendamento 47 (09/10 10:00 - Quinta - Fisioterapia)
(47, 18, 'PRESENTE'), (47, 19, 'PRESENTE'), (47, 20, 'PRESENTE'), (47, 11, 'FALTA'),
-- Agendamento 48 (10/10 09:00 - Sexta - RPG)
(48, 19, 'PRESENTE'), (48, 20, 'PRESENTE'), (48, 11, 'PRESENTE'), (48, 12, 'FALTA'),
-- Agendamento 49 (13/10 08:00 - Segunda - Pilates)
(49, 20, 'PRESENTE'), (49, 11, 'PRESENTE'), (49, 12, 'PRESENTE'), (49, 13, 'FALTA'),
-- Agendamento 50 (13/10 14:00 - Segunda - Fisioterapia)
(50, 11, 'PRESENTE'), (50, 12, 'PRESENTE'), (50, 13, 'PRESENTE'), (50, 14, 'FALTA'),
-- Agendamento 51 (14/10 08:00 - Terça - Pilates)
(51, 12, 'PRESENTE'), (51, 13, 'PRESENTE'), (51, 14, 'PRESENTE'), (51, 15, 'FALTA'),
-- Agendamento 52 (16/10 14:00 - Quinta - Fisioterapia)
(52, 13, 'PRESENTE'), (52, 14, 'PRESENTE'), (52, 15, 'PRESENTE'), (52, 16, 'FALTA'),
-- Agendamento 53 (17/10 10:00 - Sexta - RPG)
(53, 14, 'PRESENTE'), (53, 15, 'PRESENTE'), (53, 16, 'PRESENTE'), (53, 17, 'FALTA'),
-- Agendamento 54 (20/10 08:00 - Segunda - Pilates)
(54, 15, 'PRESENTE'), (54, 16, 'PRESENTE'), (54, 17, 'PRESENTE'), (54, 18, 'FALTA'),
-- Agendamento 55 (21/10 08:00 - Terça - Pilates)
(55, 16, 'PRESENTE'), (55, 17, 'PRESENTE'), (55, 18, 'PRESENTE'), (55, 19, 'FALTA'),
-- Agendamento 56 (23/10 10:00 - Quinta - Fisioterapia)
(56, 17, 'PRESENTE'), (56, 18, 'PRESENTE'), (56, 19, 'PRESENTE'), (56, 20, 'FALTA'),
-- Agendamento 57 (24/10 09:00 - Sexta - RPG)
(57, 18, 'PRESENTE'), (57, 19, 'PRESENTE'), (57, 20, 'PRESENTE'), (57, 11, 'FALTA'),
-- Agendamento 58 (27/10 08:00 - Segunda - Pilates)
(58, 19, 'PRESENTE'), (58, 20, 'PRESENTE'), (58, 11, 'PRESENTE'), (58, 12, 'FALTA'),
-- Agendamento 59 (27/10 10:00 - Segunda - RPG)
(59, 20, 'PRESENTE'), (59, 11, 'PRESENTE'), (59, 12, 'PRESENTE'), (59, 13, 'FALTA'),
-- Agendamento 60 (28/10 08:00 - Terça - Pilates)
(60, 11, 'PRESENTE'), (60, 12, 'PRESENTE'), (60, 13, 'PRESENTE'), (60, 14, 'FALTA'),
-- Agendamento 61 (30/10 14:00 - Quinta - Fisioterapia)
(61, 12, 'PRESENTE'), (61, 13, 'PRESENTE'), (61, 14, 'PRESENTE'), (61, 15, 'FALTA');

-- Agendamentos de novembro do Andrei (IDs 62-80)
-- Agendamentos até 14/11/2025 são PASSADOS, após são FUTUROS
INSERT IGNORE INTO agendamento_aluno (agendamento_id, aluno_id, status_presenca) VALUES
-- Agendamento 62 (31/10 09:00 - Sexta - RPG) - PASSADO (ajustado de 01/11 sábado)
(62, 13, 'PRESENTE'), (62, 14, 'PRESENTE'), (62, 15, 'PRESENTE'), (62, 16, 'FALTA'),
-- Agendamento 63 (03/11 08:00 - Segunda - Pilates) - PASSADO
(63, 14, 'PRESENTE'), (63, 15, 'PRESENTE'), (63, 16, 'PRESENTE'), (63, 17, 'FALTA'),
-- Agendamento 64 (03/11 10:00 - Segunda - RPG) - PASSADO
(64, 15, 'PRESENTE'), (64, 16, 'PRESENTE'), (64, 17, 'PRESENTE'), (64, 18, 'FALTA'),
-- Agendamento 65 (04/11 08:00 - Terça - Pilates) - PASSADO
(65, 16, 'PRESENTE'), (65, 17, 'PRESENTE'), (65, 18, 'PRESENTE'), (65, 19, 'FALTA'),
-- Agendamento 66 (06/11 10:00 - Quinta - Fisioterapia) - PASSADO
(66, 17, 'PRESENTE'), (66, 18, 'PRESENTE'), (66, 19, 'PRESENTE'), (66, 20, 'FALTA'),
-- Agendamento 67 (07/11 09:00 - Sexta - RPG) - PASSADO (ajustado de 08/11 sábado)
(67, 18, 'PRESENTE'), (67, 19, 'PRESENTE'), (67, 20, 'PRESENTE'), (67, 11, 'FALTA'),
-- Agendamento 68 (10/11 08:00 - Segunda - Pilates) - PASSADO
(68, 19, 'PRESENTE'), (68, 20, 'PRESENTE'), (68, 11, 'PRESENTE'), (68, 12, 'FALTA'),
-- Agendamento 69 (10/11 14:00 - Segunda - Fisioterapia) - PASSADO
(69, 20, 'PRESENTE'), (69, 11, 'PRESENTE'), (69, 12, 'PRESENTE'), (69, 13, 'FALTA'),
-- Agendamento 70 (11/11 08:00 - Terça - Pilates) - PASSADO
(70, 11, 'PRESENTE'), (70, 12, 'PRESENTE'), (70, 13, 'PRESENTE'), (70, 14, 'FALTA'),
-- Agendamento 71 (13/11 14:00 - Quinta - Fisioterapia) - PASSADO
(71, 12, 'PRESENTE'), (71, 13, 'PRESENTE'), (71, 14, 'PRESENTE'), (71, 15, 'FALTA'),
-- Agendamento 72 (14/11 10:00 - Sexta - RPG) - PASSADO (último dia considerado passado, ajustado de 15/11 sábado)
(72, 13, 'PRESENTE'), (72, 14, 'PRESENTE'), (72, 15, 'PRESENTE'), (72, 16, 'FALTA'),
-- Agendamento 73 (17/11 08:00 - Segunda - Pilates) - FUTURO
(73, 14, 'PENDENTE'), (73, 15, 'PENDENTE'), (73, 16, 'PENDENTE'), (73, 17, 'PENDENTE'),
-- Agendamento 74 (18/11 08:00 - Terça - Pilates) - FUTURO
(74, 15, 'PENDENTE'), (74, 16, 'PENDENTE'), (74, 17, 'PENDENTE'), (74, 18, 'PENDENTE'),
-- Agendamento 75 (20/11 10:00 - Quinta - Fisioterapia) - FUTURO
(75, 16, 'PENDENTE'), (75, 17, 'PENDENTE'), (75, 18, 'PENDENTE'), (75, 19, 'PENDENTE'),
-- Agendamento 76 (21/11 09:00 - Sexta - RPG) - FUTURO (ajustado de 22/11 sábado)
(76, 17, 'PENDENTE'), (76, 18, 'PENDENTE'), (76, 19, 'PENDENTE'), (76, 20, 'PENDENTE'),
-- Agendamento 77 (24/11 08:00 - Segunda - Pilates) - FUTURO
(77, 18, 'PENDENTE'), (77, 19, 'PENDENTE'), (77, 20, 'PENDENTE'), (77, 11, 'PENDENTE'),
-- Agendamento 78 (24/11 10:00 - Segunda - RPG) - FUTURO
(78, 19, 'PENDENTE'), (78, 20, 'PENDENTE'), (78, 11, 'PENDENTE'), (78, 12, 'PENDENTE'),
-- Agendamento 79 (25/11 08:00 - Terça - Pilates) - FUTURO
(79, 20, 'PENDENTE'), (79, 11, 'PENDENTE'), (79, 12, 'PENDENTE'), (79, 13, 'PENDENTE'),
-- Agendamento 80 (27/11 14:00 - Quinta - Fisioterapia) - FUTURO
(80, 11, 'PENDENTE'), (80, 12, 'PENDENTE'), (80, 13, 'PENDENTE'), (80, 14, 'PENDENTE');

-- Agendamentos de dezembro do Andrei (IDs 81-97) - FUTUROS
INSERT IGNORE INTO agendamento_aluno (agendamento_id, aluno_id, status_presenca) VALUES
-- Agendamento 81 (01/12 08:00 - Segunda - Pilates)
(81, 12, 'PENDENTE'), (81, 13, 'PENDENTE'), (81, 14, 'PENDENTE'), (81, 15, 'PENDENTE'),
-- Agendamento 82 (01/12 10:00 - Segunda - RPG)
(82, 13, 'PENDENTE'), (82, 14, 'PENDENTE'), (82, 15, 'PENDENTE'), (82, 16, 'PENDENTE'),
-- Agendamento 83 (02/12 08:00 - Terça - Pilates)
(83, 14, 'PENDENTE'), (83, 15, 'PENDENTE'), (83, 16, 'PENDENTE'), (83, 17, 'PENDENTE'),
-- Agendamento 84 (04/12 10:00 - Quinta - RPG)
(84, 15, 'PENDENTE'), (84, 16, 'PENDENTE'), (84, 17, 'PENDENTE'), (84, 18, 'PENDENTE'),
-- Agendamento 85 (05/12 14:00 - Sexta - Fisioterapia) (ajustado de 06/12 sábado)
(85, 16, 'PENDENTE'), (85, 17, 'PENDENTE'), (85, 18, 'PENDENTE'), (85, 19, 'PENDENTE'),
-- Agendamento 86 (08/12 08:00 - Segunda - Pilates)
(86, 17, 'PENDENTE'), (86, 18, 'PENDENTE'), (86, 19, 'PENDENTE'), (86, 20, 'PENDENTE'),
-- Agendamento 87 (08/12 14:00 - Segunda - Fisioterapia)
(87, 18, 'PENDENTE'), (87, 19, 'PENDENTE'), (87, 20, 'PENDENTE'), (87, 11, 'PENDENTE'),
-- Agendamento 88 (09/12 08:00 - Terça - Pilates)
(88, 19, 'PENDENTE'), (88, 20, 'PENDENTE'), (88, 11, 'PENDENTE'), (88, 12, 'PENDENTE'),
-- Agendamento 89 (11/12 10:00 - Quinta - Fisioterapia)
(89, 20, 'PENDENTE'), (89, 11, 'PENDENTE'), (89, 12, 'PENDENTE'), (89, 13, 'PENDENTE'),
-- Agendamento 90 (12/12 09:00 - Sexta - RPG) (ajustado de 13/12 sábado)
(90, 11, 'PENDENTE'), (90, 12, 'PENDENTE'), (90, 13, 'PENDENTE'), (90, 14, 'PENDENTE'),
-- Agendamento 91 (15/12 08:00 - Segunda - Pilates)
(91, 12, 'PENDENTE'), (91, 13, 'PENDENTE'), (91, 14, 'PENDENTE'), (91, 15, 'PENDENTE'),
-- Agendamento 92 (15/12 10:00 - Segunda - RPG)
(92, 13, 'PENDENTE'), (92, 14, 'PENDENTE'), (92, 15, 'PENDENTE'), (92, 16, 'PENDENTE'),
-- Agendamento 93 (16/12 08:00 - Terça - Pilates)
(93, 14, 'PENDENTE'), (93, 15, 'PENDENTE'), (93, 16, 'PENDENTE'), (93, 17, 'PENDENTE'),
-- Agendamento 94 (18/12 14:00 - Quinta - Fisioterapia)
(94, 15, 'PENDENTE'), (94, 16, 'PENDENTE'), (94, 17, 'PENDENTE'), (94, 18, 'PENDENTE'),
-- Agendamento 95 (19/12 10:00 - Sexta - RPG) (ajustado de 20/12 sábado)
(95, 16, 'PENDENTE'), (95, 17, 'PENDENTE'), (95, 18, 'PENDENTE'), (95, 19, 'PENDENTE'),
-- Agendamento 96 (22/12 08:00 - Segunda - Pilates)
(96, 17, 'PENDENTE'), (96, 18, 'PENDENTE'), (96, 19, 'PENDENTE'), (96, 20, 'PENDENTE'),
-- Agendamento 97 (22/12 14:00 - Segunda - Fisioterapia)
(97, 18, 'PENDENTE'), (97, 19, 'PENDENTE'), (97, 20, 'PENDENTE'), (97, 11, 'PENDENTE');

-- ============================================
-- AGENDAMENTOS DO PROFESSOR GUILHERME (IDs 98-457)
-- ============================================
-- Estratégia: Guilherme usa principalmente alunos 1-10 para evitar conflitos com Andrei
-- Agendamentos de agosto do Guilherme (IDs 98-145) - PASSADOS
INSERT IGNORE INTO agendamento_aluno (agendamento_id, aluno_id, status_presenca) VALUES
-- Agendamento 98 (04/08 09:00 - Segunda - Pilates)
(98, 1, 'PRESENTE'), (98, 2, 'PRESENTE'), (98, 3, 'PRESENTE'), (98, 4, 'FALTA'),
-- Agendamento 99 (04/08 11:00 - Segunda - RPG)
(99, 2, 'PRESENTE'), (99, 3, 'PRESENTE'), (99, 4, 'PRESENTE'), (99, 5, 'FALTA'),
-- Agendamento 100 (04/08 13:00 - Segunda - Fisioterapia)
(100, 3, 'PRESENTE'), (100, 4, 'PRESENTE'), (100, 5, 'PRESENTE'), (100, 6, 'FALTA'),
-- Agendamento 101 (04/08 15:00 - Segunda - Pilates)
(101, 4, 'PRESENTE'), (101, 5, 'PRESENTE'), (101, 6, 'PRESENTE'), (101, 7, 'FALTA'),
-- Agendamento 102 (05/08 09:00 - Terça - RPG)
(102, 5, 'PRESENTE'), (102, 6, 'PRESENTE'), (102, 7, 'PRESENTE'), (102, 8, 'FALTA'),
-- Agendamento 103 (05/08 11:00 - Terça - Pilates)
(103, 6, 'PRESENTE'), (103, 7, 'PRESENTE'), (103, 8, 'PRESENTE'), (103, 9, 'FALTA'),
-- Agendamento 104 (05/08 14:00 - Terça - Fisioterapia)
(104, 7, 'PRESENTE'), (104, 8, 'PRESENTE'), (104, 9, 'PRESENTE'), (104, 10, 'FALTA'),
-- Agendamento 105 (05/08 16:00 - Terça - Pilates)
(105, 8, 'PRESENTE'), (105, 9, 'PRESENTE'), (105, 10, 'PRESENTE'), (105, 1, 'FALTA'),
-- Agendamento 106 (06/08 09:00 - Quarta - Pilates)
(106, 9, 'PRESENTE'), (106, 10, 'PRESENTE'), (106, 1, 'PRESENTE'), (106, 2, 'FALTA'),
-- Agendamento 107 (06/08 11:00 - Quarta - RPG)
(107, 10, 'PRESENTE'), (107, 1, 'PRESENTE'), (107, 2, 'PRESENTE'), (107, 3, 'FALTA'),
-- Agendamento 108 (06/08 13:00 - Quarta - Fisioterapia)
(108, 1, 'PRESENTE'), (108, 2, 'PRESENTE'), (108, 3, 'PRESENTE'), (108, 4, 'FALTA'),
-- Agendamento 109 (06/08 15:00 - Quarta - Pilates)
(109, 2, 'PRESENTE'), (109, 3, 'PRESENTE'), (109, 4, 'PRESENTE'), (109, 5, 'FALTA'),
-- Agendamento 110 (07/08 09:00 - Quinta - RPG)
(110, 3, 'PRESENTE'), (110, 4, 'PRESENTE'), (110, 5, 'PRESENTE'), (110, 6, 'FALTA'),
-- Agendamento 111 (07/08 11:00 - Quinta - Pilates)
(111, 4, 'PRESENTE'), (111, 5, 'PRESENTE'), (111, 6, 'PRESENTE'), (111, 7, 'FALTA'),
-- Agendamento 112 (07/08 15:00 - Quinta - Fisioterapia)
(112, 5, 'PRESENTE'), (112, 6, 'PRESENTE'), (112, 7, 'PRESENTE'), (112, 8, 'FALTA'),
-- Agendamento 113 (07/08 17:00 - Quinta - Pilates)
(113, 6, 'PRESENTE'), (113, 7, 'PRESENTE'), (113, 8, 'PRESENTE'), (113, 9, 'FALTA'),
-- Agendamento 114 (08/08 09:00 - Sexta - Pilates)
(114, 7, 'PRESENTE'), (114, 8, 'PRESENTE'), (114, 9, 'PRESENTE'), (114, 10, 'FALTA'),
-- Agendamento 115 (08/08 11:00 - Sexta - RPG)
(115, 8, 'PRESENTE'), (115, 9, 'PRESENTE'), (115, 10, 'PRESENTE'), (115, 1, 'FALTA'),
-- Agendamento 116 (08/08 13:00 - Sexta - Fisioterapia)
(116, 9, 'PRESENTE'), (116, 10, 'PRESENTE'), (116, 1, 'PRESENTE'), (116, 2, 'FALTA'),
-- Agendamento 117 (08/08 15:00 - Sexta - Pilates)
(117, 10, 'PRESENTE'), (117, 1, 'PRESENTE'), (117, 2, 'PRESENTE'), (117, 3, 'FALTA'),
-- Agendamento 118 (11/08 09:00 - Segunda - RPG)
(118, 1, 'PRESENTE'), (118, 2, 'PRESENTE'), (118, 3, 'PRESENTE'), (118, 4, 'FALTA'),
-- Agendamento 119 (11/08 11:00 - Segunda - Pilates)
(119, 2, 'PRESENTE'), (119, 3, 'PRESENTE'), (119, 4, 'PRESENTE'), (119, 5, 'FALTA'),
-- Agendamento 120 (11/08 15:00 - Segunda - Fisioterapia)
(120, 3, 'PRESENTE'), (120, 4, 'PRESENTE'), (120, 5, 'PRESENTE'), (120, 6, 'FALTA'),
-- Agendamento 121 (11/08 17:00 - Segunda - Pilates)
(121, 4, 'PRESENTE'), (121, 5, 'PRESENTE'), (121, 6, 'PRESENTE'), (121, 7, 'FALTA'),
-- Agendamento 122 (12/08 09:00 - Terça - Pilates)
(122, 5, 'PRESENTE'), (122, 6, 'PRESENTE'), (122, 7, 'PRESENTE'), (122, 8, 'FALTA'),
-- Agendamento 123 (12/08 11:00 - Terça - RPG)
(123, 6, 'PRESENTE'), (123, 7, 'PRESENTE'), (123, 8, 'PRESENTE'), (123, 9, 'FALTA'),
-- Agendamento 124 (12/08 13:00 - Terça - Fisioterapia)
(124, 7, 'PRESENTE'), (124, 8, 'PRESENTE'), (124, 9, 'PRESENTE'), (124, 10, 'FALTA'),
-- Agendamento 125 (12/08 15:00 - Terça - Pilates)
(125, 8, 'PRESENTE'), (125, 9, 'PRESENTE'), (125, 10, 'PRESENTE'), (125, 1, 'FALTA'),
-- Agendamento 126 (13/08 09:00 - Quarta - Pilates)
(126, 9, 'PRESENTE'), (126, 10, 'PRESENTE'), (126, 1, 'PRESENTE'), (126, 2, 'FALTA'),
-- Agendamento 127 (13/08 11:00 - Quarta - RPG)
(127, 10, 'PRESENTE'), (127, 1, 'PRESENTE'), (127, 2, 'PRESENTE'), (127, 3, 'FALTA'),
-- Agendamento 128 (13/08 14:00 - Quarta - Fisioterapia)
(128, 1, 'PRESENTE'), (128, 2, 'PRESENTE'), (128, 3, 'PRESENTE'), (128, 4, 'FALTA'),
-- Agendamento 129 (13/08 16:00 - Quarta - Pilates)
(129, 2, 'PRESENTE'), (129, 3, 'PRESENTE'), (129, 4, 'PRESENTE'), (129, 5, 'FALTA'),
-- Agendamento 130 (14/08 09:00 - Quinta - Pilates)
(130, 3, 'PRESENTE'), (130, 4, 'PRESENTE'), (130, 5, 'PRESENTE'), (130, 6, 'FALTA'),
-- Agendamento 131 (14/08 11:00 - Quinta - RPG)
(131, 4, 'PRESENTE'), (131, 5, 'PRESENTE'), (131, 6, 'PRESENTE'), (131, 7, 'FALTA'),
-- Agendamento 132 (14/08 15:00 - Quinta - Pilates)
(132, 5, 'PRESENTE'), (132, 6, 'PRESENTE'), (132, 7, 'PRESENTE'), (132, 8, 'FALTA'),
-- Agendamento 133 (14/08 17:00 - Quinta - Fisioterapia)
(133, 6, 'PRESENTE'), (133, 7, 'PRESENTE'), (133, 8, 'PRESENTE'), (133, 9, 'FALTA'),
-- Agendamento 134 (15/08 09:00 - Sexta - RPG)
(134, 7, 'PRESENTE'), (134, 8, 'PRESENTE'), (134, 9, 'PRESENTE'), (134, 10, 'FALTA'),
-- Agendamento 135 (15/08 11:00 - Sexta - Pilates)
(135, 8, 'PRESENTE'), (135, 9, 'PRESENTE'), (135, 10, 'PRESENTE'), (135, 1, 'FALTA'),
-- Agendamento 136 (15/08 13:00 - Sexta - Fisioterapia)
(136, 9, 'PRESENTE'), (136, 10, 'PRESENTE'), (136, 1, 'PRESENTE'), (136, 2, 'FALTA'),
-- Agendamento 137 (15/08 15:00 - Sexta - Pilates)
(137, 10, 'PRESENTE'), (137, 1, 'PRESENTE'), (137, 2, 'PRESENTE'), (137, 3, 'FALTA'),
-- Agendamento 138 (18/08 09:00 - Segunda - Pilates)
(138, 1, 'PRESENTE'), (138, 2, 'PRESENTE'), (138, 3, 'PRESENTE'), (138, 4, 'FALTA'),
-- Agendamento 139 (18/08 11:00 - Segunda - RPG)
(139, 2, 'PRESENTE'), (139, 3, 'PRESENTE'), (139, 4, 'PRESENTE'), (139, 5, 'FALTA'),
-- Agendamento 140 (18/08 13:00 - Segunda - Fisioterapia)
(140, 3, 'PRESENTE'), (140, 4, 'PRESENTE'), (140, 5, 'PRESENTE'), (140, 6, 'FALTA'),
-- Agendamento 141 (18/08 15:00 - Segunda - Pilates)
(141, 4, 'PRESENTE'), (141, 5, 'PRESENTE'), (141, 6, 'PRESENTE'), (141, 7, 'FALTA'),
-- Agendamento 142 (19/08 09:00 - Terça - RPG)
(142, 5, 'PRESENTE'), (142, 6, 'PRESENTE'), (142, 7, 'PRESENTE'), (142, 8, 'FALTA'),
-- Agendamento 143 (19/08 11:00 - Terça - Pilates)
(143, 6, 'PRESENTE'), (143, 7, 'PRESENTE'), (143, 8, 'PRESENTE'), (143, 9, 'FALTA'),
-- Agendamento 144 (19/08 14:00 - Terça - Fisioterapia)
(144, 7, 'PRESENTE'), (144, 8, 'PRESENTE'), (144, 9, 'PRESENTE'), (144, 10, 'FALTA'),
-- Agendamento 145 (19/08 16:00 - Terça - Pilates)
(145, 8, 'PRESENTE'), (145, 9, 'PRESENTE'), (145, 10, 'PRESENTE'), (145, 1, 'FALTA');

-- Agendamentos de setembro do Guilherme (IDs 146-225) - PASSADOS
INSERT IGNORE INTO agendamento_aluno (agendamento_id, aluno_id, status_presenca) VALUES
-- Agendamento 146 (01/09 09:00 - Segunda - Pilates)
(146, 9, 'PRESENTE'), (146, 10, 'PRESENTE'), (146, 1, 'PRESENTE'), (146, 2, 'FALTA'),
-- Agendamento 147 (01/09 11:00 - Segunda - RPG)
(147, 10, 'PRESENTE'), (147, 1, 'PRESENTE'), (147, 2, 'PRESENTE'), (147, 3, 'FALTA'),
-- Agendamento 148 (01/09 15:00 - Segunda - Fisioterapia)
(148, 1, 'PRESENTE'), (148, 2, 'PRESENTE'), (148, 3, 'PRESENTE'), (148, 4, 'FALTA'),
-- Agendamento 149 (01/09 17:00 - Segunda - Pilates)
(149, 2, 'PRESENTE'), (149, 3, 'PRESENTE'), (149, 4, 'PRESENTE'), (149, 5, 'FALTA'),
-- Agendamento 150 (02/09 09:00 - Terça - Pilates)
(150, 3, 'PRESENTE'), (150, 4, 'PRESENTE'), (150, 5, 'PRESENTE'), (150, 6, 'FALTA'),
-- Agendamento 151 (02/09 11:00 - Terça - RPG)
(151, 4, 'PRESENTE'), (151, 5, 'PRESENTE'), (151, 6, 'PRESENTE'), (151, 7, 'FALTA'),
-- Agendamento 152 (02/09 13:00 - Terça - Fisioterapia)
(152, 5, 'PRESENTE'), (152, 6, 'PRESENTE'), (152, 7, 'PRESENTE'), (152, 8, 'FALTA'),
-- Agendamento 153 (02/09 15:00 - Terça - Pilates)
(153, 6, 'PRESENTE'), (153, 7, 'PRESENTE'), (153, 8, 'PRESENTE'), (153, 9, 'FALTA'),
-- Agendamento 154 (03/09 09:00 - Quarta - Pilates)
(154, 7, 'PRESENTE'), (154, 8, 'PRESENTE'), (154, 9, 'PRESENTE'), (154, 10, 'FALTA'),
-- Agendamento 155 (03/09 11:00 - Quarta - RPG)
(155, 8, 'PRESENTE'), (155, 9, 'PRESENTE'), (155, 10, 'PRESENTE'), (155, 1, 'FALTA'),
-- Agendamento 156 (03/09 14:00 - Quarta - Fisioterapia)
(156, 9, 'PRESENTE'), (156, 10, 'PRESENTE'), (156, 1, 'PRESENTE'), (156, 2, 'FALTA'),
-- Agendamento 157 (03/09 16:00 - Quarta - Pilates)
(157, 10, 'PRESENTE'), (157, 1, 'PRESENTE'), (157, 2, 'PRESENTE'), (157, 3, 'FALTA'),
-- Agendamento 158 (04/09 09:00 - Quinta - Pilates)
(158, 1, 'PRESENTE'), (158, 2, 'PRESENTE'), (158, 3, 'PRESENTE'), (158, 4, 'FALTA'),
-- Agendamento 159 (04/09 11:00 - Quinta - RPG)
(159, 2, 'PRESENTE'), (159, 3, 'PRESENTE'), (159, 4, 'PRESENTE'), (159, 5, 'FALTA'),
-- Agendamento 160 (04/09 15:00 - Quinta - Pilates)
(160, 3, 'PRESENTE'), (160, 4, 'PRESENTE'), (160, 5, 'PRESENTE'), (160, 6, 'FALTA'),
-- Agendamento 161 (04/09 17:00 - Quinta - Fisioterapia)
(161, 4, 'PRESENTE'), (161, 5, 'PRESENTE'), (161, 6, 'PRESENTE'), (161, 7, 'FALTA'),
-- Agendamento 162 (05/09 09:00 - Sexta - RPG)
(162, 5, 'PRESENTE'), (162, 6, 'PRESENTE'), (162, 7, 'PRESENTE'), (162, 8, 'FALTA'),
-- Agendamento 163 (05/09 11:00 - Sexta - Pilates)
(163, 6, 'PRESENTE'), (163, 7, 'PRESENTE'), (163, 8, 'PRESENTE'), (163, 9, 'FALTA'),
-- Agendamento 164 (05/09 13:00 - Sexta - Fisioterapia)
(164, 7, 'PRESENTE'), (164, 8, 'PRESENTE'), (164, 9, 'PRESENTE'), (164, 10, 'FALTA'),
-- Agendamento 165 (05/09 15:00 - Sexta - Pilates)
(165, 8, 'PRESENTE'), (165, 9, 'PRESENTE'), (165, 10, 'PRESENTE'), (165, 1, 'FALTA'),
-- Agendamento 166 (08/09 09:00 - Segunda - Pilates)
(166, 9, 'PRESENTE'), (166, 10, 'PRESENTE'), (166, 1, 'PRESENTE'), (166, 2, 'FALTA'),
-- Agendamento 167 (08/09 11:00 - Segunda - RPG)
(167, 10, 'PRESENTE'), (167, 1, 'PRESENTE'), (167, 2, 'PRESENTE'), (167, 3, 'FALTA'),
-- Agendamento 168 (08/09 15:00 - Segunda - Fisioterapia)
(168, 1, 'PRESENTE'), (168, 2, 'PRESENTE'), (168, 3, 'PRESENTE'), (168, 4, 'FALTA'),
-- Agendamento 169 (08/09 17:00 - Segunda - Pilates)
(169, 2, 'PRESENTE'), (169, 3, 'PRESENTE'), (169, 4, 'PRESENTE'), (169, 5, 'FALTA'),
-- Agendamento 170 (09/09 09:00 - Terça - RPG)
(170, 3, 'PRESENTE'), (170, 4, 'PRESENTE'), (170, 5, 'PRESENTE'), (170, 6, 'FALTA'),
-- Agendamento 171 (09/09 11:00 - Terça - Pilates)
(171, 4, 'PRESENTE'), (171, 5, 'PRESENTE'), (171, 6, 'PRESENTE'), (171, 7, 'FALTA'),
-- Agendamento 172 (09/09 13:00 - Terça - Fisioterapia)
(172, 5, 'PRESENTE'), (172, 6, 'PRESENTE'), (172, 7, 'PRESENTE'), (172, 8, 'FALTA'),
-- Agendamento 173 (09/09 15:00 - Terça - Pilates)
(173, 6, 'PRESENTE'), (173, 7, 'PRESENTE'), (173, 8, 'PRESENTE'), (173, 9, 'FALTA'),
-- Agendamento 174 (10/09 09:00 - Quarta - Pilates)
(174, 7, 'PRESENTE'), (174, 8, 'PRESENTE'), (174, 9, 'PRESENTE'), (174, 10, 'FALTA'),
-- Agendamento 175 (10/09 11:00 - Quarta - RPG)
(175, 8, 'PRESENTE'), (175, 9, 'PRESENTE'), (175, 10, 'PRESENTE'), (175, 1, 'FALTA'),
-- Agendamento 176 (10/09 14:00 - Quarta - Fisioterapia)
(176, 9, 'PRESENTE'), (176, 10, 'PRESENTE'), (176, 1, 'PRESENTE'), (176, 2, 'FALTA'),
-- Agendamento 177 (10/09 16:00 - Quarta - Pilates)
(177, 10, 'PRESENTE'), (177, 1, 'PRESENTE'), (177, 2, 'PRESENTE'), (177, 3, 'FALTA'),
-- Agendamento 178 (11/09 09:00 - Quinta - Pilates)
(178, 1, 'PRESENTE'), (178, 2, 'PRESENTE'), (178, 3, 'PRESENTE'), (178, 4, 'FALTA'),
-- Agendamento 179 (11/09 11:00 - Quinta - RPG)
(179, 2, 'PRESENTE'), (179, 3, 'PRESENTE'), (179, 4, 'PRESENTE'), (179, 5, 'FALTA'),
-- Agendamento 180 (11/09 15:00 - Quinta - Pilates)
(180, 3, 'PRESENTE'), (180, 4, 'PRESENTE'), (180, 5, 'PRESENTE'), (180, 6, 'FALTA'),
-- Agendamento 181 (11/09 17:00 - Quinta - Fisioterapia)
(181, 4, 'PRESENTE'), (181, 5, 'PRESENTE'), (181, 6, 'PRESENTE'), (181, 7, 'FALTA'),
-- Agendamento 182 (12/09 09:00 - Sexta - RPG)
(182, 5, 'PRESENTE'), (182, 6, 'PRESENTE'), (182, 7, 'PRESENTE'), (182, 8, 'FALTA'),
-- Agendamento 183 (12/09 11:00 - Sexta - Pilates)
(183, 6, 'PRESENTE'), (183, 7, 'PRESENTE'), (183, 8, 'PRESENTE'), (183, 9, 'FALTA'),
-- Agendamento 184 (12/09 13:00 - Sexta - Fisioterapia)
(184, 7, 'PRESENTE'), (184, 8, 'PRESENTE'), (184, 9, 'PRESENTE'), (184, 10, 'FALTA'),
-- Agendamento 185 (12/09 15:00 - Sexta - Pilates)
(185, 8, 'PRESENTE'), (185, 9, 'PRESENTE'), (185, 10, 'PRESENTE'), (185, 1, 'FALTA'),
-- Agendamento 186 (15/09 09:00 - Segunda - Pilates)
(186, 9, 'PRESENTE'), (186, 10, 'PRESENTE'), (186, 1, 'PRESENTE'), (186, 2, 'FALTA'),
-- Agendamento 187 (15/09 11:00 - Segunda - RPG)
(187, 10, 'PRESENTE'), (187, 1, 'PRESENTE'), (187, 2, 'PRESENTE'), (187, 3, 'FALTA'),
-- Agendamento 188 (15/09 15:00 - Segunda - Fisioterapia)
(188, 1, 'PRESENTE'), (188, 2, 'PRESENTE'), (188, 3, 'PRESENTE'), (188, 4, 'FALTA'),
-- Agendamento 189 (15/09 17:00 - Segunda - Pilates)
(189, 2, 'PRESENTE'), (189, 3, 'PRESENTE'), (189, 4, 'PRESENTE'), (189, 5, 'FALTA'),
-- Agendamento 190 (16/09 09:00 - Terça - RPG)
(190, 3, 'PRESENTE'), (190, 4, 'PRESENTE'), (190, 5, 'PRESENTE'), (190, 6, 'FALTA'),
-- Agendamento 191 (16/09 11:00 - Terça - Pilates)
(191, 4, 'PRESENTE'), (191, 5, 'PRESENTE'), (191, 6, 'PRESENTE'), (191, 7, 'FALTA'),
-- Agendamento 192 (16/09 13:00 - Terça - Fisioterapia)
(192, 5, 'PRESENTE'), (192, 6, 'PRESENTE'), (192, 7, 'PRESENTE'), (192, 8, 'FALTA'),
-- Agendamento 193 (16/09 15:00 - Terça - Pilates)
(193, 6, 'PRESENTE'), (193, 7, 'PRESENTE'), (193, 8, 'PRESENTE'), (193, 9, 'FALTA'),
-- Agendamento 194 (17/09 09:00 - Quarta - Pilates)
(194, 7, 'PRESENTE'), (194, 8, 'PRESENTE'), (194, 9, 'PRESENTE'), (194, 10, 'FALTA'),
-- Agendamento 195 (17/09 11:00 - Quarta - RPG)
(195, 8, 'PRESENTE'), (195, 9, 'PRESENTE'), (195, 10, 'PRESENTE'), (195, 1, 'FALTA'),
-- Agendamento 196 (17/09 14:00 - Quarta - Fisioterapia)
(196, 9, 'PRESENTE'), (196, 10, 'PRESENTE'), (196, 1, 'PRESENTE'), (196, 2, 'FALTA'),
-- Agendamento 197 (17/09 16:00 - Quarta - Pilates)
(197, 10, 'PRESENTE'), (197, 1, 'PRESENTE'), (197, 2, 'PRESENTE'), (197, 3, 'FALTA'),
-- Agendamento 198 (18/09 09:00 - Quinta - Pilates)
(198, 1, 'PRESENTE'), (198, 2, 'PRESENTE'), (198, 3, 'PRESENTE'), (198, 4, 'FALTA'),
-- Agendamento 199 (18/09 11:00 - Quinta - RPG)
(199, 2, 'PRESENTE'), (199, 3, 'PRESENTE'), (199, 4, 'PRESENTE'), (199, 5, 'FALTA'),
-- Agendamento 200 (18/09 15:00 - Quinta - Pilates)
(200, 3, 'PRESENTE'), (200, 4, 'PRESENTE'), (200, 5, 'PRESENTE'), (200, 6, 'FALTA'),
-- Agendamento 201 (18/09 17:00 - Quinta - Fisioterapia)
(201, 4, 'PRESENTE'), (201, 5, 'PRESENTE'), (201, 6, 'PRESENTE'), (201, 7, 'FALTA'),
-- Agendamento 202 (19/09 09:00 - Sexta - RPG)
(202, 5, 'PRESENTE'), (202, 6, 'PRESENTE'), (202, 7, 'PRESENTE'), (202, 8, 'FALTA'),
-- Agendamento 203 (19/09 11:00 - Sexta - Pilates)
(203, 6, 'PRESENTE'), (203, 7, 'PRESENTE'), (203, 8, 'PRESENTE'), (203, 9, 'FALTA'),
-- Agendamento 204 (19/09 13:00 - Sexta - Fisioterapia)
(204, 7, 'PRESENTE'), (204, 8, 'PRESENTE'), (204, 9, 'PRESENTE'), (204, 10, 'FALTA'),
-- Agendamento 205 (19/09 15:00 - Sexta - Pilates)
(205, 8, 'PRESENTE'), (205, 9, 'PRESENTE'), (205, 10, 'PRESENTE'), (205, 1, 'FALTA'),
-- Agendamento 206 (22/09 09:00 - Segunda - Pilates)
(206, 9, 'PRESENTE'), (206, 10, 'PRESENTE'), (206, 1, 'PRESENTE'), (206, 2, 'FALTA'),
-- Agendamento 207 (22/09 11:00 - Segunda - RPG)
(207, 10, 'PRESENTE'), (207, 1, 'PRESENTE'), (207, 2, 'PRESENTE'), (207, 3, 'FALTA'),
-- Agendamento 208 (22/09 15:00 - Segunda - Fisioterapia)
(208, 1, 'PRESENTE'), (208, 2, 'PRESENTE'), (208, 3, 'PRESENTE'), (208, 4, 'FALTA'),
-- Agendamento 209 (22/09 17:00 - Segunda - Pilates)
(209, 2, 'PRESENTE'), (209, 3, 'PRESENTE'), (209, 4, 'PRESENTE'), (209, 5, 'FALTA'),
-- Agendamento 210 (23/09 09:00 - Terça - RPG)
(210, 3, 'PRESENTE'), (210, 4, 'PRESENTE'), (210, 5, 'PRESENTE'), (210, 6, 'FALTA'),
-- Agendamento 211 (23/09 11:00 - Terça - Pilates)
(211, 4, 'PRESENTE'), (211, 5, 'PRESENTE'), (211, 6, 'PRESENTE'), (211, 7, 'FALTA'),
-- Agendamento 212 (23/09 13:00 - Terça - Fisioterapia)
(212, 5, 'PRESENTE'), (212, 6, 'PRESENTE'), (212, 7, 'PRESENTE'), (212, 8, 'FALTA'),
-- Agendamento 213 (23/09 15:00 - Terça - Pilates)
(213, 6, 'PRESENTE'), (213, 7, 'PRESENTE'), (213, 8, 'PRESENTE'), (213, 9, 'FALTA'),
-- Agendamento 214 (24/09 09:00 - Quarta - Pilates)
(214, 7, 'PRESENTE'), (214, 8, 'PRESENTE'), (214, 9, 'PRESENTE'), (214, 10, 'FALTA'),
-- Agendamento 215 (24/09 11:00 - Quarta - RPG)
(215, 8, 'PRESENTE'), (215, 9, 'PRESENTE'), (215, 10, 'PRESENTE'), (215, 1, 'FALTA'),
-- Agendamento 216 (24/09 14:00 - Quarta - Fisioterapia)
(216, 9, 'PRESENTE'), (216, 10, 'PRESENTE'), (216, 1, 'PRESENTE'), (216, 2, 'FALTA'),
-- Agendamento 217 (24/09 16:00 - Quarta - Pilates)
(217, 10, 'PRESENTE'), (217, 1, 'PRESENTE'), (217, 2, 'PRESENTE'), (217, 3, 'FALTA'),
-- Agendamento 218 (25/09 09:00 - Quinta - Pilates)
(218, 1, 'PRESENTE'), (218, 2, 'PRESENTE'), (218, 3, 'PRESENTE'), (218, 4, 'FALTA'),
-- Agendamento 219 (25/09 11:00 - Quinta - RPG)
(219, 2, 'PRESENTE'), (219, 3, 'PRESENTE'), (219, 4, 'PRESENTE'), (219, 5, 'FALTA'),
-- Agendamento 220 (25/09 15:00 - Quinta - Pilates)
(220, 3, 'PRESENTE'), (220, 4, 'PRESENTE'), (220, 5, 'PRESENTE'), (220, 6, 'FALTA'),
-- Agendamento 221 (25/09 17:00 - Quinta - Fisioterapia)
(221, 4, 'PRESENTE'), (221, 5, 'PRESENTE'), (221, 6, 'PRESENTE'), (221, 7, 'FALTA'),
-- Agendamento 222 (26/09 09:00 - Sexta - RPG)
(222, 5, 'PRESENTE'), (222, 6, 'PRESENTE'), (222, 7, 'PRESENTE'), (222, 8, 'FALTA'),
-- Agendamento 223 (26/09 11:00 - Sexta - Pilates)
(223, 6, 'PRESENTE'), (223, 7, 'PRESENTE'), (223, 8, 'PRESENTE'), (223, 9, 'FALTA'),
-- Agendamento 224 (26/09 13:00 - Sexta - Fisioterapia)
(224, 7, 'PRESENTE'), (224, 8, 'PRESENTE'), (224, 9, 'PRESENTE'), (224, 10, 'FALTA'),
-- Agendamento 225 (26/09 15:00 - Sexta - Pilates)
(225, 8, 'PRESENTE'), (225, 9, 'PRESENTE'), (225, 10, 'PRESENTE'), (225, 1, 'FALTA');

-- Agendamentos de outubro do Guilherme (IDs 226-317) - PASSADOS
INSERT IGNORE INTO agendamento_aluno (agendamento_id, aluno_id, status_presenca) VALUES
-- Agendamento 226 (01/10 09:00 - Quarta - Pilates)
(226, 9, 'PRESENTE'), (226, 10, 'PRESENTE'), (226, 1, 'PRESENTE'), (226, 2, 'FALTA'),
-- Agendamento 227 (01/10 11:00 - Quarta - RPG)
(227, 10, 'PRESENTE'), (227, 1, 'PRESENTE'), (227, 2, 'PRESENTE'), (227, 3, 'FALTA'),
-- Agendamento 228 (01/10 14:00 - Quarta - Fisioterapia)
(228, 1, 'PRESENTE'), (228, 2, 'PRESENTE'), (228, 3, 'PRESENTE'), (228, 4, 'FALTA'),
-- Agendamento 229 (01/10 16:00 - Quarta - Pilates)
(229, 2, 'PRESENTE'), (229, 3, 'PRESENTE'), (229, 4, 'PRESENTE'), (229, 5, 'FALTA'),
-- Agendamento 230 (02/10 09:00 - Quinta - Pilates)
(230, 3, 'PRESENTE'), (230, 4, 'PRESENTE'), (230, 5, 'PRESENTE'), (230, 6, 'FALTA'),
-- Agendamento 231 (02/10 11:00 - Quinta - RPG)
(231, 4, 'PRESENTE'), (231, 5, 'PRESENTE'), (231, 6, 'PRESENTE'), (231, 7, 'FALTA'),
-- Agendamento 232 (02/10 15:00 - Quinta - Pilates)
(232, 5, 'PRESENTE'), (232, 6, 'PRESENTE'), (232, 7, 'PRESENTE'), (232, 8, 'FALTA'),
-- Agendamento 233 (02/10 17:00 - Quinta - Fisioterapia)
(233, 6, 'PRESENTE'), (233, 7, 'PRESENTE'), (233, 8, 'PRESENTE'), (233, 9, 'FALTA'),
-- Agendamento 234 (03/10 09:00 - Sexta - RPG)
(234, 7, 'PRESENTE'), (234, 8, 'PRESENTE'), (234, 9, 'PRESENTE'), (234, 10, 'FALTA'),
-- Agendamento 235 (03/10 11:00 - Sexta - Pilates)
(235, 8, 'PRESENTE'), (235, 9, 'PRESENTE'), (235, 10, 'PRESENTE'), (235, 1, 'FALTA'),
-- Agendamento 236 (03/10 13:00 - Sexta - Fisioterapia)
(236, 9, 'PRESENTE'), (236, 10, 'PRESENTE'), (236, 1, 'PRESENTE'), (236, 2, 'FALTA'),
-- Agendamento 237 (03/10 15:00 - Sexta - Pilates)
(237, 10, 'PRESENTE'), (237, 1, 'PRESENTE'), (237, 2, 'PRESENTE'), (237, 3, 'FALTA'),
-- Agendamento 238 (06/10 09:00 - Segunda - Pilates)
(238, 1, 'PRESENTE'), (238, 2, 'PRESENTE'), (238, 3, 'PRESENTE'), (238, 4, 'FALTA'),
-- Agendamento 239 (06/10 11:00 - Segunda - RPG)
(239, 2, 'PRESENTE'), (239, 3, 'PRESENTE'), (239, 4, 'PRESENTE'), (239, 5, 'FALTA'),
-- Agendamento 240 (06/10 15:00 - Segunda - Fisioterapia)
(240, 3, 'PRESENTE'), (240, 4, 'PRESENTE'), (240, 5, 'PRESENTE'), (240, 6, 'FALTA'),
-- Agendamento 241 (06/10 17:00 - Segunda - Pilates)
(241, 4, 'PRESENTE'), (241, 5, 'PRESENTE'), (241, 6, 'PRESENTE'), (241, 7, 'FALTA'),
-- Agendamento 242 (07/10 09:00 - Terça - RPG)
(242, 5, 'PRESENTE'), (242, 6, 'PRESENTE'), (242, 7, 'PRESENTE'), (242, 8, 'FALTA'),
-- Agendamento 243 (07/10 11:00 - Terça - Pilates)
(243, 6, 'PRESENTE'), (243, 7, 'PRESENTE'), (243, 8, 'PRESENTE'), (243, 9, 'FALTA'),
-- Agendamento 244 (07/10 13:00 - Terça - Fisioterapia)
(244, 7, 'PRESENTE'), (244, 8, 'PRESENTE'), (244, 9, 'PRESENTE'), (244, 10, 'FALTA'),
-- Agendamento 245 (07/10 15:00 - Terça - Pilates)
(245, 8, 'PRESENTE'), (245, 9, 'PRESENTE'), (245, 10, 'PRESENTE'), (245, 1, 'FALTA'),
-- Agendamento 246 (08/10 09:00 - Quarta - Pilates)
(246, 9, 'PRESENTE'), (246, 10, 'PRESENTE'), (246, 1, 'PRESENTE'), (246, 2, 'FALTA'),
-- Agendamento 247 (08/10 11:00 - Quarta - RPG)
(247, 10, 'PRESENTE'), (247, 1, 'PRESENTE'), (247, 2, 'PRESENTE'), (247, 3, 'FALTA'),
-- Agendamento 248 (08/10 14:00 - Quarta - Fisioterapia)
(248, 1, 'PRESENTE'), (248, 2, 'PRESENTE'), (248, 3, 'PRESENTE'), (248, 4, 'FALTA'),
-- Agendamento 249 (08/10 16:00 - Quarta - Pilates)
(249, 2, 'PRESENTE'), (249, 3, 'PRESENTE'), (249, 4, 'PRESENTE'), (249, 5, 'FALTA'),
-- Agendamento 250 (09/10 09:00 - Quinta - Pilates)
(250, 3, 'PRESENTE'), (250, 4, 'PRESENTE'), (250, 5, 'PRESENTE'), (250, 6, 'FALTA'),
-- Agendamento 251 (09/10 11:00 - Quinta - RPG)
(251, 4, 'PRESENTE'), (251, 5, 'PRESENTE'), (251, 6, 'PRESENTE'), (251, 7, 'FALTA'),
-- Agendamento 252 (09/10 15:00 - Quinta - Pilates)
(252, 5, 'PRESENTE'), (252, 6, 'PRESENTE'), (252, 7, 'PRESENTE'), (252, 8, 'FALTA'),
-- Agendamento 253 (09/10 17:00 - Quinta - Fisioterapia)
(253, 6, 'PRESENTE'), (253, 7, 'PRESENTE'), (253, 8, 'PRESENTE'), (253, 9, 'FALTA'),
-- Agendamento 254 (10/10 09:00 - Sexta - RPG)
(254, 7, 'PRESENTE'), (254, 8, 'PRESENTE'), (254, 9, 'PRESENTE'), (254, 10, 'FALTA'),
-- Agendamento 255 (10/10 11:00 - Sexta - Pilates)
(255, 8, 'PRESENTE'), (255, 9, 'PRESENTE'), (255, 10, 'PRESENTE'), (255, 1, 'FALTA'),
-- Agendamento 256 (10/10 13:00 - Sexta - Fisioterapia)
(256, 9, 'PRESENTE'), (256, 10, 'PRESENTE'), (256, 1, 'PRESENTE'), (256, 2, 'FALTA'),
-- Agendamento 257 (10/10 15:00 - Sexta - Pilates)
(257, 10, 'PRESENTE'), (257, 1, 'PRESENTE'), (257, 2, 'PRESENTE'), (257, 3, 'FALTA'),
-- Agendamento 258 (13/10 09:00 - Segunda - Pilates)
(258, 1, 'PRESENTE'), (258, 2, 'PRESENTE'), (258, 3, 'PRESENTE'), (258, 4, 'FALTA'),
-- Agendamento 259 (13/10 11:00 - Segunda - RPG)
(259, 2, 'PRESENTE'), (259, 3, 'PRESENTE'), (259, 4, 'PRESENTE'), (259, 5, 'FALTA'),
-- Agendamento 260 (13/10 15:00 - Segunda - Fisioterapia)
(260, 3, 'PRESENTE'), (260, 4, 'PRESENTE'), (260, 5, 'PRESENTE'), (260, 6, 'FALTA'),
-- Agendamento 261 (13/10 17:00 - Segunda - Pilates)
(261, 4, 'PRESENTE'), (261, 5, 'PRESENTE'), (261, 6, 'PRESENTE'), (261, 7, 'FALTA'),
-- Agendamento 262 (14/10 09:00 - Terça - RPG)
(262, 5, 'PRESENTE'), (262, 6, 'PRESENTE'), (262, 7, 'PRESENTE'), (262, 8, 'FALTA'),
-- Agendamento 263 (14/10 11:00 - Terça - Pilates)
(263, 6, 'PRESENTE'), (263, 7, 'PRESENTE'), (263, 8, 'PRESENTE'), (263, 9, 'FALTA'),
-- Agendamento 264 (14/10 13:00 - Terça - Fisioterapia)
(264, 7, 'PRESENTE'), (264, 8, 'PRESENTE'), (264, 9, 'PRESENTE'), (264, 10, 'FALTA'),
-- Agendamento 265 (14/10 15:00 - Terça - Pilates)
(265, 8, 'PRESENTE'), (265, 9, 'PRESENTE'), (265, 10, 'PRESENTE'), (265, 1, 'FALTA'),
-- Agendamento 266 (15/10 09:00 - Quarta - Pilates)
(266, 9, 'PRESENTE'), (266, 10, 'PRESENTE'), (266, 1, 'PRESENTE'), (266, 2, 'FALTA'),
-- Agendamento 267 (15/10 11:00 - Quarta - RPG)
(267, 10, 'PRESENTE'), (267, 1, 'PRESENTE'), (267, 2, 'PRESENTE'), (267, 3, 'FALTA'),
-- Agendamento 268 (15/10 14:00 - Quarta - Fisioterapia)
(268, 1, 'PRESENTE'), (268, 2, 'PRESENTE'), (268, 3, 'PRESENTE'), (268, 4, 'FALTA'),
-- Agendamento 269 (15/10 16:00 - Quarta - Pilates)
(269, 2, 'PRESENTE'), (269, 3, 'PRESENTE'), (269, 4, 'PRESENTE'), (269, 5, 'FALTA'),
-- Agendamento 270 (16/10 09:00 - Quinta - Pilates)
(270, 3, 'PRESENTE'), (270, 4, 'PRESENTE'), (270, 5, 'PRESENTE'), (270, 6, 'FALTA'),
-- Agendamento 271 (16/10 11:00 - Quinta - RPG)
(271, 4, 'PRESENTE'), (271, 5, 'PRESENTE'), (271, 6, 'PRESENTE'), (271, 7, 'FALTA'),
-- Agendamento 272 (16/10 15:00 - Quinta - Pilates)
(272, 5, 'PRESENTE'), (272, 6, 'PRESENTE'), (272, 7, 'PRESENTE'), (272, 8, 'FALTA'),
-- Agendamento 273 (16/10 17:00 - Quinta - Fisioterapia)
(273, 6, 'PRESENTE'), (273, 7, 'PRESENTE'), (273, 8, 'PRESENTE'), (273, 9, 'FALTA'),
-- Agendamento 274 (17/10 09:00 - Sexta - RPG)
(274, 7, 'PRESENTE'), (274, 8, 'PRESENTE'), (274, 9, 'PRESENTE'), (274, 10, 'FALTA'),
-- Agendamento 275 (17/10 11:00 - Sexta - Pilates)
(275, 8, 'PRESENTE'), (275, 9, 'PRESENTE'), (275, 10, 'PRESENTE'), (275, 1, 'FALTA'),
-- Agendamento 276 (17/10 13:00 - Sexta - Fisioterapia)
(276, 9, 'PRESENTE'), (276, 10, 'PRESENTE'), (276, 1, 'PRESENTE'), (276, 2, 'FALTA'),
-- Agendamento 277 (17/10 15:00 - Sexta - Pilates)
(277, 10, 'PRESENTE'), (277, 1, 'PRESENTE'), (277, 2, 'PRESENTE'), (277, 3, 'FALTA'),
-- Agendamento 278 (20/10 09:00 - Segunda - Pilates)
(278, 1, 'PRESENTE'), (278, 2, 'PRESENTE'), (278, 3, 'PRESENTE'), (278, 4, 'FALTA'),
-- Agendamento 279 (20/10 11:00 - Segunda - RPG)
(279, 2, 'PRESENTE'), (279, 3, 'PRESENTE'), (279, 4, 'PRESENTE'), (279, 5, 'FALTA'),
-- Agendamento 280 (20/10 15:00 - Segunda - Fisioterapia)
(280, 3, 'PRESENTE'), (280, 4, 'PRESENTE'), (280, 5, 'PRESENTE'), (280, 6, 'FALTA'),
-- Agendamento 281 (20/10 17:00 - Segunda - Pilates)
(281, 4, 'PRESENTE'), (281, 5, 'PRESENTE'), (281, 6, 'PRESENTE'), (281, 7, 'FALTA'),
-- Agendamento 282 (21/10 09:00 - Terça - RPG)
(282, 5, 'PRESENTE'), (282, 6, 'PRESENTE'), (282, 7, 'PRESENTE'), (282, 8, 'FALTA'),
-- Agendamento 283 (21/10 11:00 - Terça - Pilates)
(283, 6, 'PRESENTE'), (283, 7, 'PRESENTE'), (283, 8, 'PRESENTE'), (283, 9, 'FALTA'),
-- Agendamento 284 (21/10 13:00 - Terça - Fisioterapia)
(284, 7, 'PRESENTE'), (284, 8, 'PRESENTE'), (284, 9, 'PRESENTE'), (284, 10, 'FALTA'),
-- Agendamento 285 (21/10 15:00 - Terça - Pilates)
(285, 8, 'PRESENTE'), (285, 9, 'PRESENTE'), (285, 10, 'PRESENTE'), (285, 1, 'FALTA'),
-- Agendamento 286 (22/10 09:00 - Quarta - Pilates)
(286, 9, 'PRESENTE'), (286, 10, 'PRESENTE'), (286, 1, 'PRESENTE'), (286, 2, 'FALTA'),
-- Agendamento 287 (22/10 11:00 - Quarta - RPG)
(287, 10, 'PRESENTE'), (287, 1, 'PRESENTE'), (287, 2, 'PRESENTE'), (287, 3, 'FALTA'),
-- Agendamento 288 (22/10 14:00 - Quarta - Fisioterapia)
(288, 1, 'PRESENTE'), (288, 2, 'PRESENTE'), (288, 3, 'PRESENTE'), (288, 4, 'FALTA'),
-- Agendamento 289 (22/10 16:00 - Quarta - Pilates)
(289, 2, 'PRESENTE'), (289, 3, 'PRESENTE'), (289, 4, 'PRESENTE'), (289, 5, 'FALTA'),
-- Agendamento 290 (23/10 09:00 - Quinta - Pilates)
(290, 3, 'PRESENTE'), (290, 4, 'PRESENTE'), (290, 5, 'PRESENTE'), (290, 6, 'FALTA'),
-- Agendamento 291 (23/10 11:00 - Quinta - RPG)
(291, 4, 'PRESENTE'), (291, 5, 'PRESENTE'), (291, 6, 'PRESENTE'), (291, 7, 'FALTA'),
-- Agendamento 292 (23/10 15:00 - Quinta - Pilates)
(292, 5, 'PRESENTE'), (292, 6, 'PRESENTE'), (292, 7, 'PRESENTE'), (292, 8, 'FALTA'),
-- Agendamento 293 (23/10 17:00 - Quinta - Fisioterapia)
(293, 6, 'PRESENTE'), (293, 7, 'PRESENTE'), (293, 8, 'PRESENTE'), (293, 9, 'FALTA'),
-- Agendamento 294 (24/10 09:00 - Sexta - RPG)
(294, 7, 'PRESENTE'), (294, 8, 'PRESENTE'), (294, 9, 'PRESENTE'), (294, 10, 'FALTA'),
-- Agendamento 295 (24/10 11:00 - Sexta - Pilates)
(295, 8, 'PRESENTE'), (295, 9, 'PRESENTE'), (295, 10, 'PRESENTE'), (295, 1, 'FALTA'),
-- Agendamento 296 (24/10 13:00 - Sexta - Fisioterapia)
(296, 9, 'PRESENTE'), (296, 10, 'PRESENTE'), (296, 1, 'PRESENTE'), (296, 2, 'FALTA'),
-- Agendamento 297 (24/10 15:00 - Sexta - Pilates)
(297, 10, 'PRESENTE'), (297, 1, 'PRESENTE'), (297, 2, 'PRESENTE'), (297, 3, 'FALTA'),
-- Agendamento 298 (27/10 09:00 - Segunda - Pilates)
(298, 1, 'PRESENTE'), (298, 2, 'PRESENTE'), (298, 3, 'PRESENTE'), (298, 4, 'FALTA'),
-- Agendamento 299 (27/10 11:00 - Segunda - RPG)
(299, 2, 'PRESENTE'), (299, 3, 'PRESENTE'), (299, 4, 'PRESENTE'), (299, 5, 'FALTA'),
-- Agendamento 300 (27/10 15:00 - Segunda - Fisioterapia)
(300, 3, 'PRESENTE'), (300, 4, 'PRESENTE'), (300, 5, 'PRESENTE'), (300, 6, 'FALTA'),
-- Agendamento 301 (27/10 17:00 - Segunda - Pilates)
(301, 4, 'PRESENTE'), (301, 5, 'PRESENTE'), (301, 6, 'PRESENTE'), (301, 7, 'FALTA'),
-- Agendamento 302 (28/10 09:00 - Terça - RPG)
(302, 5, 'PRESENTE'), (302, 6, 'PRESENTE'), (302, 7, 'PRESENTE'), (302, 8, 'FALTA'),
-- Agendamento 303 (28/10 11:00 - Terça - Pilates)
(303, 6, 'PRESENTE'), (303, 7, 'PRESENTE'), (303, 8, 'PRESENTE'), (303, 9, 'FALTA'),
-- Agendamento 304 (28/10 13:00 - Terça - Fisioterapia)
(304, 7, 'PRESENTE'), (304, 8, 'PRESENTE'), (304, 9, 'PRESENTE'), (304, 10, 'FALTA'),
-- Agendamento 305 (28/10 15:00 - Terça - Pilates)
(305, 8, 'PRESENTE'), (305, 9, 'PRESENTE'), (305, 10, 'PRESENTE'), (305, 1, 'FALTA'),
-- Agendamento 306 (29/10 09:00 - Quarta - Pilates)
(306, 9, 'PRESENTE'), (306, 10, 'PRESENTE'), (306, 1, 'PRESENTE'), (306, 2, 'FALTA'),
-- Agendamento 307 (29/10 11:00 - Quarta - RPG)
(307, 10, 'PRESENTE'), (307, 1, 'PRESENTE'), (307, 2, 'PRESENTE'), (307, 3, 'FALTA'),
-- Agendamento 308 (29/10 14:00 - Quarta - Fisioterapia)
(308, 1, 'PRESENTE'), (308, 2, 'PRESENTE'), (308, 3, 'PRESENTE'), (308, 4, 'FALTA'),
-- Agendamento 309 (29/10 16:00 - Quarta - Pilates)
(309, 2, 'PRESENTE'), (309, 3, 'PRESENTE'), (309, 4, 'PRESENTE'), (309, 5, 'FALTA'),
-- Agendamento 310 (30/10 09:00 - Quinta - Pilates)
(310, 3, 'PRESENTE'), (310, 4, 'PRESENTE'), (310, 5, 'PRESENTE'), (310, 6, 'FALTA'),
-- Agendamento 311 (30/10 11:00 - Quinta - RPG)
(311, 4, 'PRESENTE'), (311, 5, 'PRESENTE'), (311, 6, 'PRESENTE'), (311, 7, 'FALTA'),
-- Agendamento 312 (30/10 15:00 - Quinta - Pilates)
(312, 5, 'PRESENTE'), (312, 6, 'PRESENTE'), (312, 7, 'PRESENTE'), (312, 8, 'FALTA'),
-- Agendamento 313 (30/10 17:00 - Quinta - Fisioterapia)
(313, 6, 'PRESENTE'), (313, 7, 'PRESENTE'), (313, 8, 'PRESENTE'), (313, 9, 'FALTA'),
-- Agendamento 314 (31/10 09:00 - Sexta - RPG)
(314, 7, 'PRESENTE'), (314, 8, 'PRESENTE'), (314, 9, 'PRESENTE'), (314, 10, 'FALTA'),
-- Agendamento 315 (31/10 11:00 - Sexta - Pilates)
(315, 8, 'PRESENTE'), (315, 9, 'PRESENTE'), (315, 10, 'PRESENTE'), (315, 1, 'FALTA'),
-- Agendamento 316 (31/10 13:00 - Sexta - Fisioterapia)
(316, 9, 'PRESENTE'), (316, 10, 'PRESENTE'), (316, 1, 'PRESENTE'), (316, 2, 'FALTA'),
-- Agendamento 317 (31/10 15:00 - Sexta - Pilates)
(317, 10, 'PRESENTE'), (317, 1, 'PRESENTE'), (317, 2, 'PRESENTE'), (317, 3, 'FALTA');

-- Agendamentos de novembro do Guilherme (IDs 318-393)
-- Agendamentos até 14/11/2025 são PASSADOS, após são FUTUROS
INSERT IGNORE INTO agendamento_aluno (agendamento_id, aluno_id, status_presenca) VALUES
-- Agendamento 318 (03/11 09:00 - Segunda - Pilates) - PASSADO
(318, 1, 'PRESENTE'), (318, 2, 'PRESENTE'), (318, 3, 'PRESENTE'), (318, 4, 'FALTA'),
-- Agendamento 319 (03/11 11:00 - Segunda - RPG) - PASSADO
(319, 2, 'PRESENTE'), (319, 3, 'PRESENTE'), (319, 4, 'PRESENTE'), (319, 5, 'FALTA'),
-- Agendamento 320 (03/11 15:00 - Segunda - Fisioterapia) - PASSADO
(320, 3, 'PRESENTE'), (320, 4, 'PRESENTE'), (320, 5, 'PRESENTE'), (320, 6, 'FALTA'),
-- Agendamento 321 (03/11 17:00 - Segunda - Pilates) - PASSADO
(321, 4, 'PRESENTE'), (321, 5, 'PRESENTE'), (321, 6, 'PRESENTE'), (321, 7, 'FALTA'),
-- Agendamento 322 (04/11 09:00 - Terça - RPG) - PASSADO
(322, 5, 'PRESENTE'), (322, 6, 'PRESENTE'), (322, 7, 'PRESENTE'), (322, 8, 'FALTA'),
-- Agendamento 323 (04/11 11:00 - Terça - Pilates) - PASSADO
(323, 6, 'PRESENTE'), (323, 7, 'PRESENTE'), (323, 8, 'PRESENTE'), (323, 9, 'FALTA'),
-- Agendamento 324 (04/11 13:00 - Terça - Fisioterapia) - PASSADO
(324, 7, 'PRESENTE'), (324, 8, 'PRESENTE'), (324, 9, 'PRESENTE'), (324, 10, 'FALTA'),
-- Agendamento 325 (04/11 15:00 - Terça - Pilates) - PASSADO
(325, 8, 'PRESENTE'), (325, 9, 'PRESENTE'), (325, 10, 'PRESENTE'), (325, 1, 'FALTA'),
-- Agendamento 326 (05/11 09:00 - Quarta - Pilates) - PASSADO
(326, 9, 'PRESENTE'), (326, 10, 'PRESENTE'), (326, 1, 'PRESENTE'), (326, 2, 'FALTA'),
-- Agendamento 327 (05/11 11:00 - Quarta - RPG) - PASSADO
(327, 10, 'PRESENTE'), (327, 1, 'PRESENTE'), (327, 2, 'PRESENTE'), (327, 3, 'FALTA'),
-- Agendamento 328 (05/11 14:00 - Quarta - Fisioterapia) - PASSADO
(328, 1, 'PRESENTE'), (328, 2, 'PRESENTE'), (328, 3, 'PRESENTE'), (328, 4, 'FALTA'),
-- Agendamento 329 (05/11 16:00 - Quarta - Pilates) - PASSADO
(329, 2, 'PRESENTE'), (329, 3, 'PRESENTE'), (329, 4, 'PRESENTE'), (329, 5, 'FALTA'),
-- Agendamento 330 (06/11 09:00 - Quinta - Pilates) - PASSADO
(330, 3, 'PRESENTE'), (330, 4, 'PRESENTE'), (330, 5, 'PRESENTE'), (330, 6, 'FALTA'),
-- Agendamento 331 (06/11 11:00 - Quinta - RPG) - PASSADO
(331, 4, 'PRESENTE'), (331, 5, 'PRESENTE'), (331, 6, 'PRESENTE'), (331, 7, 'FALTA'),
-- Agendamento 332 (06/11 15:00 - Quinta - Pilates) - PASSADO
(332, 5, 'PRESENTE'), (332, 6, 'PRESENTE'), (332, 7, 'PRESENTE'), (332, 8, 'FALTA'),
-- Agendamento 333 (06/11 17:00 - Quinta - Fisioterapia) - PASSADO
(333, 6, 'PRESENTE'), (333, 7, 'PRESENTE'), (333, 8, 'PRESENTE'), (333, 9, 'FALTA'),
-- Agendamento 334 (07/11 09:00 - Sexta - RPG) - PASSADO
(334, 7, 'PRESENTE'), (334, 8, 'PRESENTE'), (334, 9, 'PRESENTE'), (334, 10, 'FALTA'),
-- Agendamento 335 (07/11 11:00 - Sexta - Pilates) - PASSADO
(335, 8, 'PRESENTE'), (335, 9, 'PRESENTE'), (335, 10, 'PRESENTE'), (335, 1, 'FALTA'),
-- Agendamento 336 (07/11 13:00 - Sexta - Fisioterapia) - PASSADO
(336, 9, 'PRESENTE'), (336, 10, 'PRESENTE'), (336, 1, 'PRESENTE'), (336, 2, 'FALTA'),
-- Agendamento 337 (07/11 15:00 - Sexta - Pilates) - PASSADO
(337, 10, 'PRESENTE'), (337, 1, 'PRESENTE'), (337, 2, 'PRESENTE'), (337, 3, 'FALTA'),
-- Agendamento 338 (10/11 09:00 - Segunda - Pilates) - PASSADO
(338, 1, 'PRESENTE'), (338, 2, 'PRESENTE'), (338, 3, 'PRESENTE'), (338, 4, 'FALTA'),
-- Agendamento 339 (10/11 11:00 - Segunda - RPG) - PASSADO
(339, 2, 'PRESENTE'), (339, 3, 'PRESENTE'), (339, 4, 'PRESENTE'), (339, 5, 'FALTA'),
-- Agendamento 340 (10/11 15:00 - Segunda - Fisioterapia) - PASSADO
(340, 3, 'PRESENTE'), (340, 4, 'PRESENTE'), (340, 5, 'PRESENTE'), (340, 6, 'FALTA'),
-- Agendamento 341 (10/11 17:00 - Segunda - Pilates) - PASSADO
(341, 4, 'PRESENTE'), (341, 5, 'PRESENTE'), (341, 6, 'PRESENTE'), (341, 7, 'FALTA'),
-- Agendamento 342 (11/11 09:00 - Terça - RPG) - PASSADO
(342, 5, 'PRESENTE'), (342, 6, 'PRESENTE'), (342, 7, 'PRESENTE'), (342, 8, 'FALTA'),
-- Agendamento 343 (11/11 11:00 - Terça - Pilates) - PASSADO
(343, 6, 'PRESENTE'), (343, 7, 'PRESENTE'), (343, 8, 'PRESENTE'), (343, 9, 'FALTA'),
-- Agendamento 344 (11/11 13:00 - Terça - Fisioterapia) - PASSADO
(344, 7, 'PRESENTE'), (344, 8, 'PRESENTE'), (344, 9, 'PRESENTE'), (344, 10, 'FALTA'),
-- Agendamento 345 (11/11 15:00 - Terça - Pilates) - PASSADO
(345, 8, 'PRESENTE'), (345, 9, 'PRESENTE'), (345, 10, 'PRESENTE'), (345, 1, 'FALTA'),
-- Agendamento 346 (12/11 09:00 - Quarta - Pilates) - PASSADO
(346, 9, 'PRESENTE'), (346, 10, 'PRESENTE'), (346, 1, 'PRESENTE'), (346, 2, 'FALTA'),
-- Agendamento 347 (12/11 11:00 - Quarta - RPG) - PASSADO
(347, 10, 'PRESENTE'), (347, 1, 'PRESENTE'), (347, 2, 'PRESENTE'), (347, 3, 'FALTA'),
-- Agendamento 348 (12/11 14:00 - Quarta - Fisioterapia) - PASSADO
(348, 1, 'PRESENTE'), (348, 2, 'PRESENTE'), (348, 3, 'PRESENTE'), (348, 4, 'FALTA'),
-- Agendamento 349 (12/11 16:00 - Quarta - Pilates) - PASSADO
(349, 2, 'PRESENTE'), (349, 3, 'PRESENTE'), (349, 4, 'PRESENTE'), (349, 5, 'FALTA'),
-- Agendamento 350 (13/11 09:00 - Quinta - Pilates) - PASSADO
(350, 3, 'PRESENTE'), (350, 4, 'PRESENTE'), (350, 5, 'PRESENTE'), (350, 6, 'FALTA'),
-- Agendamento 351 (13/11 11:00 - Quinta - RPG) - PASSADO
(351, 4, 'PRESENTE'), (351, 5, 'PRESENTE'), (351, 6, 'PRESENTE'), (351, 7, 'FALTA'),
-- Agendamento 352 (13/11 15:00 - Quinta - Pilates) - PASSADO
(352, 5, 'PRESENTE'), (352, 6, 'PRESENTE'), (352, 7, 'PRESENTE'), (352, 8, 'FALTA'),
-- Agendamento 353 (13/11 17:00 - Quinta - Fisioterapia) - PASSADO
(353, 6, 'PRESENTE'), (353, 7, 'PRESENTE'), (353, 8, 'PRESENTE'), (353, 9, 'FALTA'),
-- Agendamento 354 (14/11 09:00 - Sexta - RPG) - PASSADO
(354, 7, 'PRESENTE'), (354, 8, 'PRESENTE'), (354, 9, 'PRESENTE'), (354, 10, 'FALTA'),
-- Agendamento 355 (14/11 11:00 - Sexta - Pilates) - PASSADO
(355, 8, 'PRESENTE'), (355, 9, 'PRESENTE'), (355, 10, 'PRESENTE'), (355, 1, 'FALTA'),
-- Agendamento 356 (14/11 13:00 - Sexta - Fisioterapia) - PASSADO
(356, 9, 'PRESENTE'), (356, 10, 'PRESENTE'), (356, 1, 'PRESENTE'), (356, 2, 'FALTA'),
-- Agendamento 357 (14/11 15:00 - Sexta - Pilates) - PASSADO
(357, 10, 'PRESENTE'), (357, 1, 'PRESENTE'), (357, 2, 'PRESENTE'), (357, 3, 'FALTA'),
-- Agendamento 358 (17/11 09:00 - Segunda - Pilates) - FUTURO
(358, 1, 'PENDENTE'), (358, 2, 'PENDENTE'), (358, 3, 'PENDENTE'), (358, 4, 'PENDENTE'),
-- Agendamento 359 (17/11 11:00 - Segunda - RPG) - FUTURO
(359, 2, 'PENDENTE'), (359, 3, 'PENDENTE'), (359, 4, 'PENDENTE'), (359, 5, 'PENDENTE'),
-- Agendamento 360 (17/11 15:00 - Segunda - Fisioterapia) - FUTURO
(360, 3, 'PENDENTE'), (360, 4, 'PENDENTE'), (360, 5, 'PENDENTE'), (360, 6, 'PENDENTE'),
-- Agendamento 361 (17/11 17:00 - Segunda - Pilates) - FUTURO
(361, 4, 'PENDENTE'), (361, 5, 'PENDENTE'), (361, 6, 'PENDENTE'), (361, 7, 'PENDENTE'),
-- Agendamento 362 (18/11 09:00 - Terça - RPG) - FUTURO
(362, 5, 'PENDENTE'), (362, 6, 'PENDENTE'), (362, 7, 'PENDENTE'), (362, 8, 'PENDENTE'),
-- Agendamento 363 (18/11 11:00 - Terça - Pilates) - FUTURO
(363, 6, 'PENDENTE'), (363, 7, 'PENDENTE'), (363, 8, 'PENDENTE'), (363, 9, 'PENDENTE'),
-- Agendamento 364 (18/11 13:00 - Terça - Fisioterapia) - FUTURO
(364, 7, 'PENDENTE'), (364, 8, 'PENDENTE'), (364, 9, 'PENDENTE'), (364, 10, 'PENDENTE'),
-- Agendamento 365 (18/11 15:00 - Terça - Pilates) - FUTURO
(365, 8, 'PENDENTE'), (365, 9, 'PENDENTE'), (365, 10, 'PENDENTE'), (365, 1, 'PENDENTE'),
-- Agendamento 366 (19/11 09:00 - Quarta - Pilates) - FUTURO
(366, 9, 'PENDENTE'), (366, 10, 'PENDENTE'), (366, 1, 'PENDENTE'), (366, 2, 'PENDENTE'),
-- Agendamento 367 (19/11 11:00 - Quarta - RPG) - FUTURO
(367, 10, 'PENDENTE'), (367, 1, 'PENDENTE'), (367, 2, 'PENDENTE'), (367, 3, 'PENDENTE'),
-- Agendamento 368 (19/11 14:00 - Quarta - Fisioterapia) - FUTURO
(368, 1, 'PENDENTE'), (368, 2, 'PENDENTE'), (368, 3, 'PENDENTE'), (368, 4, 'PENDENTE'),
-- Agendamento 369 (19/11 16:00 - Quarta - Pilates) - FUTURO
(369, 2, 'PENDENTE'), (369, 3, 'PENDENTE'), (369, 4, 'PENDENTE'), (369, 5, 'PENDENTE'),
-- Agendamento 370 (20/11 09:00 - Quinta - Pilates) - FUTURO
(370, 3, 'PENDENTE'), (370, 4, 'PENDENTE'), (370, 5, 'PENDENTE'), (370, 6, 'PENDENTE'),
-- Agendamento 371 (20/11 11:00 - Quinta - RPG) - FUTURO
(371, 4, 'PENDENTE'), (371, 5, 'PENDENTE'), (371, 6, 'PENDENTE'), (371, 7, 'PENDENTE'),
-- Agendamento 372 (20/11 15:00 - Quinta - Pilates) - FUTURO
(372, 5, 'PENDENTE'), (372, 6, 'PENDENTE'), (372, 7, 'PENDENTE'), (372, 8, 'PENDENTE'),
-- Agendamento 373 (20/11 17:00 - Quinta - Fisioterapia) - FUTURO
(373, 6, 'PENDENTE'), (373, 7, 'PENDENTE'), (373, 8, 'PENDENTE'), (373, 9, 'PENDENTE'),
-- Agendamento 374 (21/11 09:00 - Sexta - RPG) - FUTURO
(374, 7, 'PENDENTE'), (374, 8, 'PENDENTE'), (374, 9, 'PENDENTE'), (374, 10, 'PENDENTE'),
-- Agendamento 375 (21/11 11:00 - Sexta - Pilates) - FUTURO
(375, 8, 'PENDENTE'), (375, 9, 'PENDENTE'), (375, 10, 'PENDENTE'), (375, 1, 'PENDENTE'),
-- Agendamento 376 (21/11 13:00 - Sexta - Fisioterapia) - FUTURO
(376, 9, 'PENDENTE'), (376, 10, 'PENDENTE'), (376, 1, 'PENDENTE'), (376, 2, 'PENDENTE'),
-- Agendamento 377 (21/11 15:00 - Sexta - Pilates) - FUTURO
(377, 10, 'PENDENTE'), (377, 1, 'PENDENTE'), (377, 2, 'PENDENTE'), (377, 3, 'PENDENTE'),
-- Agendamento 378 (24/11 09:00 - Segunda - Pilates) - FUTURO
(378, 1, 'PENDENTE'), (378, 2, 'PENDENTE'), (378, 3, 'PENDENTE'), (378, 4, 'PENDENTE'),
-- Agendamento 379 (24/11 11:00 - Segunda - RPG) - FUTURO
(379, 2, 'PENDENTE'), (379, 3, 'PENDENTE'), (379, 4, 'PENDENTE'), (379, 5, 'PENDENTE'),
-- Agendamento 380 (24/11 15:00 - Segunda - Fisioterapia) - FUTURO
(380, 3, 'PENDENTE'), (380, 4, 'PENDENTE'), (380, 5, 'PENDENTE'), (380, 6, 'PENDENTE'),
-- Agendamento 381 (24/11 17:00 - Segunda - Pilates) - FUTURO
(381, 4, 'PENDENTE'), (381, 5, 'PENDENTE'), (381, 6, 'PENDENTE'), (381, 7, 'PENDENTE'),
-- Agendamento 382 (25/11 09:00 - Terça - RPG) - FUTURO
(382, 5, 'PENDENTE'), (382, 6, 'PENDENTE'), (382, 7, 'PENDENTE'), (382, 8, 'PENDENTE'),
-- Agendamento 383 (25/11 11:00 - Terça - Pilates) - FUTURO
(383, 6, 'PENDENTE'), (383, 7, 'PENDENTE'), (383, 8, 'PENDENTE'), (383, 9, 'PENDENTE'),
-- Agendamento 384 (25/11 13:00 - Terça - Fisioterapia) - FUTURO
(384, 7, 'PENDENTE'), (384, 8, 'PENDENTE'), (384, 9, 'PENDENTE'), (384, 10, 'PENDENTE'),
-- Agendamento 385 (25/11 15:00 - Terça - Pilates) - FUTURO
(385, 8, 'PENDENTE'), (385, 9, 'PENDENTE'), (385, 10, 'PENDENTE'), (385, 1, 'PENDENTE'),
-- Agendamento 386 (26/11 09:00 - Quarta - Pilates) - FUTURO
(386, 9, 'PENDENTE'), (386, 10, 'PENDENTE'), (386, 1, 'PENDENTE'), (386, 2, 'PENDENTE'),
-- Agendamento 387 (26/11 11:00 - Quarta - RPG) - FUTURO
(387, 10, 'PENDENTE'), (387, 1, 'PENDENTE'), (387, 2, 'PENDENTE'), (387, 3, 'PENDENTE'),
-- Agendamento 388 (26/11 14:00 - Quarta - Fisioterapia) - FUTURO
(388, 1, 'PENDENTE'), (388, 2, 'PENDENTE'), (388, 3, 'PENDENTE'), (388, 4, 'PENDENTE'),
-- Agendamento 389 (26/11 16:00 - Quarta - Pilates) - FUTURO
(389, 2, 'PENDENTE'), (389, 3, 'PENDENTE'), (389, 4, 'PENDENTE'), (389, 5, 'PENDENTE'),
-- Agendamento 390 (27/11 09:00 - Quinta - Pilates) - FUTURO
(390, 3, 'PENDENTE'), (390, 4, 'PENDENTE'), (390, 5, 'PENDENTE'), (390, 6, 'PENDENTE'),
-- Agendamento 391 (27/11 11:00 - Quinta - RPG) - FUTURO
(391, 4, 'PENDENTE'), (391, 5, 'PENDENTE'), (391, 6, 'PENDENTE'), (391, 7, 'PENDENTE'),
-- Agendamento 392 (27/11 15:00 - Quinta - Pilates) - FUTURO
(392, 5, 'PENDENTE'), (392, 6, 'PENDENTE'), (392, 7, 'PENDENTE'), (392, 8, 'PENDENTE'),
-- Agendamento 393 (27/11 17:00 - Quinta - Fisioterapia) - FUTURO
(393, 6, 'PENDENTE'), (393, 7, 'PENDENTE'), (393, 8, 'PENDENTE'), (393, 9, 'PENDENTE');

-- Agendamentos de dezembro do Guilherme (IDs 394-457) - FUTUROS
INSERT IGNORE INTO agendamento_aluno (agendamento_id, aluno_id, status_presenca) VALUES
-- Agendamento 394 (01/12 09:00 - Segunda - Pilates)
(394, 7, 'PENDENTE'), (394, 8, 'PENDENTE'), (394, 9, 'PENDENTE'), (394, 10, 'PENDENTE'),
-- Agendamento 395 (01/12 11:00 - Segunda - RPG)
(395, 8, 'PENDENTE'), (395, 9, 'PENDENTE'), (395, 10, 'PENDENTE'), (395, 1, 'PENDENTE'),
-- Agendamento 396 (01/12 15:00 - Segunda - Fisioterapia)
(396, 9, 'PENDENTE'), (396, 10, 'PENDENTE'), (396, 1, 'PENDENTE'), (396, 2, 'PENDENTE'),
-- Agendamento 397 (01/12 17:00 - Segunda - Pilates)
(397, 10, 'PENDENTE'), (397, 1, 'PENDENTE'), (397, 2, 'PENDENTE'), (397, 3, 'PENDENTE'),
-- Agendamento 398 (02/12 09:00 - Terça - RPG)
(398, 1, 'PENDENTE'), (398, 2, 'PENDENTE'), (398, 3, 'PENDENTE'), (398, 4, 'PENDENTE'),
-- Agendamento 399 (02/12 11:00 - Terça - Pilates)
(399, 2, 'PENDENTE'), (399, 3, 'PENDENTE'), (399, 4, 'PENDENTE'), (399, 5, 'PENDENTE'),
-- Agendamento 400 (02/12 13:00 - Terça - Fisioterapia)
(400, 3, 'PENDENTE'), (400, 4, 'PENDENTE'), (400, 5, 'PENDENTE'), (400, 6, 'PENDENTE'),
-- Agendamento 401 (02/12 15:00 - Terça - Pilates)
(401, 4, 'PENDENTE'), (401, 5, 'PENDENTE'), (401, 6, 'PENDENTE'), (401, 7, 'PENDENTE'),
-- Agendamento 402 (03/12 09:00 - Quarta - Pilates)
(402, 5, 'PENDENTE'), (402, 6, 'PENDENTE'), (402, 7, 'PENDENTE'), (402, 8, 'PENDENTE'),
-- Agendamento 403 (03/12 11:00 - Quarta - RPG)
(403, 6, 'PENDENTE'), (403, 7, 'PENDENTE'), (403, 8, 'PENDENTE'), (403, 9, 'PENDENTE'),
-- Agendamento 404 (03/12 14:00 - Quarta - Fisioterapia)
(404, 7, 'PENDENTE'), (404, 8, 'PENDENTE'), (404, 9, 'PENDENTE'), (404, 10, 'PENDENTE'),
-- Agendamento 405 (03/12 16:00 - Quarta - Pilates)
(405, 8, 'PENDENTE'), (405, 9, 'PENDENTE'), (405, 10, 'PENDENTE'), (405, 1, 'PENDENTE'),
-- Agendamento 406 (04/12 09:00 - Quinta - Pilates)
(406, 9, 'PENDENTE'), (406, 10, 'PENDENTE'), (406, 1, 'PENDENTE'), (406, 2, 'PENDENTE'),
-- Agendamento 407 (04/12 11:00 - Quinta - RPG)
(407, 10, 'PENDENTE'), (407, 1, 'PENDENTE'), (407, 2, 'PENDENTE'), (407, 3, 'PENDENTE'),
-- Agendamento 408 (04/12 15:00 - Quinta - Pilates)
(408, 1, 'PENDENTE'), (408, 2, 'PENDENTE'), (408, 3, 'PENDENTE'), (408, 4, 'PENDENTE'),
-- Agendamento 409 (04/12 17:00 - Quinta - Fisioterapia)
(409, 2, 'PENDENTE'), (409, 3, 'PENDENTE'), (409, 4, 'PENDENTE'), (409, 5, 'PENDENTE'),
-- Agendamento 410 (05/12 09:00 - Sexta - RPG)
(410, 3, 'PENDENTE'), (410, 4, 'PENDENTE'), (410, 5, 'PENDENTE'), (410, 6, 'PENDENTE'),
-- Agendamento 411 (05/12 11:00 - Sexta - Pilates)
(411, 4, 'PENDENTE'), (411, 5, 'PENDENTE'), (411, 6, 'PENDENTE'), (411, 7, 'PENDENTE'),
-- Agendamento 412 (05/12 13:00 - Sexta - Fisioterapia)
(412, 5, 'PENDENTE'), (412, 6, 'PENDENTE'), (412, 7, 'PENDENTE'), (412, 8, 'PENDENTE'),
-- Agendamento 413 (05/12 15:00 - Sexta - Pilates)
(413, 6, 'PENDENTE'), (413, 7, 'PENDENTE'), (413, 8, 'PENDENTE'), (413, 9, 'PENDENTE'),
-- Agendamento 414 (08/12 09:00 - Segunda - Pilates)
(414, 7, 'PENDENTE'), (414, 8, 'PENDENTE'), (414, 9, 'PENDENTE'), (414, 10, 'PENDENTE'),
-- Agendamento 415 (08/12 11:00 - Segunda - RPG)
(415, 8, 'PENDENTE'), (415, 9, 'PENDENTE'), (415, 10, 'PENDENTE'), (415, 1, 'PENDENTE'),
-- Agendamento 416 (08/12 15:00 - Segunda - Fisioterapia)
(416, 9, 'PENDENTE'), (416, 10, 'PENDENTE'), (416, 1, 'PENDENTE'), (416, 2, 'PENDENTE'),
-- Agendamento 417 (08/12 17:00 - Segunda - Pilates)
(417, 10, 'PENDENTE'), (417, 1, 'PENDENTE'), (417, 2, 'PENDENTE'), (417, 3, 'PENDENTE'),
-- Agendamento 418 (09/12 09:00 - Terça - RPG)
(418, 1, 'PENDENTE'), (418, 2, 'PENDENTE'), (418, 3, 'PENDENTE'), (418, 4, 'PENDENTE'),
-- Agendamento 419 (09/12 11:00 - Terça - Pilates)
(419, 2, 'PENDENTE'), (419, 3, 'PENDENTE'), (419, 4, 'PENDENTE'), (419, 5, 'PENDENTE'),
-- Agendamento 420 (09/12 13:00 - Terça - Fisioterapia)
(420, 3, 'PENDENTE'), (420, 4, 'PENDENTE'), (420, 5, 'PENDENTE'), (420, 6, 'PENDENTE'),
-- Agendamento 421 (09/12 15:00 - Terça - Pilates)
(421, 4, 'PENDENTE'), (421, 5, 'PENDENTE'), (421, 6, 'PENDENTE'), (421, 7, 'PENDENTE'),
-- Agendamento 422 (10/12 09:00 - Quarta - Pilates)
(422, 5, 'PENDENTE'), (422, 6, 'PENDENTE'), (422, 7, 'PENDENTE'), (422, 8, 'PENDENTE'),
-- Agendamento 423 (10/12 11:00 - Quarta - RPG)
(423, 6, 'PENDENTE'), (423, 7, 'PENDENTE'), (423, 8, 'PENDENTE'), (423, 9, 'PENDENTE'),
-- Agendamento 424 (10/12 14:00 - Quarta - Fisioterapia)
(424, 7, 'PENDENTE'), (424, 8, 'PENDENTE'), (424, 9, 'PENDENTE'), (424, 10, 'PENDENTE'),
-- Agendamento 425 (10/12 16:00 - Quarta - Pilates)
(425, 8, 'PENDENTE'), (425, 9, 'PENDENTE'), (425, 10, 'PENDENTE'), (425, 1, 'PENDENTE'),
-- Agendamento 426 (11/12 09:00 - Quinta - Pilates)
(426, 9, 'PENDENTE'), (426, 10, 'PENDENTE'), (426, 1, 'PENDENTE'), (426, 2, 'PENDENTE'),
-- Agendamento 427 (11/12 11:00 - Quinta - RPG)
(427, 10, 'PENDENTE'), (427, 1, 'PENDENTE'), (427, 2, 'PENDENTE'), (427, 3, 'PENDENTE'),
-- Agendamento 428 (11/12 15:00 - Quinta - Pilates)
(428, 1, 'PENDENTE'), (428, 2, 'PENDENTE'), (428, 3, 'PENDENTE'), (428, 4, 'PENDENTE'),
-- Agendamento 429 (11/12 17:00 - Quinta - Fisioterapia)
(429, 2, 'PENDENTE'), (429, 3, 'PENDENTE'), (429, 4, 'PENDENTE'), (429, 5, 'PENDENTE'),
-- Agendamento 430 (12/12 09:00 - Sexta - RPG)
(430, 3, 'PENDENTE'), (430, 4, 'PENDENTE'), (430, 5, 'PENDENTE'), (430, 6, 'PENDENTE'),
-- Agendamento 431 (12/12 11:00 - Sexta - Pilates)
(431, 4, 'PENDENTE'), (431, 5, 'PENDENTE'), (431, 6, 'PENDENTE'), (431, 7, 'PENDENTE'),
-- Agendamento 432 (12/12 13:00 - Sexta - Fisioterapia)
(432, 5, 'PENDENTE'), (432, 6, 'PENDENTE'), (432, 7, 'PENDENTE'), (432, 8, 'PENDENTE'),
-- Agendamento 433 (12/12 15:00 - Sexta - Pilates)
(433, 6, 'PENDENTE'), (433, 7, 'PENDENTE'), (433, 8, 'PENDENTE'), (433, 9, 'PENDENTE'),
-- Agendamento 434 (15/12 09:00 - Segunda - Pilates)
(434, 7, 'PENDENTE'), (434, 8, 'PENDENTE'), (434, 9, 'PENDENTE'), (434, 10, 'PENDENTE'),
-- Agendamento 435 (15/12 11:00 - Segunda - RPG)
(435, 8, 'PENDENTE'), (435, 9, 'PENDENTE'), (435, 10, 'PENDENTE'), (435, 1, 'PENDENTE'),
-- Agendamento 436 (15/12 15:00 - Segunda - Fisioterapia)
(436, 9, 'PENDENTE'), (436, 10, 'PENDENTE'), (436, 1, 'PENDENTE'), (436, 2, 'PENDENTE'),
-- Agendamento 437 (15/12 17:00 - Segunda - Pilates)
(437, 10, 'PENDENTE'), (437, 1, 'PENDENTE'), (437, 2, 'PENDENTE'), (437, 3, 'PENDENTE'),
-- Agendamento 438 (16/12 09:00 - Terça - RPG)
(438, 1, 'PENDENTE'), (438, 2, 'PENDENTE'), (438, 3, 'PENDENTE'), (438, 4, 'PENDENTE'),
-- Agendamento 439 (16/12 11:00 - Terça - Pilates)
(439, 2, 'PENDENTE'), (439, 3, 'PENDENTE'), (439, 4, 'PENDENTE'), (439, 5, 'PENDENTE'),
-- Agendamento 440 (16/12 13:00 - Terça - Fisioterapia)
(440, 3, 'PENDENTE'), (440, 4, 'PENDENTE'), (440, 5, 'PENDENTE'), (440, 6, 'PENDENTE'),
-- Agendamento 441 (16/12 15:00 - Terça - Pilates)
(441, 4, 'PENDENTE'), (441, 5, 'PENDENTE'), (441, 6, 'PENDENTE'), (441, 7, 'PENDENTE'),
-- Agendamento 442 (17/12 09:00 - Quarta - Pilates)
(442, 5, 'PENDENTE'), (442, 6, 'PENDENTE'), (442, 7, 'PENDENTE'), (442, 8, 'PENDENTE'),
-- Agendamento 443 (17/12 11:00 - Quarta - RPG)
(443, 6, 'PENDENTE'), (443, 7, 'PENDENTE'), (443, 8, 'PENDENTE'), (443, 9, 'PENDENTE'),
-- Agendamento 444 (17/12 14:00 - Quarta - Fisioterapia)
(444, 7, 'PENDENTE'), (444, 8, 'PENDENTE'), (444, 9, 'PENDENTE'), (444, 10, 'PENDENTE'),
-- Agendamento 445 (17/12 16:00 - Quarta - Pilates)
(445, 8, 'PENDENTE'), (445, 9, 'PENDENTE'), (445, 10, 'PENDENTE'), (445, 1, 'PENDENTE'),
-- Agendamento 446 (18/12 09:00 - Quinta - Pilates)
(446, 9, 'PENDENTE'), (446, 10, 'PENDENTE'), (446, 1, 'PENDENTE'), (446, 2, 'PENDENTE'),
-- Agendamento 447 (18/12 11:00 - Quinta - RPG)
(447, 10, 'PENDENTE'), (447, 1, 'PENDENTE'), (447, 2, 'PENDENTE'), (447, 3, 'PENDENTE'),
-- Agendamento 448 (18/12 15:00 - Quinta - Pilates)
(448, 1, 'PENDENTE'), (448, 2, 'PENDENTE'), (448, 3, 'PENDENTE'), (448, 4, 'PENDENTE'),
-- Agendamento 449 (18/12 17:00 - Quinta - Fisioterapia)
(449, 2, 'PENDENTE'), (449, 3, 'PENDENTE'), (449, 4, 'PENDENTE'), (449, 5, 'PENDENTE'),
-- Agendamento 450 (19/12 09:00 - Sexta - RPG)
(450, 3, 'PENDENTE'), (450, 4, 'PENDENTE'), (450, 5, 'PENDENTE'), (450, 6, 'PENDENTE'),
-- Agendamento 451 (19/12 11:00 - Sexta - Pilates)
(451, 4, 'PENDENTE'), (451, 5, 'PENDENTE'), (451, 6, 'PENDENTE'), (451, 7, 'PENDENTE'),
-- Agendamento 452 (19/12 13:00 - Sexta - Fisioterapia)
(452, 5, 'PENDENTE'), (452, 6, 'PENDENTE'), (452, 7, 'PENDENTE'), (452, 8, 'PENDENTE'),
-- Agendamento 453 (19/12 15:00 - Sexta - Pilates)
(453, 6, 'PENDENTE'), (453, 7, 'PENDENTE'), (453, 8, 'PENDENTE'), (453, 9, 'PENDENTE'),
-- Agendamento 454 (22/12 09:00 - Segunda - Pilates)
(454, 7, 'PENDENTE'), (454, 8, 'PENDENTE'), (454, 9, 'PENDENTE'), (454, 10, 'PENDENTE'),
-- Agendamento 455 (22/12 11:00 - Segunda - RPG)
(455, 8, 'PENDENTE'), (455, 9, 'PENDENTE'), (455, 10, 'PENDENTE'), (455, 1, 'PENDENTE'),
-- Agendamento 456 (22/12 15:00 - Segunda - Fisioterapia)
(456, 9, 'PENDENTE'), (456, 10, 'PENDENTE'), (456, 1, 'PENDENTE'), (456, 2, 'PENDENTE'),
-- Agendamento 457 (22/12 17:00 - Segunda - Pilates)
(457, 10, 'PENDENTE'), (457, 1, 'PENDENTE'), (457, 2, 'PENDENTE'), (457, 3, 'PENDENTE');

-- ============================================
-- AGENDAMENTOS ANDREI - JAN-JUN 2026 (IDs 458-582) - FUTUROS
-- Rotacao alunos 11-20, iniciando em 19 (continuacao do ID 97)
-- ============================================
INSERT IGNORE INTO agendamento_aluno (agendamento_id, aluno_id, status_presenca) VALUES
(458,19,'PENDENTE'),(458,20,'PENDENTE'),(458,11,'PENDENTE'),(458,12,'PENDENTE'),
(459,20,'PENDENTE'),(459,11,'PENDENTE'),(459,12,'PENDENTE'),(459,13,'PENDENTE'),
(460,11,'PENDENTE'),(460,12,'PENDENTE'),(460,13,'PENDENTE'),(460,14,'PENDENTE'),
(461,12,'PENDENTE'),(461,13,'PENDENTE'),(461,14,'PENDENTE'),(461,15,'PENDENTE'),
(462,13,'PENDENTE'),(462,14,'PENDENTE'),(462,15,'PENDENTE'),(462,16,'PENDENTE'),
(463,14,'PENDENTE'),(463,15,'PENDENTE'),(463,16,'PENDENTE'),(463,17,'PENDENTE'),
(464,15,'PENDENTE'),(464,16,'PENDENTE'),(464,17,'PENDENTE'),(464,18,'PENDENTE'),
(465,16,'PENDENTE'),(465,17,'PENDENTE'),(465,18,'PENDENTE'),(465,19,'PENDENTE'),
(466,17,'PENDENTE'),(466,18,'PENDENTE'),(466,19,'PENDENTE'),(466,20,'PENDENTE'),
(467,18,'PENDENTE'),(467,19,'PENDENTE'),(467,20,'PENDENTE'),(467,11,'PENDENTE'),
(468,19,'PENDENTE'),(468,20,'PENDENTE'),(468,11,'PENDENTE'),(468,12,'PENDENTE'),
(469,20,'PENDENTE'),(469,11,'PENDENTE'),(469,12,'PENDENTE'),(469,13,'PENDENTE'),
(470,11,'PENDENTE'),(470,12,'PENDENTE'),(470,13,'PENDENTE'),(470,14,'PENDENTE'),
(471,12,'PENDENTE'),(471,13,'PENDENTE'),(471,14,'PENDENTE'),(471,15,'PENDENTE'),
(472,13,'PENDENTE'),(472,14,'PENDENTE'),(472,15,'PENDENTE'),(472,16,'PENDENTE'),
(473,14,'PENDENTE'),(473,15,'PENDENTE'),(473,16,'PENDENTE'),(473,17,'PENDENTE'),
(474,15,'PENDENTE'),(474,16,'PENDENTE'),(474,17,'PENDENTE'),(474,18,'PENDENTE'),
(475,16,'PENDENTE'),(475,17,'PENDENTE'),(475,18,'PENDENTE'),(475,19,'PENDENTE'),
(476,17,'PENDENTE'),(476,18,'PENDENTE'),(476,19,'PENDENTE'),(476,20,'PENDENTE'),
(477,18,'PENDENTE'),(477,19,'PENDENTE'),(477,20,'PENDENTE'),(477,11,'PENDENTE'),
(478,19,'PENDENTE'),(478,20,'PENDENTE'),(478,11,'PENDENTE'),(478,12,'PENDENTE'),
(479,20,'PENDENTE'),(479,11,'PENDENTE'),(479,12,'PENDENTE'),(479,13,'PENDENTE'),
(480,11,'PENDENTE'),(480,12,'PENDENTE'),(480,13,'PENDENTE'),(480,14,'PENDENTE'),
(481,12,'PENDENTE'),(481,13,'PENDENTE'),(481,14,'PENDENTE'),(481,15,'PENDENTE'),
(482,13,'PENDENTE'),(482,14,'PENDENTE'),(482,15,'PENDENTE'),(482,16,'PENDENTE'),
(483,14,'PENDENTE'),(483,15,'PENDENTE'),(483,16,'PENDENTE'),(483,17,'PENDENTE'),
(484,15,'PENDENTE'),(484,16,'PENDENTE'),(484,17,'PENDENTE'),(484,18,'PENDENTE'),
(485,16,'PENDENTE'),(485,17,'PENDENTE'),(485,18,'PENDENTE'),(485,19,'PENDENTE'),
(486,17,'PENDENTE'),(486,18,'PENDENTE'),(486,19,'PENDENTE'),(486,20,'PENDENTE'),
(487,18,'PENDENTE'),(487,19,'PENDENTE'),(487,20,'PENDENTE'),(487,11,'PENDENTE'),
(488,19,'PENDENTE'),(488,20,'PENDENTE'),(488,11,'PENDENTE'),(488,12,'PENDENTE'),
(489,20,'PENDENTE'),(489,11,'PENDENTE'),(489,12,'PENDENTE'),(489,13,'PENDENTE'),
(490,11,'PENDENTE'),(490,12,'PENDENTE'),(490,13,'PENDENTE'),(490,14,'PENDENTE'),
(491,12,'PENDENTE'),(491,13,'PENDENTE'),(491,14,'PENDENTE'),(491,15,'PENDENTE'),
(492,13,'PENDENTE'),(492,14,'PENDENTE'),(492,15,'PENDENTE'),(492,16,'PENDENTE'),
(493,14,'PENDENTE'),(493,15,'PENDENTE'),(493,16,'PENDENTE'),(493,17,'PENDENTE'),
(494,15,'PENDENTE'),(494,16,'PENDENTE'),(494,17,'PENDENTE'),(494,18,'PENDENTE'),
(495,16,'PENDENTE'),(495,17,'PENDENTE'),(495,18,'PENDENTE'),(495,19,'PENDENTE'),
(496,17,'PENDENTE'),(496,18,'PENDENTE'),(496,19,'PENDENTE'),(496,20,'PENDENTE'),
(497,18,'PENDENTE'),(497,19,'PENDENTE'),(497,20,'PENDENTE'),(497,11,'PENDENTE'),
(498,19,'PENDENTE'),(498,20,'PENDENTE'),(498,11,'PENDENTE'),(498,12,'PENDENTE'),
(499,20,'PENDENTE'),(499,11,'PENDENTE'),(499,12,'PENDENTE'),(499,13,'PENDENTE'),
(500,11,'PENDENTE'),(500,12,'PENDENTE'),(500,13,'PENDENTE'),(500,14,'PENDENTE'),
(501,12,'PENDENTE'),(501,13,'PENDENTE'),(501,14,'PENDENTE'),(501,15,'PENDENTE'),
(502,13,'PENDENTE'),(502,14,'PENDENTE'),(502,15,'PENDENTE'),(502,16,'PENDENTE'),
(503,14,'PENDENTE'),(503,15,'PENDENTE'),(503,16,'PENDENTE'),(503,17,'PENDENTE'),
(504,15,'PENDENTE'),(504,16,'PENDENTE'),(504,17,'PENDENTE'),(504,18,'PENDENTE'),
(505,16,'PENDENTE'),(505,17,'PENDENTE'),(505,18,'PENDENTE'),(505,19,'PENDENTE'),
(506,17,'PENDENTE'),(506,18,'PENDENTE'),(506,19,'PENDENTE'),(506,20,'PENDENTE'),
(507,18,'PENDENTE'),(507,19,'PENDENTE'),(507,20,'PENDENTE'),(507,11,'PENDENTE'),
(508,19,'PENDENTE'),(508,20,'PENDENTE'),(508,11,'PENDENTE'),(508,12,'PENDENTE'),
(509,20,'PENDENTE'),(509,11,'PENDENTE'),(509,12,'PENDENTE'),(509,13,'PENDENTE'),
(510,11,'PENDENTE'),(510,12,'PENDENTE'),(510,13,'PENDENTE'),(510,14,'PENDENTE'),
(511,12,'PENDENTE'),(511,13,'PENDENTE'),(511,14,'PENDENTE'),(511,15,'PENDENTE'),
(512,13,'PENDENTE'),(512,14,'PENDENTE'),(512,15,'PENDENTE'),(512,16,'PENDENTE'),
(513,14,'PENDENTE'),(513,15,'PENDENTE'),(513,16,'PENDENTE'),(513,17,'PENDENTE'),
(514,15,'PENDENTE'),(514,16,'PENDENTE'),(514,17,'PENDENTE'),(514,18,'PENDENTE'),
(515,16,'PENDENTE'),(515,17,'PENDENTE'),(515,18,'PENDENTE'),(515,19,'PENDENTE'),
(516,17,'PENDENTE'),(516,18,'PENDENTE'),(516,19,'PENDENTE'),(516,20,'PENDENTE'),
(517,18,'PENDENTE'),(517,19,'PENDENTE'),(517,20,'PENDENTE'),(517,11,'PENDENTE'),
(518,19,'PENDENTE'),(518,20,'PENDENTE'),(518,11,'PENDENTE'),(518,12,'PENDENTE'),
(519,20,'PENDENTE'),(519,11,'PENDENTE'),(519,12,'PENDENTE'),(519,13,'PENDENTE'),
(520,11,'PENDENTE'),(520,12,'PENDENTE'),(520,13,'PENDENTE'),(520,14,'PENDENTE'),
(521,12,'PENDENTE'),(521,13,'PENDENTE'),(521,14,'PENDENTE'),(521,15,'PENDENTE'),
(522,13,'PENDENTE'),(522,14,'PENDENTE'),(522,15,'PENDENTE'),(522,16,'PENDENTE'),
(523,14,'PENDENTE'),(523,15,'PENDENTE'),(523,16,'PENDENTE'),(523,17,'PENDENTE'),
(524,15,'PENDENTE'),(524,16,'PENDENTE'),(524,17,'PENDENTE'),(524,18,'PENDENTE'),
(525,16,'PENDENTE'),(525,17,'PENDENTE'),(525,18,'PENDENTE'),(525,19,'PENDENTE'),
(526,17,'PENDENTE'),(526,18,'PENDENTE'),(526,19,'PENDENTE'),(526,20,'PENDENTE'),
(527,18,'PENDENTE'),(527,19,'PENDENTE'),(527,20,'PENDENTE'),(527,11,'PENDENTE'),
(528,19,'PENDENTE'),(528,20,'PENDENTE'),(528,11,'PENDENTE'),(528,12,'PENDENTE'),
(529,20,'PENDENTE'),(529,11,'PENDENTE'),(529,12,'PENDENTE'),(529,13,'PENDENTE'),
(530,11,'PENDENTE'),(530,12,'PENDENTE'),(530,13,'PENDENTE'),(530,14,'PENDENTE'),
(531,12,'PENDENTE'),(531,13,'PENDENTE'),(531,14,'PENDENTE'),(531,15,'PENDENTE'),
(532,13,'PENDENTE'),(532,14,'PENDENTE'),(532,15,'PENDENTE'),(532,16,'PENDENTE'),
(533,14,'PENDENTE'),(533,15,'PENDENTE'),(533,16,'PENDENTE'),(533,17,'PENDENTE'),
(534,15,'PENDENTE'),(534,16,'PENDENTE'),(534,17,'PENDENTE'),(534,18,'PENDENTE'),
(535,16,'PENDENTE'),(535,17,'PENDENTE'),(535,18,'PENDENTE'),(535,19,'PENDENTE'),
(536,17,'PENDENTE'),(536,18,'PENDENTE'),(536,19,'PENDENTE'),(536,20,'PENDENTE'),
(537,18,'PENDENTE'),(537,19,'PENDENTE'),(537,20,'PENDENTE'),(537,11,'PENDENTE'),
(538,19,'PENDENTE'),(538,20,'PENDENTE'),(538,11,'PENDENTE'),(538,12,'PENDENTE'),
(539,20,'PENDENTE'),(539,11,'PENDENTE'),(539,12,'PENDENTE'),(539,13,'PENDENTE'),
(540,11,'PENDENTE'),(540,12,'PENDENTE'),(540,13,'PENDENTE'),(540,14,'PENDENTE'),
(541,12,'PENDENTE'),(541,13,'PENDENTE'),(541,14,'PENDENTE'),(541,15,'PENDENTE'),
(542,13,'PENDENTE'),(542,14,'PENDENTE'),(542,15,'PENDENTE'),(542,16,'PENDENTE'),
(543,14,'PENDENTE'),(543,15,'PENDENTE'),(543,16,'PENDENTE'),(543,17,'PENDENTE'),
(544,15,'PENDENTE'),(544,16,'PENDENTE'),(544,17,'PENDENTE'),(544,18,'PENDENTE'),
(545,16,'PENDENTE'),(545,17,'PENDENTE'),(545,18,'PENDENTE'),(545,19,'PENDENTE'),
(546,17,'PENDENTE'),(546,18,'PENDENTE'),(546,19,'PENDENTE'),(546,20,'PENDENTE'),
(547,18,'PENDENTE'),(547,19,'PENDENTE'),(547,20,'PENDENTE'),(547,11,'PENDENTE'),
(548,19,'PENDENTE'),(548,20,'PENDENTE'),(548,11,'PENDENTE'),(548,12,'PENDENTE'),
(549,20,'PENDENTE'),(549,11,'PENDENTE'),(549,12,'PENDENTE'),(549,13,'PENDENTE'),
(550,11,'PENDENTE'),(550,12,'PENDENTE'),(550,13,'PENDENTE'),(550,14,'PENDENTE'),
(551,12,'PENDENTE'),(551,13,'PENDENTE'),(551,14,'PENDENTE'),(551,15,'PENDENTE'),
(552,13,'PENDENTE'),(552,14,'PENDENTE'),(552,15,'PENDENTE'),(552,16,'PENDENTE'),
(553,14,'PENDENTE'),(553,15,'PENDENTE'),(553,16,'PENDENTE'),(553,17,'PENDENTE'),
(554,15,'PENDENTE'),(554,16,'PENDENTE'),(554,17,'PENDENTE'),(554,18,'PENDENTE'),
(555,16,'PENDENTE'),(555,17,'PENDENTE'),(555,18,'PENDENTE'),(555,19,'PENDENTE'),
(556,17,'PENDENTE'),(556,18,'PENDENTE'),(556,19,'PENDENTE'),(556,20,'PENDENTE'),
(557,18,'PENDENTE'),(557,19,'PENDENTE'),(557,20,'PENDENTE'),(557,11,'PENDENTE'),
(558,19,'PENDENTE'),(558,20,'PENDENTE'),(558,11,'PENDENTE'),(558,12,'PENDENTE'),
(559,20,'PENDENTE'),(559,11,'PENDENTE'),(559,12,'PENDENTE'),(559,13,'PENDENTE'),
(560,11,'PENDENTE'),(560,12,'PENDENTE'),(560,13,'PENDENTE'),(560,14,'PENDENTE'),
(561,12,'PENDENTE'),(561,13,'PENDENTE'),(561,14,'PENDENTE'),(561,15,'PENDENTE'),
(562,13,'PENDENTE'),(562,14,'PENDENTE'),(562,15,'PENDENTE'),(562,16,'PENDENTE'),
(563,14,'PENDENTE'),(563,15,'PENDENTE'),(563,16,'PENDENTE'),(563,17,'PENDENTE'),
(564,15,'PENDENTE'),(564,16,'PENDENTE'),(564,17,'PENDENTE'),(564,18,'PENDENTE'),
(565,16,'PENDENTE'),(565,17,'PENDENTE'),(565,18,'PENDENTE'),(565,19,'PENDENTE'),
(566,17,'PENDENTE'),(566,18,'PENDENTE'),(566,19,'PENDENTE'),(566,20,'PENDENTE'),
(567,18,'PENDENTE'),(567,19,'PENDENTE'),(567,20,'PENDENTE'),(567,11,'PENDENTE'),
(568,19,'PENDENTE'),(568,20,'PENDENTE'),(568,11,'PENDENTE'),(568,12,'PENDENTE'),
(569,20,'PENDENTE'),(569,11,'PENDENTE'),(569,12,'PENDENTE'),(569,13,'PENDENTE'),
(570,11,'PENDENTE'),(570,12,'PENDENTE'),(570,13,'PENDENTE'),(570,14,'PENDENTE'),
(571,12,'PENDENTE'),(571,13,'PENDENTE'),(571,14,'PENDENTE'),(571,15,'PENDENTE'),
(572,13,'PENDENTE'),(572,14,'PENDENTE'),(572,15,'PENDENTE'),(572,16,'PENDENTE'),
(573,14,'PENDENTE'),(573,15,'PENDENTE'),(573,16,'PENDENTE'),(573,17,'PENDENTE'),
(574,15,'PENDENTE'),(574,16,'PENDENTE'),(574,17,'PENDENTE'),(574,18,'PENDENTE'),
(575,16,'PENDENTE'),(575,17,'PENDENTE'),(575,18,'PENDENTE'),(575,19,'PENDENTE'),
(576,17,'PENDENTE'),(576,18,'PENDENTE'),(576,19,'PENDENTE'),(576,20,'PENDENTE'),
(577,18,'PENDENTE'),(577,19,'PENDENTE'),(577,20,'PENDENTE'),(577,11,'PENDENTE'),
(578,19,'PENDENTE'),(578,20,'PENDENTE'),(578,11,'PENDENTE'),(578,12,'PENDENTE'),
(579,20,'PENDENTE'),(579,11,'PENDENTE'),(579,12,'PENDENTE'),(579,13,'PENDENTE'),
(580,11,'PENDENTE'),(580,12,'PENDENTE'),(580,13,'PENDENTE'),(580,14,'PENDENTE'),
(581,12,'PENDENTE'),(581,13,'PENDENTE'),(581,14,'PENDENTE'),(581,15,'PENDENTE'),
(582,13,'PENDENTE'),(582,14,'PENDENTE'),(582,15,'PENDENTE'),(582,16,'PENDENTE');

-- ============================================
-- AGENDAMENTOS GUILHERME - JAN-JUN 2026 (IDs 583-1078) - FUTUROS
-- Rotacao alunos 1-10, iniciando em 1 (continuacao do ID 457)
-- ============================================
INSERT IGNORE INTO agendamento_aluno (agendamento_id, aluno_id, status_presenca) VALUES
(583,1,'PENDENTE'),(583,2,'PENDENTE'),(583,3,'PENDENTE'),(583,4,'PENDENTE'),
(584,2,'PENDENTE'),(584,3,'PENDENTE'),(584,4,'PENDENTE'),(584,5,'PENDENTE'),
(585,3,'PENDENTE'),(585,4,'PENDENTE'),(585,5,'PENDENTE'),(585,6,'PENDENTE'),
(586,4,'PENDENTE'),(586,5,'PENDENTE'),(586,6,'PENDENTE'),(586,7,'PENDENTE'),
(587,5,'PENDENTE'),(587,6,'PENDENTE'),(587,7,'PENDENTE'),(587,8,'PENDENTE'),
(588,6,'PENDENTE'),(588,7,'PENDENTE'),(588,8,'PENDENTE'),(588,9,'PENDENTE'),
(589,7,'PENDENTE'),(589,8,'PENDENTE'),(589,9,'PENDENTE'),(589,10,'PENDENTE'),
(590,8,'PENDENTE'),(590,9,'PENDENTE'),(590,10,'PENDENTE'),(590,1,'PENDENTE'),
(591,9,'PENDENTE'),(591,10,'PENDENTE'),(591,1,'PENDENTE'),(591,2,'PENDENTE'),
(592,10,'PENDENTE'),(592,1,'PENDENTE'),(592,2,'PENDENTE'),(592,3,'PENDENTE'),
(593,1,'PENDENTE'),(593,2,'PENDENTE'),(593,3,'PENDENTE'),(593,4,'PENDENTE'),
(594,2,'PENDENTE'),(594,3,'PENDENTE'),(594,4,'PENDENTE'),(594,5,'PENDENTE'),
(595,3,'PENDENTE'),(595,4,'PENDENTE'),(595,5,'PENDENTE'),(595,6,'PENDENTE'),
(596,4,'PENDENTE'),(596,5,'PENDENTE'),(596,6,'PENDENTE'),(596,7,'PENDENTE'),
(597,5,'PENDENTE'),(597,6,'PENDENTE'),(597,7,'PENDENTE'),(597,8,'PENDENTE'),
(598,6,'PENDENTE'),(598,7,'PENDENTE'),(598,8,'PENDENTE'),(598,9,'PENDENTE'),
(599,7,'PENDENTE'),(599,8,'PENDENTE'),(599,9,'PENDENTE'),(599,10,'PENDENTE'),
(600,8,'PENDENTE'),(600,9,'PENDENTE'),(600,10,'PENDENTE'),(600,1,'PENDENTE'),
(601,9,'PENDENTE'),(601,10,'PENDENTE'),(601,1,'PENDENTE'),(601,2,'PENDENTE'),
(602,10,'PENDENTE'),(602,1,'PENDENTE'),(602,2,'PENDENTE'),(602,3,'PENDENTE'),
(603,1,'PENDENTE'),(603,2,'PENDENTE'),(603,3,'PENDENTE'),(603,4,'PENDENTE'),
(604,2,'PENDENTE'),(604,3,'PENDENTE'),(604,4,'PENDENTE'),(604,5,'PENDENTE'),
(605,3,'PENDENTE'),(605,4,'PENDENTE'),(605,5,'PENDENTE'),(605,6,'PENDENTE'),
(606,4,'PENDENTE'),(606,5,'PENDENTE'),(606,6,'PENDENTE'),(606,7,'PENDENTE'),
(607,5,'PENDENTE'),(607,6,'PENDENTE'),(607,7,'PENDENTE'),(607,8,'PENDENTE'),
(608,6,'PENDENTE'),(608,7,'PENDENTE'),(608,8,'PENDENTE'),(608,9,'PENDENTE'),
(609,7,'PENDENTE'),(609,8,'PENDENTE'),(609,9,'PENDENTE'),(609,10,'PENDENTE'),
(610,8,'PENDENTE'),(610,9,'PENDENTE'),(610,10,'PENDENTE'),(610,1,'PENDENTE'),
(611,9,'PENDENTE'),(611,10,'PENDENTE'),(611,1,'PENDENTE'),(611,2,'PENDENTE'),
(612,10,'PENDENTE'),(612,1,'PENDENTE'),(612,2,'PENDENTE'),(612,3,'PENDENTE'),
(613,1,'PENDENTE'),(613,2,'PENDENTE'),(613,3,'PENDENTE'),(613,4,'PENDENTE'),
(614,2,'PENDENTE'),(614,3,'PENDENTE'),(614,4,'PENDENTE'),(614,5,'PENDENTE'),
(615,3,'PENDENTE'),(615,4,'PENDENTE'),(615,5,'PENDENTE'),(615,6,'PENDENTE'),
(616,4,'PENDENTE'),(616,5,'PENDENTE'),(616,6,'PENDENTE'),(616,7,'PENDENTE'),
(617,5,'PENDENTE'),(617,6,'PENDENTE'),(617,7,'PENDENTE'),(617,8,'PENDENTE'),
(618,6,'PENDENTE'),(618,7,'PENDENTE'),(618,8,'PENDENTE'),(618,9,'PENDENTE'),
(619,7,'PENDENTE'),(619,8,'PENDENTE'),(619,9,'PENDENTE'),(619,10,'PENDENTE'),
(620,8,'PENDENTE'),(620,9,'PENDENTE'),(620,10,'PENDENTE'),(620,1,'PENDENTE'),
(621,9,'PENDENTE'),(621,10,'PENDENTE'),(621,1,'PENDENTE'),(621,2,'PENDENTE'),
(622,10,'PENDENTE'),(622,1,'PENDENTE'),(622,2,'PENDENTE'),(622,3,'PENDENTE'),
(623,1,'PENDENTE'),(623,2,'PENDENTE'),(623,3,'PENDENTE'),(623,4,'PENDENTE'),
(624,2,'PENDENTE'),(624,3,'PENDENTE'),(624,4,'PENDENTE'),(624,5,'PENDENTE'),
(625,3,'PENDENTE'),(625,4,'PENDENTE'),(625,5,'PENDENTE'),(625,6,'PENDENTE'),
(626,4,'PENDENTE'),(626,5,'PENDENTE'),(626,6,'PENDENTE'),(626,7,'PENDENTE'),
(627,5,'PENDENTE'),(627,6,'PENDENTE'),(627,7,'PENDENTE'),(627,8,'PENDENTE'),
(628,6,'PENDENTE'),(628,7,'PENDENTE'),(628,8,'PENDENTE'),(628,9,'PENDENTE'),
(629,7,'PENDENTE'),(629,8,'PENDENTE'),(629,9,'PENDENTE'),(629,10,'PENDENTE'),
(630,8,'PENDENTE'),(630,9,'PENDENTE'),(630,10,'PENDENTE'),(630,1,'PENDENTE'),
(631,9,'PENDENTE'),(631,10,'PENDENTE'),(631,1,'PENDENTE'),(631,2,'PENDENTE'),
(632,10,'PENDENTE'),(632,1,'PENDENTE'),(632,2,'PENDENTE'),(632,3,'PENDENTE'),
(633,1,'PENDENTE'),(633,2,'PENDENTE'),(633,3,'PENDENTE'),(633,4,'PENDENTE'),
(634,2,'PENDENTE'),(634,3,'PENDENTE'),(634,4,'PENDENTE'),(634,5,'PENDENTE'),
(635,3,'PENDENTE'),(635,4,'PENDENTE'),(635,5,'PENDENTE'),(635,6,'PENDENTE'),
(636,4,'PENDENTE'),(636,5,'PENDENTE'),(636,6,'PENDENTE'),(636,7,'PENDENTE'),
(637,5,'PENDENTE'),(637,6,'PENDENTE'),(637,7,'PENDENTE'),(637,8,'PENDENTE'),
(638,6,'PENDENTE'),(638,7,'PENDENTE'),(638,8,'PENDENTE'),(638,9,'PENDENTE'),
(639,7,'PENDENTE'),(639,8,'PENDENTE'),(639,9,'PENDENTE'),(639,10,'PENDENTE'),
(640,8,'PENDENTE'),(640,9,'PENDENTE'),(640,10,'PENDENTE'),(640,1,'PENDENTE'),
(641,9,'PENDENTE'),(641,10,'PENDENTE'),(641,1,'PENDENTE'),(641,2,'PENDENTE'),
(642,10,'PENDENTE'),(642,1,'PENDENTE'),(642,2,'PENDENTE'),(642,3,'PENDENTE'),
(643,1,'PENDENTE'),(643,2,'PENDENTE'),(643,3,'PENDENTE'),(643,4,'PENDENTE'),
(644,2,'PENDENTE'),(644,3,'PENDENTE'),(644,4,'PENDENTE'),(644,5,'PENDENTE'),
(645,3,'PENDENTE'),(645,4,'PENDENTE'),(645,5,'PENDENTE'),(645,6,'PENDENTE'),
(646,4,'PENDENTE'),(646,5,'PENDENTE'),(646,6,'PENDENTE'),(646,7,'PENDENTE'),
(647,5,'PENDENTE'),(647,6,'PENDENTE'),(647,7,'PENDENTE'),(647,8,'PENDENTE'),
(648,6,'PENDENTE'),(648,7,'PENDENTE'),(648,8,'PENDENTE'),(648,9,'PENDENTE'),
(649,7,'PENDENTE'),(649,8,'PENDENTE'),(649,9,'PENDENTE'),(649,10,'PENDENTE'),
(650,8,'PENDENTE'),(650,9,'PENDENTE'),(650,10,'PENDENTE'),(650,1,'PENDENTE'),
(651,9,'PENDENTE'),(651,10,'PENDENTE'),(651,1,'PENDENTE'),(651,2,'PENDENTE'),
(652,10,'PENDENTE'),(652,1,'PENDENTE'),(652,2,'PENDENTE'),(652,3,'PENDENTE'),
(653,1,'PENDENTE'),(653,2,'PENDENTE'),(653,3,'PENDENTE'),(653,4,'PENDENTE'),
(654,2,'PENDENTE'),(654,3,'PENDENTE'),(654,4,'PENDENTE'),(654,5,'PENDENTE'),
(655,3,'PENDENTE'),(655,4,'PENDENTE'),(655,5,'PENDENTE'),(655,6,'PENDENTE'),
(656,4,'PENDENTE'),(656,5,'PENDENTE'),(656,6,'PENDENTE'),(656,7,'PENDENTE'),
(657,5,'PENDENTE'),(657,6,'PENDENTE'),(657,7,'PENDENTE'),(657,8,'PENDENTE'),
(658,6,'PENDENTE'),(658,7,'PENDENTE'),(658,8,'PENDENTE'),(658,9,'PENDENTE'),
(659,7,'PENDENTE'),(659,8,'PENDENTE'),(659,9,'PENDENTE'),(659,10,'PENDENTE'),
(660,8,'PENDENTE'),(660,9,'PENDENTE'),(660,10,'PENDENTE'),(660,1,'PENDENTE'),
(661,9,'PENDENTE'),(661,10,'PENDENTE'),(661,1,'PENDENTE'),(661,2,'PENDENTE'),
(662,10,'PENDENTE'),(662,1,'PENDENTE'),(662,2,'PENDENTE'),(662,3,'PENDENTE'),
(663,1,'PENDENTE'),(663,2,'PENDENTE'),(663,3,'PENDENTE'),(663,4,'PENDENTE'),
(664,2,'PENDENTE'),(664,3,'PENDENTE'),(664,4,'PENDENTE'),(664,5,'PENDENTE'),
(665,3,'PENDENTE'),(665,4,'PENDENTE'),(665,5,'PENDENTE'),(665,6,'PENDENTE'),
(666,4,'PENDENTE'),(666,5,'PENDENTE'),(666,6,'PENDENTE'),(666,7,'PENDENTE'),
(667,5,'PENDENTE'),(667,6,'PENDENTE'),(667,7,'PENDENTE'),(667,8,'PENDENTE'),
(668,6,'PENDENTE'),(668,7,'PENDENTE'),(668,8,'PENDENTE'),(668,9,'PENDENTE'),
(669,7,'PENDENTE'),(669,8,'PENDENTE'),(669,9,'PENDENTE'),(669,10,'PENDENTE'),
(670,8,'PENDENTE'),(670,9,'PENDENTE'),(670,10,'PENDENTE'),(670,1,'PENDENTE'),
(671,9,'PENDENTE'),(671,10,'PENDENTE'),(671,1,'PENDENTE'),(671,2,'PENDENTE'),
(672,10,'PENDENTE'),(672,1,'PENDENTE'),(672,2,'PENDENTE'),(672,3,'PENDENTE'),
(673,1,'PENDENTE'),(673,2,'PENDENTE'),(673,3,'PENDENTE'),(673,4,'PENDENTE'),
(674,2,'PENDENTE'),(674,3,'PENDENTE'),(674,4,'PENDENTE'),(674,5,'PENDENTE'),
(675,3,'PENDENTE'),(675,4,'PENDENTE'),(675,5,'PENDENTE'),(675,6,'PENDENTE'),
(676,4,'PENDENTE'),(676,5,'PENDENTE'),(676,6,'PENDENTE'),(676,7,'PENDENTE'),
(677,5,'PENDENTE'),(677,6,'PENDENTE'),(677,7,'PENDENTE'),(677,8,'PENDENTE'),
(678,6,'PENDENTE'),(678,7,'PENDENTE'),(678,8,'PENDENTE'),(678,9,'PENDENTE'),
(679,7,'PENDENTE'),(679,8,'PENDENTE'),(679,9,'PENDENTE'),(679,10,'PENDENTE'),
(680,8,'PENDENTE'),(680,9,'PENDENTE'),(680,10,'PENDENTE'),(680,1,'PENDENTE'),
(681,9,'PENDENTE'),(681,10,'PENDENTE'),(681,1,'PENDENTE'),(681,2,'PENDENTE'),
(682,10,'PENDENTE'),(682,1,'PENDENTE'),(682,2,'PENDENTE'),(682,3,'PENDENTE'),
(683,1,'PENDENTE'),(683,2,'PENDENTE'),(683,3,'PENDENTE'),(683,4,'PENDENTE'),
(684,2,'PENDENTE'),(684,3,'PENDENTE'),(684,4,'PENDENTE'),(684,5,'PENDENTE'),
(685,3,'PENDENTE'),(685,4,'PENDENTE'),(685,5,'PENDENTE'),(685,6,'PENDENTE'),
(686,4,'PENDENTE'),(686,5,'PENDENTE'),(686,6,'PENDENTE'),(686,7,'PENDENTE'),
(687,5,'PENDENTE'),(687,6,'PENDENTE'),(687,7,'PENDENTE'),(687,8,'PENDENTE'),
(688,6,'PENDENTE'),(688,7,'PENDENTE'),(688,8,'PENDENTE'),(688,9,'PENDENTE'),
(689,7,'PENDENTE'),(689,8,'PENDENTE'),(689,9,'PENDENTE'),(689,10,'PENDENTE'),
(690,8,'PENDENTE'),(690,9,'PENDENTE'),(690,10,'PENDENTE'),(690,1,'PENDENTE'),
(691,9,'PENDENTE'),(691,10,'PENDENTE'),(691,1,'PENDENTE'),(691,2,'PENDENTE'),
(692,10,'PENDENTE'),(692,1,'PENDENTE'),(692,2,'PENDENTE'),(692,3,'PENDENTE'),
(693,1,'PENDENTE'),(693,2,'PENDENTE'),(693,3,'PENDENTE'),(693,4,'PENDENTE'),
(694,2,'PENDENTE'),(694,3,'PENDENTE'),(694,4,'PENDENTE'),(694,5,'PENDENTE'),
(695,3,'PENDENTE'),(695,4,'PENDENTE'),(695,5,'PENDENTE'),(695,6,'PENDENTE'),
(696,4,'PENDENTE'),(696,5,'PENDENTE'),(696,6,'PENDENTE'),(696,7,'PENDENTE'),
(697,5,'PENDENTE'),(697,6,'PENDENTE'),(697,7,'PENDENTE'),(697,8,'PENDENTE'),
(698,6,'PENDENTE'),(698,7,'PENDENTE'),(698,8,'PENDENTE'),(698,9,'PENDENTE'),
(699,7,'PENDENTE'),(699,8,'PENDENTE'),(699,9,'PENDENTE'),(699,10,'PENDENTE'),
(700,8,'PENDENTE'),(700,9,'PENDENTE'),(700,10,'PENDENTE'),(700,1,'PENDENTE'),
(701,9,'PENDENTE'),(701,10,'PENDENTE'),(701,1,'PENDENTE'),(701,2,'PENDENTE'),
(702,10,'PENDENTE'),(702,1,'PENDENTE'),(702,2,'PENDENTE'),(702,3,'PENDENTE'),
(703,1,'PENDENTE'),(703,2,'PENDENTE'),(703,3,'PENDENTE'),(703,4,'PENDENTE'),
(704,2,'PENDENTE'),(704,3,'PENDENTE'),(704,4,'PENDENTE'),(704,5,'PENDENTE'),
(705,3,'PENDENTE'),(705,4,'PENDENTE'),(705,5,'PENDENTE'),(705,6,'PENDENTE'),
(706,4,'PENDENTE'),(706,5,'PENDENTE'),(706,6,'PENDENTE'),(706,7,'PENDENTE'),
(707,5,'PENDENTE'),(707,6,'PENDENTE'),(707,7,'PENDENTE'),(707,8,'PENDENTE'),
(708,6,'PENDENTE'),(708,7,'PENDENTE'),(708,8,'PENDENTE'),(708,9,'PENDENTE'),
(709,7,'PENDENTE'),(709,8,'PENDENTE'),(709,9,'PENDENTE'),(709,10,'PENDENTE'),
(710,8,'PENDENTE'),(710,9,'PENDENTE'),(710,10,'PENDENTE'),(710,1,'PENDENTE'),
(711,9,'PENDENTE'),(711,10,'PENDENTE'),(711,1,'PENDENTE'),(711,2,'PENDENTE'),
(712,10,'PENDENTE'),(712,1,'PENDENTE'),(712,2,'PENDENTE'),(712,3,'PENDENTE'),
(713,1,'PENDENTE'),(713,2,'PENDENTE'),(713,3,'PENDENTE'),(713,4,'PENDENTE'),
(714,2,'PENDENTE'),(714,3,'PENDENTE'),(714,4,'PENDENTE'),(714,5,'PENDENTE'),
(715,3,'PENDENTE'),(715,4,'PENDENTE'),(715,5,'PENDENTE'),(715,6,'PENDENTE'),
(716,4,'PENDENTE'),(716,5,'PENDENTE'),(716,6,'PENDENTE'),(716,7,'PENDENTE'),
(717,5,'PENDENTE'),(717,6,'PENDENTE'),(717,7,'PENDENTE'),(717,8,'PENDENTE'),
(718,6,'PENDENTE'),(718,7,'PENDENTE'),(718,8,'PENDENTE'),(718,9,'PENDENTE'),
(719,7,'PENDENTE'),(719,8,'PENDENTE'),(719,9,'PENDENTE'),(719,10,'PENDENTE'),
(720,8,'PENDENTE'),(720,9,'PENDENTE'),(720,10,'PENDENTE'),(720,1,'PENDENTE'),
(721,9,'PENDENTE'),(721,10,'PENDENTE'),(721,1,'PENDENTE'),(721,2,'PENDENTE'),
(722,10,'PENDENTE'),(722,1,'PENDENTE'),(722,2,'PENDENTE'),(722,3,'PENDENTE'),
(723,1,'PENDENTE'),(723,2,'PENDENTE'),(723,3,'PENDENTE'),(723,4,'PENDENTE'),
(724,2,'PENDENTE'),(724,3,'PENDENTE'),(724,4,'PENDENTE'),(724,5,'PENDENTE'),
(725,3,'PENDENTE'),(725,4,'PENDENTE'),(725,5,'PENDENTE'),(725,6,'PENDENTE'),
(726,4,'PENDENTE'),(726,5,'PENDENTE'),(726,6,'PENDENTE'),(726,7,'PENDENTE'),
(727,5,'PENDENTE'),(727,6,'PENDENTE'),(727,7,'PENDENTE'),(727,8,'PENDENTE'),
(728,6,'PENDENTE'),(728,7,'PENDENTE'),(728,8,'PENDENTE'),(728,9,'PENDENTE'),
(729,7,'PENDENTE'),(729,8,'PENDENTE'),(729,9,'PENDENTE'),(729,10,'PENDENTE'),
(730,8,'PENDENTE'),(730,9,'PENDENTE'),(730,10,'PENDENTE'),(730,1,'PENDENTE'),
(731,9,'PENDENTE'),(731,10,'PENDENTE'),(731,1,'PENDENTE'),(731,2,'PENDENTE'),
(732,10,'PENDENTE'),(732,1,'PENDENTE'),(732,2,'PENDENTE'),(732,3,'PENDENTE'),
(733,1,'PENDENTE'),(733,2,'PENDENTE'),(733,3,'PENDENTE'),(733,4,'PENDENTE'),
(734,2,'PENDENTE'),(734,3,'PENDENTE'),(734,4,'PENDENTE'),(734,5,'PENDENTE'),
(735,3,'PENDENTE'),(735,4,'PENDENTE'),(735,5,'PENDENTE'),(735,6,'PENDENTE'),
(736,4,'PENDENTE'),(736,5,'PENDENTE'),(736,6,'PENDENTE'),(736,7,'PENDENTE'),
(737,5,'PENDENTE'),(737,6,'PENDENTE'),(737,7,'PENDENTE'),(737,8,'PENDENTE'),
(738,6,'PENDENTE'),(738,7,'PENDENTE'),(738,8,'PENDENTE'),(738,9,'PENDENTE'),
(739,7,'PENDENTE'),(739,8,'PENDENTE'),(739,9,'PENDENTE'),(739,10,'PENDENTE'),
(740,8,'PENDENTE'),(740,9,'PENDENTE'),(740,10,'PENDENTE'),(740,1,'PENDENTE'),
(741,9,'PENDENTE'),(741,10,'PENDENTE'),(741,1,'PENDENTE'),(741,2,'PENDENTE'),
(742,10,'PENDENTE'),(742,1,'PENDENTE'),(742,2,'PENDENTE'),(742,3,'PENDENTE'),
(743,1,'PENDENTE'),(743,2,'PENDENTE'),(743,3,'PENDENTE'),(743,4,'PENDENTE'),
(744,2,'PENDENTE'),(744,3,'PENDENTE'),(744,4,'PENDENTE'),(744,5,'PENDENTE'),
(745,3,'PENDENTE'),(745,4,'PENDENTE'),(745,5,'PENDENTE'),(745,6,'PENDENTE'),
(746,4,'PENDENTE'),(746,5,'PENDENTE'),(746,6,'PENDENTE'),(746,7,'PENDENTE'),
(747,5,'PENDENTE'),(747,6,'PENDENTE'),(747,7,'PENDENTE'),(747,8,'PENDENTE'),
(748,6,'PENDENTE'),(748,7,'PENDENTE'),(748,8,'PENDENTE'),(748,9,'PENDENTE'),
(749,7,'PENDENTE'),(749,8,'PENDENTE'),(749,9,'PENDENTE'),(749,10,'PENDENTE'),
(750,8,'PENDENTE'),(750,9,'PENDENTE'),(750,10,'PENDENTE'),(750,1,'PENDENTE'),
(751,9,'PENDENTE'),(751,10,'PENDENTE'),(751,1,'PENDENTE'),(751,2,'PENDENTE'),
(752,10,'PENDENTE'),(752,1,'PENDENTE'),(752,2,'PENDENTE'),(752,3,'PENDENTE'),
(753,1,'PENDENTE'),(753,2,'PENDENTE'),(753,3,'PENDENTE'),(753,4,'PENDENTE'),
(754,2,'PENDENTE'),(754,3,'PENDENTE'),(754,4,'PENDENTE'),(754,5,'PENDENTE'),
(755,3,'PENDENTE'),(755,4,'PENDENTE'),(755,5,'PENDENTE'),(755,6,'PENDENTE'),
(756,4,'PENDENTE'),(756,5,'PENDENTE'),(756,6,'PENDENTE'),(756,7,'PENDENTE'),
(757,5,'PENDENTE'),(757,6,'PENDENTE'),(757,7,'PENDENTE'),(757,8,'PENDENTE'),
(758,6,'PENDENTE'),(758,7,'PENDENTE'),(758,8,'PENDENTE'),(758,9,'PENDENTE'),
(759,7,'PENDENTE'),(759,8,'PENDENTE'),(759,9,'PENDENTE'),(759,10,'PENDENTE'),
(760,8,'PENDENTE'),(760,9,'PENDENTE'),(760,10,'PENDENTE'),(760,1,'PENDENTE'),
(761,9,'PENDENTE'),(761,10,'PENDENTE'),(761,1,'PENDENTE'),(761,2,'PENDENTE'),
(762,10,'PENDENTE'),(762,1,'PENDENTE'),(762,2,'PENDENTE'),(762,3,'PENDENTE'),
(763,1,'PENDENTE'),(763,2,'PENDENTE'),(763,3,'PENDENTE'),(763,4,'PENDENTE'),
(764,2,'PENDENTE'),(764,3,'PENDENTE'),(764,4,'PENDENTE'),(764,5,'PENDENTE'),
(765,3,'PENDENTE'),(765,4,'PENDENTE'),(765,5,'PENDENTE'),(765,6,'PENDENTE'),
(766,4,'PENDENTE'),(766,5,'PENDENTE'),(766,6,'PENDENTE'),(766,7,'PENDENTE'),
(767,5,'PENDENTE'),(767,6,'PENDENTE'),(767,7,'PENDENTE'),(767,8,'PENDENTE'),
(768,6,'PENDENTE'),(768,7,'PENDENTE'),(768,8,'PENDENTE'),(768,9,'PENDENTE'),
(769,7,'PENDENTE'),(769,8,'PENDENTE'),(769,9,'PENDENTE'),(769,10,'PENDENTE'),
(770,8,'PENDENTE'),(770,9,'PENDENTE'),(770,10,'PENDENTE'),(770,1,'PENDENTE'),
(771,9,'PENDENTE'),(771,10,'PENDENTE'),(771,1,'PENDENTE'),(771,2,'PENDENTE'),
(772,10,'PENDENTE'),(772,1,'PENDENTE'),(772,2,'PENDENTE'),(772,3,'PENDENTE'),
(773,1,'PENDENTE'),(773,2,'PENDENTE'),(773,3,'PENDENTE'),(773,4,'PENDENTE'),
(774,2,'PENDENTE'),(774,3,'PENDENTE'),(774,4,'PENDENTE'),(774,5,'PENDENTE'),
(775,3,'PENDENTE'),(775,4,'PENDENTE'),(775,5,'PENDENTE'),(775,6,'PENDENTE'),
(776,4,'PENDENTE'),(776,5,'PENDENTE'),(776,6,'PENDENTE'),(776,7,'PENDENTE'),
(777,5,'PENDENTE'),(777,6,'PENDENTE'),(777,7,'PENDENTE'),(777,8,'PENDENTE'),
(778,6,'PENDENTE'),(778,7,'PENDENTE'),(778,8,'PENDENTE'),(778,9,'PENDENTE'),
(779,7,'PENDENTE'),(779,8,'PENDENTE'),(779,9,'PENDENTE'),(779,10,'PENDENTE'),
(780,8,'PENDENTE'),(780,9,'PENDENTE'),(780,10,'PENDENTE'),(780,1,'PENDENTE'),
(781,9,'PENDENTE'),(781,10,'PENDENTE'),(781,1,'PENDENTE'),(781,2,'PENDENTE'),
(782,10,'PENDENTE'),(782,1,'PENDENTE'),(782,2,'PENDENTE'),(782,3,'PENDENTE'),
(783,1,'PENDENTE'),(783,2,'PENDENTE'),(783,3,'PENDENTE'),(783,4,'PENDENTE'),
(784,2,'PENDENTE'),(784,3,'PENDENTE'),(784,4,'PENDENTE'),(784,5,'PENDENTE'),
(785,3,'PENDENTE'),(785,4,'PENDENTE'),(785,5,'PENDENTE'),(785,6,'PENDENTE'),
(786,4,'PENDENTE'),(786,5,'PENDENTE'),(786,6,'PENDENTE'),(786,7,'PENDENTE'),
(787,5,'PENDENTE'),(787,6,'PENDENTE'),(787,7,'PENDENTE'),(787,8,'PENDENTE'),
(788,6,'PENDENTE'),(788,7,'PENDENTE'),(788,8,'PENDENTE'),(788,9,'PENDENTE'),
(789,7,'PENDENTE'),(789,8,'PENDENTE'),(789,9,'PENDENTE'),(789,10,'PENDENTE'),
(790,8,'PENDENTE'),(790,9,'PENDENTE'),(790,10,'PENDENTE'),(790,1,'PENDENTE'),
(791,9,'PENDENTE'),(791,10,'PENDENTE'),(791,1,'PENDENTE'),(791,2,'PENDENTE'),
(792,10,'PENDENTE'),(792,1,'PENDENTE'),(792,2,'PENDENTE'),(792,3,'PENDENTE'),
(793,1,'PENDENTE'),(793,2,'PENDENTE'),(793,3,'PENDENTE'),(793,4,'PENDENTE'),
(794,2,'PENDENTE'),(794,3,'PENDENTE'),(794,4,'PENDENTE'),(794,5,'PENDENTE'),
(795,3,'PENDENTE'),(795,4,'PENDENTE'),(795,5,'PENDENTE'),(795,6,'PENDENTE'),
(796,4,'PENDENTE'),(796,5,'PENDENTE'),(796,6,'PENDENTE'),(796,7,'PENDENTE'),
(797,5,'PENDENTE'),(797,6,'PENDENTE'),(797,7,'PENDENTE'),(797,8,'PENDENTE'),
(798,6,'PENDENTE'),(798,7,'PENDENTE'),(798,8,'PENDENTE'),(798,9,'PENDENTE'),
(799,7,'PENDENTE'),(799,8,'PENDENTE'),(799,9,'PENDENTE'),(799,10,'PENDENTE'),
(800,8,'PENDENTE'),(800,9,'PENDENTE'),(800,10,'PENDENTE'),(800,1,'PENDENTE'),
(801,9,'PENDENTE'),(801,10,'PENDENTE'),(801,1,'PENDENTE'),(801,2,'PENDENTE'),
(802,10,'PENDENTE'),(802,1,'PENDENTE'),(802,2,'PENDENTE'),(802,3,'PENDENTE'),
(803,1,'PENDENTE'),(803,2,'PENDENTE'),(803,3,'PENDENTE'),(803,4,'PENDENTE'),
(804,2,'PENDENTE'),(804,3,'PENDENTE'),(804,4,'PENDENTE'),(804,5,'PENDENTE'),
(805,3,'PENDENTE'),(805,4,'PENDENTE'),(805,5,'PENDENTE'),(805,6,'PENDENTE'),
(806,4,'PENDENTE'),(806,5,'PENDENTE'),(806,6,'PENDENTE'),(806,7,'PENDENTE'),
(807,5,'PENDENTE'),(807,6,'PENDENTE'),(807,7,'PENDENTE'),(807,8,'PENDENTE'),
(808,6,'PENDENTE'),(808,7,'PENDENTE'),(808,8,'PENDENTE'),(808,9,'PENDENTE'),
(809,7,'PENDENTE'),(809,8,'PENDENTE'),(809,9,'PENDENTE'),(809,10,'PENDENTE'),
(810,8,'PENDENTE'),(810,9,'PENDENTE'),(810,10,'PENDENTE'),(810,1,'PENDENTE'),
(811,9,'PENDENTE'),(811,10,'PENDENTE'),(811,1,'PENDENTE'),(811,2,'PENDENTE'),
(812,10,'PENDENTE'),(812,1,'PENDENTE'),(812,2,'PENDENTE'),(812,3,'PENDENTE'),
(813,1,'PENDENTE'),(813,2,'PENDENTE'),(813,3,'PENDENTE'),(813,4,'PENDENTE'),
(814,2,'PENDENTE'),(814,3,'PENDENTE'),(814,4,'PENDENTE'),(814,5,'PENDENTE'),
(815,3,'PENDENTE'),(815,4,'PENDENTE'),(815,5,'PENDENTE'),(815,6,'PENDENTE'),
(816,4,'PENDENTE'),(816,5,'PENDENTE'),(816,6,'PENDENTE'),(816,7,'PENDENTE'),
(817,5,'PENDENTE'),(817,6,'PENDENTE'),(817,7,'PENDENTE'),(817,8,'PENDENTE'),
(818,6,'PENDENTE'),(818,7,'PENDENTE'),(818,8,'PENDENTE'),(818,9,'PENDENTE'),
(819,7,'PENDENTE'),(819,8,'PENDENTE'),(819,9,'PENDENTE'),(819,10,'PENDENTE'),
(820,8,'PENDENTE'),(820,9,'PENDENTE'),(820,10,'PENDENTE'),(820,1,'PENDENTE'),
(821,9,'PENDENTE'),(821,10,'PENDENTE'),(821,1,'PENDENTE'),(821,2,'PENDENTE'),
(822,10,'PENDENTE'),(822,1,'PENDENTE'),(822,2,'PENDENTE'),(822,3,'PENDENTE'),
(823,1,'PENDENTE'),(823,2,'PENDENTE'),(823,3,'PENDENTE'),(823,4,'PENDENTE'),
(824,2,'PENDENTE'),(824,3,'PENDENTE'),(824,4,'PENDENTE'),(824,5,'PENDENTE'),
(825,3,'PENDENTE'),(825,4,'PENDENTE'),(825,5,'PENDENTE'),(825,6,'PENDENTE'),
(826,4,'PENDENTE'),(826,5,'PENDENTE'),(826,6,'PENDENTE'),(826,7,'PENDENTE'),
(827,5,'PENDENTE'),(827,6,'PENDENTE'),(827,7,'PENDENTE'),(827,8,'PENDENTE'),
(828,6,'PENDENTE'),(828,7,'PENDENTE'),(828,8,'PENDENTE'),(828,9,'PENDENTE'),
(829,7,'PENDENTE'),(829,8,'PENDENTE'),(829,9,'PENDENTE'),(829,10,'PENDENTE'),
(830,8,'PENDENTE'),(830,9,'PENDENTE'),(830,10,'PENDENTE'),(830,1,'PENDENTE'),
(831,9,'PENDENTE'),(831,10,'PENDENTE'),(831,1,'PENDENTE'),(831,2,'PENDENTE'),
(832,10,'PENDENTE'),(832,1,'PENDENTE'),(832,2,'PENDENTE'),(832,3,'PENDENTE'),
(833,1,'PENDENTE'),(833,2,'PENDENTE'),(833,3,'PENDENTE'),(833,4,'PENDENTE'),
(834,2,'PENDENTE'),(834,3,'PENDENTE'),(834,4,'PENDENTE'),(834,5,'PENDENTE'),
(835,3,'PENDENTE'),(835,4,'PENDENTE'),(835,5,'PENDENTE'),(835,6,'PENDENTE'),
(836,4,'PENDENTE'),(836,5,'PENDENTE'),(836,6,'PENDENTE'),(836,7,'PENDENTE'),
(837,5,'PENDENTE'),(837,6,'PENDENTE'),(837,7,'PENDENTE'),(837,8,'PENDENTE'),
(838,6,'PENDENTE'),(838,7,'PENDENTE'),(838,8,'PENDENTE'),(838,9,'PENDENTE'),
(839,7,'PENDENTE'),(839,8,'PENDENTE'),(839,9,'PENDENTE'),(839,10,'PENDENTE'),
(840,8,'PENDENTE'),(840,9,'PENDENTE'),(840,10,'PENDENTE'),(840,1,'PENDENTE'),
(841,9,'PENDENTE'),(841,10,'PENDENTE'),(841,1,'PENDENTE'),(841,2,'PENDENTE'),
(842,10,'PENDENTE'),(842,1,'PENDENTE'),(842,2,'PENDENTE'),(842,3,'PENDENTE'),
(843,1,'PENDENTE'),(843,2,'PENDENTE'),(843,3,'PENDENTE'),(843,4,'PENDENTE'),
(844,2,'PENDENTE'),(844,3,'PENDENTE'),(844,4,'PENDENTE'),(844,5,'PENDENTE'),
(845,3,'PENDENTE'),(845,4,'PENDENTE'),(845,5,'PENDENTE'),(845,6,'PENDENTE'),
(846,4,'PENDENTE'),(846,5,'PENDENTE'),(846,6,'PENDENTE'),(846,7,'PENDENTE'),
(847,5,'PENDENTE'),(847,6,'PENDENTE'),(847,7,'PENDENTE'),(847,8,'PENDENTE'),
(848,6,'PENDENTE'),(848,7,'PENDENTE'),(848,8,'PENDENTE'),(848,9,'PENDENTE'),
(849,7,'PENDENTE'),(849,8,'PENDENTE'),(849,9,'PENDENTE'),(849,10,'PENDENTE'),
(850,8,'PENDENTE'),(850,9,'PENDENTE'),(850,10,'PENDENTE'),(850,1,'PENDENTE'),
(851,9,'PENDENTE'),(851,10,'PENDENTE'),(851,1,'PENDENTE'),(851,2,'PENDENTE'),
(852,10,'PENDENTE'),(852,1,'PENDENTE'),(852,2,'PENDENTE'),(852,3,'PENDENTE'),
(853,1,'PENDENTE'),(853,2,'PENDENTE'),(853,3,'PENDENTE'),(853,4,'PENDENTE'),
(854,2,'PENDENTE'),(854,3,'PENDENTE'),(854,4,'PENDENTE'),(854,5,'PENDENTE'),
(855,3,'PENDENTE'),(855,4,'PENDENTE'),(855,5,'PENDENTE'),(855,6,'PENDENTE'),
(856,4,'PENDENTE'),(856,5,'PENDENTE'),(856,6,'PENDENTE'),(856,7,'PENDENTE'),
(857,5,'PENDENTE'),(857,6,'PENDENTE'),(857,7,'PENDENTE'),(857,8,'PENDENTE'),
(858,6,'PENDENTE'),(858,7,'PENDENTE'),(858,8,'PENDENTE'),(858,9,'PENDENTE'),
(859,7,'PENDENTE'),(859,8,'PENDENTE'),(859,9,'PENDENTE'),(859,10,'PENDENTE'),
(860,8,'PENDENTE'),(860,9,'PENDENTE'),(860,10,'PENDENTE'),(860,1,'PENDENTE'),
(861,9,'PENDENTE'),(861,10,'PENDENTE'),(861,1,'PENDENTE'),(861,2,'PENDENTE'),
(862,10,'PENDENTE'),(862,1,'PENDENTE'),(862,2,'PENDENTE'),(862,3,'PENDENTE'),
(863,1,'PENDENTE'),(863,2,'PENDENTE'),(863,3,'PENDENTE'),(863,4,'PENDENTE'),
(864,2,'PENDENTE'),(864,3,'PENDENTE'),(864,4,'PENDENTE'),(864,5,'PENDENTE'),
(865,3,'PENDENTE'),(865,4,'PENDENTE'),(865,5,'PENDENTE'),(865,6,'PENDENTE'),
(866,4,'PENDENTE'),(866,5,'PENDENTE'),(866,6,'PENDENTE'),(866,7,'PENDENTE'),
(867,5,'PENDENTE'),(867,6,'PENDENTE'),(867,7,'PENDENTE'),(867,8,'PENDENTE'),
(868,6,'PENDENTE'),(868,7,'PENDENTE'),(868,8,'PENDENTE'),(868,9,'PENDENTE'),
(869,7,'PENDENTE'),(869,8,'PENDENTE'),(869,9,'PENDENTE'),(869,10,'PENDENTE'),
(870,8,'PENDENTE'),(870,9,'PENDENTE'),(870,10,'PENDENTE'),(870,1,'PENDENTE'),
(871,9,'PENDENTE'),(871,10,'PENDENTE'),(871,1,'PENDENTE'),(871,2,'PENDENTE'),
(872,10,'PENDENTE'),(872,1,'PENDENTE'),(872,2,'PENDENTE'),(872,3,'PENDENTE'),
(873,1,'PENDENTE'),(873,2,'PENDENTE'),(873,3,'PENDENTE'),(873,4,'PENDENTE'),
(874,2,'PENDENTE'),(874,3,'PENDENTE'),(874,4,'PENDENTE'),(874,5,'PENDENTE'),
(875,3,'PENDENTE'),(875,4,'PENDENTE'),(875,5,'PENDENTE'),(875,6,'PENDENTE'),
(876,4,'PENDENTE'),(876,5,'PENDENTE'),(876,6,'PENDENTE'),(876,7,'PENDENTE'),
(877,5,'PENDENTE'),(877,6,'PENDENTE'),(877,7,'PENDENTE'),(877,8,'PENDENTE'),
(878,6,'PENDENTE'),(878,7,'PENDENTE'),(878,8,'PENDENTE'),(878,9,'PENDENTE'),
(879,7,'PENDENTE'),(879,8,'PENDENTE'),(879,9,'PENDENTE'),(879,10,'PENDENTE'),
(880,8,'PENDENTE'),(880,9,'PENDENTE'),(880,10,'PENDENTE'),(880,1,'PENDENTE'),
(881,9,'PENDENTE'),(881,10,'PENDENTE'),(881,1,'PENDENTE'),(881,2,'PENDENTE'),
(882,10,'PENDENTE'),(882,1,'PENDENTE'),(882,2,'PENDENTE'),(882,3,'PENDENTE'),
(883,1,'PENDENTE'),(883,2,'PENDENTE'),(883,3,'PENDENTE'),(883,4,'PENDENTE'),
(884,2,'PENDENTE'),(884,3,'PENDENTE'),(884,4,'PENDENTE'),(884,5,'PENDENTE'),
(885,3,'PENDENTE'),(885,4,'PENDENTE'),(885,5,'PENDENTE'),(885,6,'PENDENTE'),
(886,4,'PENDENTE'),(886,5,'PENDENTE'),(886,6,'PENDENTE'),(886,7,'PENDENTE'),
(887,5,'PENDENTE'),(887,6,'PENDENTE'),(887,7,'PENDENTE'),(887,8,'PENDENTE'),
(888,6,'PENDENTE'),(888,7,'PENDENTE'),(888,8,'PENDENTE'),(888,9,'PENDENTE'),
(889,7,'PENDENTE'),(889,8,'PENDENTE'),(889,9,'PENDENTE'),(889,10,'PENDENTE'),
(890,8,'PENDENTE'),(890,9,'PENDENTE'),(890,10,'PENDENTE'),(890,1,'PENDENTE'),
(891,9,'PENDENTE'),(891,10,'PENDENTE'),(891,1,'PENDENTE'),(891,2,'PENDENTE'),
(892,10,'PENDENTE'),(892,1,'PENDENTE'),(892,2,'PENDENTE'),(892,3,'PENDENTE'),
(893,1,'PENDENTE'),(893,2,'PENDENTE'),(893,3,'PENDENTE'),(893,4,'PENDENTE'),
(894,2,'PENDENTE'),(894,3,'PENDENTE'),(894,4,'PENDENTE'),(894,5,'PENDENTE'),
(895,3,'PENDENTE'),(895,4,'PENDENTE'),(895,5,'PENDENTE'),(895,6,'PENDENTE'),
(896,4,'PENDENTE'),(896,5,'PENDENTE'),(896,6,'PENDENTE'),(896,7,'PENDENTE'),
(897,5,'PENDENTE'),(897,6,'PENDENTE'),(897,7,'PENDENTE'),(897,8,'PENDENTE'),
(898,6,'PENDENTE'),(898,7,'PENDENTE'),(898,8,'PENDENTE'),(898,9,'PENDENTE'),
(899,7,'PENDENTE'),(899,8,'PENDENTE'),(899,9,'PENDENTE'),(899,10,'PENDENTE'),
(900,8,'PENDENTE'),(900,9,'PENDENTE'),(900,10,'PENDENTE'),(900,1,'PENDENTE'),
(901,9,'PENDENTE'),(901,10,'PENDENTE'),(901,1,'PENDENTE'),(901,2,'PENDENTE'),
(902,10,'PENDENTE'),(902,1,'PENDENTE'),(902,2,'PENDENTE'),(902,3,'PENDENTE'),
(903,1,'PENDENTE'),(903,2,'PENDENTE'),(903,3,'PENDENTE'),(903,4,'PENDENTE'),
(904,2,'PENDENTE'),(904,3,'PENDENTE'),(904,4,'PENDENTE'),(904,5,'PENDENTE'),
(905,3,'PENDENTE'),(905,4,'PENDENTE'),(905,5,'PENDENTE'),(905,6,'PENDENTE'),
(906,4,'PENDENTE'),(906,5,'PENDENTE'),(906,6,'PENDENTE'),(906,7,'PENDENTE'),
(907,5,'PENDENTE'),(907,6,'PENDENTE'),(907,7,'PENDENTE'),(907,8,'PENDENTE'),
(908,6,'PENDENTE'),(908,7,'PENDENTE'),(908,8,'PENDENTE'),(908,9,'PENDENTE'),
(909,7,'PENDENTE'),(909,8,'PENDENTE'),(909,9,'PENDENTE'),(909,10,'PENDENTE'),
(910,8,'PENDENTE'),(910,9,'PENDENTE'),(910,10,'PENDENTE'),(910,1,'PENDENTE'),
(911,9,'PENDENTE'),(911,10,'PENDENTE'),(911,1,'PENDENTE'),(911,2,'PENDENTE'),
(912,10,'PENDENTE'),(912,1,'PENDENTE'),(912,2,'PENDENTE'),(912,3,'PENDENTE'),
(913,1,'PENDENTE'),(913,2,'PENDENTE'),(913,3,'PENDENTE'),(913,4,'PENDENTE'),
(914,2,'PENDENTE'),(914,3,'PENDENTE'),(914,4,'PENDENTE'),(914,5,'PENDENTE'),
(915,3,'PENDENTE'),(915,4,'PENDENTE'),(915,5,'PENDENTE'),(915,6,'PENDENTE'),
(916,4,'PENDENTE'),(916,5,'PENDENTE'),(916,6,'PENDENTE'),(916,7,'PENDENTE'),
(917,5,'PENDENTE'),(917,6,'PENDENTE'),(917,7,'PENDENTE'),(917,8,'PENDENTE'),
(918,6,'PENDENTE'),(918,7,'PENDENTE'),(918,8,'PENDENTE'),(918,9,'PENDENTE'),
(919,7,'PENDENTE'),(919,8,'PENDENTE'),(919,9,'PENDENTE'),(919,10,'PENDENTE'),
(920,8,'PENDENTE'),(920,9,'PENDENTE'),(920,10,'PENDENTE'),(920,1,'PENDENTE'),
(921,9,'PENDENTE'),(921,10,'PENDENTE'),(921,1,'PENDENTE'),(921,2,'PENDENTE'),
(922,10,'PENDENTE'),(922,1,'PENDENTE'),(922,2,'PENDENTE'),(922,3,'PENDENTE'),
(923,1,'PENDENTE'),(923,2,'PENDENTE'),(923,3,'PENDENTE'),(923,4,'PENDENTE'),
(924,2,'PENDENTE'),(924,3,'PENDENTE'),(924,4,'PENDENTE'),(924,5,'PENDENTE'),
(925,3,'PENDENTE'),(925,4,'PENDENTE'),(925,5,'PENDENTE'),(925,6,'PENDENTE'),
(926,4,'PENDENTE'),(926,5,'PENDENTE'),(926,6,'PENDENTE'),(926,7,'PENDENTE'),
(927,5,'PENDENTE'),(927,6,'PENDENTE'),(927,7,'PENDENTE'),(927,8,'PENDENTE'),
(928,6,'PENDENTE'),(928,7,'PENDENTE'),(928,8,'PENDENTE'),(928,9,'PENDENTE'),
(929,7,'PENDENTE'),(929,8,'PENDENTE'),(929,9,'PENDENTE'),(929,10,'PENDENTE'),
(930,8,'PENDENTE'),(930,9,'PENDENTE'),(930,10,'PENDENTE'),(930,1,'PENDENTE'),
(931,9,'PENDENTE'),(931,10,'PENDENTE'),(931,1,'PENDENTE'),(931,2,'PENDENTE'),
(932,10,'PENDENTE'),(932,1,'PENDENTE'),(932,2,'PENDENTE'),(932,3,'PENDENTE'),
(933,1,'PENDENTE'),(933,2,'PENDENTE'),(933,3,'PENDENTE'),(933,4,'PENDENTE'),
(934,2,'PENDENTE'),(934,3,'PENDENTE'),(934,4,'PENDENTE'),(934,5,'PENDENTE'),
(935,3,'PENDENTE'),(935,4,'PENDENTE'),(935,5,'PENDENTE'),(935,6,'PENDENTE'),
(936,4,'PENDENTE'),(936,5,'PENDENTE'),(936,6,'PENDENTE'),(936,7,'PENDENTE'),
(937,5,'PENDENTE'),(937,6,'PENDENTE'),(937,7,'PENDENTE'),(937,8,'PENDENTE'),
(938,6,'PENDENTE'),(938,7,'PENDENTE'),(938,8,'PENDENTE'),(938,9,'PENDENTE'),
(939,7,'PENDENTE'),(939,8,'PENDENTE'),(939,9,'PENDENTE'),(939,10,'PENDENTE'),
(940,8,'PENDENTE'),(940,9,'PENDENTE'),(940,10,'PENDENTE'),(940,1,'PENDENTE'),
(941,9,'PENDENTE'),(941,10,'PENDENTE'),(941,1,'PENDENTE'),(941,2,'PENDENTE'),
(942,10,'PENDENTE'),(942,1,'PENDENTE'),(942,2,'PENDENTE'),(942,3,'PENDENTE'),
(943,1,'PENDENTE'),(943,2,'PENDENTE'),(943,3,'PENDENTE'),(943,4,'PENDENTE'),
(944,2,'PENDENTE'),(944,3,'PENDENTE'),(944,4,'PENDENTE'),(944,5,'PENDENTE'),
(945,3,'PENDENTE'),(945,4,'PENDENTE'),(945,5,'PENDENTE'),(945,6,'PENDENTE'),
(946,4,'PENDENTE'),(946,5,'PENDENTE'),(946,6,'PENDENTE'),(946,7,'PENDENTE'),
(947,5,'PENDENTE'),(947,6,'PENDENTE'),(947,7,'PENDENTE'),(947,8,'PENDENTE'),
(948,6,'PENDENTE'),(948,7,'PENDENTE'),(948,8,'PENDENTE'),(948,9,'PENDENTE'),
(949,7,'PENDENTE'),(949,8,'PENDENTE'),(949,9,'PENDENTE'),(949,10,'PENDENTE'),
(950,8,'PENDENTE'),(950,9,'PENDENTE'),(950,10,'PENDENTE'),(950,1,'PENDENTE'),
(951,9,'PENDENTE'),(951,10,'PENDENTE'),(951,1,'PENDENTE'),(951,2,'PENDENTE'),
(952,10,'PENDENTE'),(952,1,'PENDENTE'),(952,2,'PENDENTE'),(952,3,'PENDENTE'),
(953,1,'PENDENTE'),(953,2,'PENDENTE'),(953,3,'PENDENTE'),(953,4,'PENDENTE'),
(954,2,'PENDENTE'),(954,3,'PENDENTE'),(954,4,'PENDENTE'),(954,5,'PENDENTE'),
(955,3,'PENDENTE'),(955,4,'PENDENTE'),(955,5,'PENDENTE'),(955,6,'PENDENTE'),
(956,4,'PENDENTE'),(956,5,'PENDENTE'),(956,6,'PENDENTE'),(956,7,'PENDENTE'),
(957,5,'PENDENTE'),(957,6,'PENDENTE'),(957,7,'PENDENTE'),(957,8,'PENDENTE'),
(958,6,'PENDENTE'),(958,7,'PENDENTE'),(958,8,'PENDENTE'),(958,9,'PENDENTE'),
(959,7,'PENDENTE'),(959,8,'PENDENTE'),(959,9,'PENDENTE'),(959,10,'PENDENTE'),
(960,8,'PENDENTE'),(960,9,'PENDENTE'),(960,10,'PENDENTE'),(960,1,'PENDENTE'),
(961,9,'PENDENTE'),(961,10,'PENDENTE'),(961,1,'PENDENTE'),(961,2,'PENDENTE'),
(962,10,'PENDENTE'),(962,1,'PENDENTE'),(962,2,'PENDENTE'),(962,3,'PENDENTE'),
(963,1,'PENDENTE'),(963,2,'PENDENTE'),(963,3,'PENDENTE'),(963,4,'PENDENTE'),
(964,2,'PENDENTE'),(964,3,'PENDENTE'),(964,4,'PENDENTE'),(964,5,'PENDENTE'),
(965,3,'PENDENTE'),(965,4,'PENDENTE'),(965,5,'PENDENTE'),(965,6,'PENDENTE'),
(966,4,'PENDENTE'),(966,5,'PENDENTE'),(966,6,'PENDENTE'),(966,7,'PENDENTE'),
(967,5,'PENDENTE'),(967,6,'PENDENTE'),(967,7,'PENDENTE'),(967,8,'PENDENTE'),
(968,6,'PENDENTE'),(968,7,'PENDENTE'),(968,8,'PENDENTE'),(968,9,'PENDENTE'),
(969,7,'PENDENTE'),(969,8,'PENDENTE'),(969,9,'PENDENTE'),(969,10,'PENDENTE'),
(970,8,'PENDENTE'),(970,9,'PENDENTE'),(970,10,'PENDENTE'),(970,1,'PENDENTE'),
(971,9,'PENDENTE'),(971,10,'PENDENTE'),(971,1,'PENDENTE'),(971,2,'PENDENTE'),
(972,10,'PENDENTE'),(972,1,'PENDENTE'),(972,2,'PENDENTE'),(972,3,'PENDENTE'),
(973,1,'PENDENTE'),(973,2,'PENDENTE'),(973,3,'PENDENTE'),(973,4,'PENDENTE'),
(974,2,'PENDENTE'),(974,3,'PENDENTE'),(974,4,'PENDENTE'),(974,5,'PENDENTE'),
(975,3,'PENDENTE'),(975,4,'PENDENTE'),(975,5,'PENDENTE'),(975,6,'PENDENTE'),
(976,4,'PENDENTE'),(976,5,'PENDENTE'),(976,6,'PENDENTE'),(976,7,'PENDENTE'),
(977,5,'PENDENTE'),(977,6,'PENDENTE'),(977,7,'PENDENTE'),(977,8,'PENDENTE'),
(978,6,'PENDENTE'),(978,7,'PENDENTE'),(978,8,'PENDENTE'),(978,9,'PENDENTE'),
(979,7,'PENDENTE'),(979,8,'PENDENTE'),(979,9,'PENDENTE'),(979,10,'PENDENTE'),
(980,8,'PENDENTE'),(980,9,'PENDENTE'),(980,10,'PENDENTE'),(980,1,'PENDENTE'),
(981,9,'PENDENTE'),(981,10,'PENDENTE'),(981,1,'PENDENTE'),(981,2,'PENDENTE'),
(982,10,'PENDENTE'),(982,1,'PENDENTE'),(982,2,'PENDENTE'),(982,3,'PENDENTE'),
(983,1,'PENDENTE'),(983,2,'PENDENTE'),(983,3,'PENDENTE'),(983,4,'PENDENTE'),
(984,2,'PENDENTE'),(984,3,'PENDENTE'),(984,4,'PENDENTE'),(984,5,'PENDENTE'),
(985,3,'PENDENTE'),(985,4,'PENDENTE'),(985,5,'PENDENTE'),(985,6,'PENDENTE'),
(986,4,'PENDENTE'),(986,5,'PENDENTE'),(986,6,'PENDENTE'),(986,7,'PENDENTE'),
(987,5,'PENDENTE'),(987,6,'PENDENTE'),(987,7,'PENDENTE'),(987,8,'PENDENTE'),
(988,6,'PENDENTE'),(988,7,'PENDENTE'),(988,8,'PENDENTE'),(988,9,'PENDENTE'),
(989,7,'PENDENTE'),(989,8,'PENDENTE'),(989,9,'PENDENTE'),(989,10,'PENDENTE'),
(990,8,'PENDENTE'),(990,9,'PENDENTE'),(990,10,'PENDENTE'),(990,1,'PENDENTE'),
(991,9,'PENDENTE'),(991,10,'PENDENTE'),(991,1,'PENDENTE'),(991,2,'PENDENTE'),
(992,10,'PENDENTE'),(992,1,'PENDENTE'),(992,2,'PENDENTE'),(992,3,'PENDENTE'),
(993,1,'PENDENTE'),(993,2,'PENDENTE'),(993,3,'PENDENTE'),(993,4,'PENDENTE'),
(994,2,'PENDENTE'),(994,3,'PENDENTE'),(994,4,'PENDENTE'),(994,5,'PENDENTE'),
(995,3,'PENDENTE'),(995,4,'PENDENTE'),(995,5,'PENDENTE'),(995,6,'PENDENTE'),
(996,4,'PENDENTE'),(996,5,'PENDENTE'),(996,6,'PENDENTE'),(996,7,'PENDENTE'),
(997,5,'PENDENTE'),(997,6,'PENDENTE'),(997,7,'PENDENTE'),(997,8,'PENDENTE'),
(998,6,'PENDENTE'),(998,7,'PENDENTE'),(998,8,'PENDENTE'),(998,9,'PENDENTE'),
(999,7,'PENDENTE'),(999,8,'PENDENTE'),(999,9,'PENDENTE'),(999,10,'PENDENTE'),
(1000,8,'PENDENTE'),(1000,9,'PENDENTE'),(1000,10,'PENDENTE'),(1000,1,'PENDENTE'),
(1001,9,'PENDENTE'),(1001,10,'PENDENTE'),(1001,1,'PENDENTE'),(1001,2,'PENDENTE'),
(1002,10,'PENDENTE'),(1002,1,'PENDENTE'),(1002,2,'PENDENTE'),(1002,3,'PENDENTE'),
(1003,1,'PENDENTE'),(1003,2,'PENDENTE'),(1003,3,'PENDENTE'),(1003,4,'PENDENTE'),
(1004,2,'PENDENTE'),(1004,3,'PENDENTE'),(1004,4,'PENDENTE'),(1004,5,'PENDENTE'),
(1005,3,'PENDENTE'),(1005,4,'PENDENTE'),(1005,5,'PENDENTE'),(1005,6,'PENDENTE'),
(1006,4,'PENDENTE'),(1006,5,'PENDENTE'),(1006,6,'PENDENTE'),(1006,7,'PENDENTE'),
(1007,5,'PENDENTE'),(1007,6,'PENDENTE'),(1007,7,'PENDENTE'),(1007,8,'PENDENTE'),
(1008,6,'PENDENTE'),(1008,7,'PENDENTE'),(1008,8,'PENDENTE'),(1008,9,'PENDENTE'),
(1009,7,'PENDENTE'),(1009,8,'PENDENTE'),(1009,9,'PENDENTE'),(1009,10,'PENDENTE'),
(1010,8,'PENDENTE'),(1010,9,'PENDENTE'),(1010,10,'PENDENTE'),(1010,1,'PENDENTE'),
(1011,9,'PENDENTE'),(1011,10,'PENDENTE'),(1011,1,'PENDENTE'),(1011,2,'PENDENTE'),
(1012,10,'PENDENTE'),(1012,1,'PENDENTE'),(1012,2,'PENDENTE'),(1012,3,'PENDENTE'),
(1013,1,'PENDENTE'),(1013,2,'PENDENTE'),(1013,3,'PENDENTE'),(1013,4,'PENDENTE'),
(1014,2,'PENDENTE'),(1014,3,'PENDENTE'),(1014,4,'PENDENTE'),(1014,5,'PENDENTE'),
(1015,3,'PENDENTE'),(1015,4,'PENDENTE'),(1015,5,'PENDENTE'),(1015,6,'PENDENTE'),
(1016,4,'PENDENTE'),(1016,5,'PENDENTE'),(1016,6,'PENDENTE'),(1016,7,'PENDENTE'),
(1017,5,'PENDENTE'),(1017,6,'PENDENTE'),(1017,7,'PENDENTE'),(1017,8,'PENDENTE'),
(1018,6,'PENDENTE'),(1018,7,'PENDENTE'),(1018,8,'PENDENTE'),(1018,9,'PENDENTE'),
(1019,7,'PENDENTE'),(1019,8,'PENDENTE'),(1019,9,'PENDENTE'),(1019,10,'PENDENTE'),
(1020,8,'PENDENTE'),(1020,9,'PENDENTE'),(1020,10,'PENDENTE'),(1020,1,'PENDENTE'),
(1021,9,'PENDENTE'),(1021,10,'PENDENTE'),(1021,1,'PENDENTE'),(1021,2,'PENDENTE'),
(1022,10,'PENDENTE'),(1022,1,'PENDENTE'),(1022,2,'PENDENTE'),(1022,3,'PENDENTE'),
(1023,1,'PENDENTE'),(1023,2,'PENDENTE'),(1023,3,'PENDENTE'),(1023,4,'PENDENTE'),
(1024,2,'PENDENTE'),(1024,3,'PENDENTE'),(1024,4,'PENDENTE'),(1024,5,'PENDENTE'),
(1025,3,'PENDENTE'),(1025,4,'PENDENTE'),(1025,5,'PENDENTE'),(1025,6,'PENDENTE'),
(1026,4,'PENDENTE'),(1026,5,'PENDENTE'),(1026,6,'PENDENTE'),(1026,7,'PENDENTE'),
(1027,5,'PENDENTE'),(1027,6,'PENDENTE'),(1027,7,'PENDENTE'),(1027,8,'PENDENTE'),
(1028,6,'PENDENTE'),(1028,7,'PENDENTE'),(1028,8,'PENDENTE'),(1028,9,'PENDENTE'),
(1029,7,'PENDENTE'),(1029,8,'PENDENTE'),(1029,9,'PENDENTE'),(1029,10,'PENDENTE'),
(1030,8,'PENDENTE'),(1030,9,'PENDENTE'),(1030,10,'PENDENTE'),(1030,1,'PENDENTE'),
(1031,9,'PENDENTE'),(1031,10,'PENDENTE'),(1031,1,'PENDENTE'),(1031,2,'PENDENTE'),
(1032,10,'PENDENTE'),(1032,1,'PENDENTE'),(1032,2,'PENDENTE'),(1032,3,'PENDENTE'),
(1033,1,'PENDENTE'),(1033,2,'PENDENTE'),(1033,3,'PENDENTE'),(1033,4,'PENDENTE'),
(1034,2,'PENDENTE'),(1034,3,'PENDENTE'),(1034,4,'PENDENTE'),(1034,5,'PENDENTE'),
(1035,3,'PENDENTE'),(1035,4,'PENDENTE'),(1035,5,'PENDENTE'),(1035,6,'PENDENTE'),
(1036,4,'PENDENTE'),(1036,5,'PENDENTE'),(1036,6,'PENDENTE'),(1036,7,'PENDENTE'),
(1037,5,'PENDENTE'),(1037,6,'PENDENTE'),(1037,7,'PENDENTE'),(1037,8,'PENDENTE'),
(1038,6,'PENDENTE'),(1038,7,'PENDENTE'),(1038,8,'PENDENTE'),(1038,9,'PENDENTE'),
(1039,7,'PENDENTE'),(1039,8,'PENDENTE'),(1039,9,'PENDENTE'),(1039,10,'PENDENTE'),
(1040,8,'PENDENTE'),(1040,9,'PENDENTE'),(1040,10,'PENDENTE'),(1040,1,'PENDENTE'),
(1041,9,'PENDENTE'),(1041,10,'PENDENTE'),(1041,1,'PENDENTE'),(1041,2,'PENDENTE'),
(1042,10,'PENDENTE'),(1042,1,'PENDENTE'),(1042,2,'PENDENTE'),(1042,3,'PENDENTE'),
(1043,1,'PENDENTE'),(1043,2,'PENDENTE'),(1043,3,'PENDENTE'),(1043,4,'PENDENTE'),
(1044,2,'PENDENTE'),(1044,3,'PENDENTE'),(1044,4,'PENDENTE'),(1044,5,'PENDENTE'),
(1045,3,'PENDENTE'),(1045,4,'PENDENTE'),(1045,5,'PENDENTE'),(1045,6,'PENDENTE'),
(1046,4,'PENDENTE'),(1046,5,'PENDENTE'),(1046,6,'PENDENTE'),(1046,7,'PENDENTE'),
(1047,5,'PENDENTE'),(1047,6,'PENDENTE'),(1047,7,'PENDENTE'),(1047,8,'PENDENTE'),
(1048,6,'PENDENTE'),(1048,7,'PENDENTE'),(1048,8,'PENDENTE'),(1048,9,'PENDENTE'),
(1049,7,'PENDENTE'),(1049,8,'PENDENTE'),(1049,9,'PENDENTE'),(1049,10,'PENDENTE'),
(1050,8,'PENDENTE'),(1050,9,'PENDENTE'),(1050,10,'PENDENTE'),(1050,1,'PENDENTE'),
(1051,9,'PENDENTE'),(1051,10,'PENDENTE'),(1051,1,'PENDENTE'),(1051,2,'PENDENTE'),
(1052,10,'PENDENTE'),(1052,1,'PENDENTE'),(1052,2,'PENDENTE'),(1052,3,'PENDENTE'),
(1053,1,'PENDENTE'),(1053,2,'PENDENTE'),(1053,3,'PENDENTE'),(1053,4,'PENDENTE'),
(1054,2,'PENDENTE'),(1054,3,'PENDENTE'),(1054,4,'PENDENTE'),(1054,5,'PENDENTE'),
(1055,3,'PENDENTE'),(1055,4,'PENDENTE'),(1055,5,'PENDENTE'),(1055,6,'PENDENTE'),
(1056,4,'PENDENTE'),(1056,5,'PENDENTE'),(1056,6,'PENDENTE'),(1056,7,'PENDENTE'),
(1057,5,'PENDENTE'),(1057,6,'PENDENTE'),(1057,7,'PENDENTE'),(1057,8,'PENDENTE'),
(1058,6,'PENDENTE'),(1058,7,'PENDENTE'),(1058,8,'PENDENTE'),(1058,9,'PENDENTE'),
(1059,7,'PENDENTE'),(1059,8,'PENDENTE'),(1059,9,'PENDENTE'),(1059,10,'PENDENTE'),
(1060,8,'PENDENTE'),(1060,9,'PENDENTE'),(1060,10,'PENDENTE'),(1060,1,'PENDENTE'),
(1061,9,'PENDENTE'),(1061,10,'PENDENTE'),(1061,1,'PENDENTE'),(1061,2,'PENDENTE'),
(1062,10,'PENDENTE'),(1062,1,'PENDENTE'),(1062,2,'PENDENTE'),(1062,3,'PENDENTE'),
(1063,1,'PENDENTE'),(1063,2,'PENDENTE'),(1063,3,'PENDENTE'),(1063,4,'PENDENTE'),
(1064,2,'PENDENTE'),(1064,3,'PENDENTE'),(1064,4,'PENDENTE'),(1064,5,'PENDENTE'),
(1065,3,'PENDENTE'),(1065,4,'PENDENTE'),(1065,5,'PENDENTE'),(1065,6,'PENDENTE'),
(1066,4,'PENDENTE'),(1066,5,'PENDENTE'),(1066,6,'PENDENTE'),(1066,7,'PENDENTE'),
(1067,5,'PENDENTE'),(1067,6,'PENDENTE'),(1067,7,'PENDENTE'),(1067,8,'PENDENTE'),
(1068,6,'PENDENTE'),(1068,7,'PENDENTE'),(1068,8,'PENDENTE'),(1068,9,'PENDENTE'),
(1069,7,'PENDENTE'),(1069,8,'PENDENTE'),(1069,9,'PENDENTE'),(1069,10,'PENDENTE'),
(1070,8,'PENDENTE'),(1070,9,'PENDENTE'),(1070,10,'PENDENTE'),(1070,1,'PENDENTE'),
(1071,9,'PENDENTE'),(1071,10,'PENDENTE'),(1071,1,'PENDENTE'),(1071,2,'PENDENTE'),
(1072,10,'PENDENTE'),(1072,1,'PENDENTE'),(1072,2,'PENDENTE'),(1072,3,'PENDENTE'),
(1073,1,'PENDENTE'),(1073,2,'PENDENTE'),(1073,3,'PENDENTE'),(1073,4,'PENDENTE'),
(1074,2,'PENDENTE'),(1074,3,'PENDENTE'),(1074,4,'PENDENTE'),(1074,5,'PENDENTE'),
(1075,3,'PENDENTE'),(1075,4,'PENDENTE'),(1075,5,'PENDENTE'),(1075,6,'PENDENTE'),
(1076,4,'PENDENTE'),(1076,5,'PENDENTE'),(1076,6,'PENDENTE'),(1076,7,'PENDENTE'),
(1077,5,'PENDENTE'),(1077,6,'PENDENTE'),(1077,7,'PENDENTE'),(1077,8,'PENDENTE'),
(1078,6,'PENDENTE'),(1078,7,'PENDENTE'),(1078,8,'PENDENTE'),(1078,9,'PENDENTE');

-- Verificação: Listar especialidades inseridas
SELECT '=== ESPECIALIDADES INSERIDAS ===' AS verificacao;
SELECT id, nome FROM especialidade ORDER BY id;

-- Verificação: Listar salas inseridas
SELECT '=== SALAS INSERIDAS ===' AS verificacao;
SELECT id, nome, quantidade_maxima_alunos, quantidade_equipamentos_pcd FROM sala ORDER BY id;

-- Verificação: Listar relacionamentos Sala-Especialidade
SELECT '=== RELACIONAMENTOS SALA-ESPECIALIDADE ===' AS verificacao;
SELECT s.id AS sala_id, s.nome AS sala_nome, e.id AS especialidade_id, e.nome AS especialidade_nome
FROM sala s
JOIN sala_especialidade se ON s.id = se.sala_id
JOIN especialidade e ON se.especialidade_id = e.id
ORDER BY s.id, e.id;

-- Verificação: Contar endereços inseridos
SELECT '=== ENDEREÇOS INSERIDOS ===' AS verificacao;
SELECT COUNT(*) AS total_enderecos FROM endereco;
SELECT id, rua, numero, bairro, cidade FROM endereco ORDER BY id LIMIT 5;

-- Verificação: Verificar administrador inserido
SELECT '=== ADMINISTRADOR INSERIDO ===' AS verificacao;
SELECT f.id, f.nome, f.email, f.role, f.cpf, f.status 
FROM funcionario f 
JOIN administrador a ON f.id = a.id;

-- Verificação: Verificar professores inseridos
SELECT '=== PROFESSORES INSERIDOS ===' AS verificacao;
SELECT f.id, f.nome, f.email, f.role, f.cpf, f.status 
FROM funcionario f 
JOIN professor p ON f.id = p.id;

-- Verificação: Listar relacionamentos Professor-Especialidade
SELECT '=== RELACIONAMENTOS PROFESSOR-ESPECIALIDADE ===' AS verificacao;
SELECT f.id AS professor_id, f.nome AS professor_nome, e.id AS especialidade_id, e.nome AS especialidade_nome
FROM funcionario f
JOIN professor p ON f.id = p.id
JOIN professor_especialidade pe ON p.id = pe.professor_id
JOIN especialidade e ON pe.especialidade_id = e.id
ORDER BY f.id, e.id;

-- Verificação: Verificar secretária inserida
SELECT '=== SECRETÁRIA INSERIDA ===' AS verificacao;
SELECT f.id, f.nome, f.email, f.role, f.cpf, f.status 
FROM funcionario f 
JOIN secretaria s ON f.id = s.id;

-- Verificação: Verificar alunos inseridos
SELECT '=== ALUNOS INSERIDOS ===' AS verificacao;
SELECT COUNT(*) AS total_alunos FROM aluno;
SELECT id, nome, email, cpf, status, aluno_com_limitacoes_fisicas 
FROM aluno 
ORDER BY id 
LIMIT 10;

-- Verificação: Alunos com limitações físicas
SELECT '=== ALUNOS COM LIMITAÇÕES FÍSICAS ===' AS verificacao;
SELECT id, nome, email, aluno_com_limitacoes_fisicas, observacao 
FROM aluno 
WHERE aluno_com_limitacoes_fisicas = TRUE;

-- ============================================
-- VERIFICAÇÃO FINAL - RESUMO GERAL
-- ============================================
SELECT '=== RESUMO GERAL ===' AS verificacao;

SELECT 'Especialidades' AS tipo, COUNT(*) AS quantidade FROM especialidade
UNION ALL
SELECT 'Salas', COUNT(*) FROM sala
UNION ALL
SELECT 'Endereços', COUNT(*) FROM endereco
UNION ALL
SELECT 'Funcionários (Total)', COUNT(*) FROM funcionario
UNION ALL
SELECT 'Administradores', COUNT(*) FROM administrador
UNION ALL
SELECT 'Professores', COUNT(*) FROM professor
UNION ALL
SELECT 'Secretárias', COUNT(*) FROM secretaria
UNION ALL
SELECT 'Alunos', COUNT(*) FROM aluno
UNION ALL
SELECT 'Relacionamentos Sala-Especialidade', COUNT(*) FROM sala_especialidade
UNION ALL
SELECT 'Relacionamentos Professor-Especialidade', COUNT(*) FROM professor_especialidade;

-- Verificação: Listar todos os funcionários
SELECT '=== TODOS OS FUNCIONÁRIOS ===' AS verificacao;
SELECT f.id, f.nome, f.email, f.role, f.cpf, f.status,
       CASE 
           WHEN a.id IS NOT NULL THEN 'Administrador'
           WHEN p.id IS NOT NULL THEN 'Professor'
           WHEN s.id IS NOT NULL THEN 'Secretária'
           ELSE 'N/A'
       END AS tipo_funcionario
FROM funcionario f
LEFT JOIN administrador a ON f.id = a.id
LEFT JOIN professor p ON f.id = p.id
LEFT JOIN secretaria s ON f.id = s.id
ORDER BY f.role, f.nome;

-- ============================================
-- FIM DO SCRIPT
-- ============================================
-- 
-- RESUMO DOS DADOS INSERIDOS:
-- - 1 Administrador (admin@onepilates.com)
-- - 2 Professores (Andrei Scafi e Guilherme Queiroz)
-- - 1 Secretária (Amanda)
-- - 20 Alunos
-- - 8 Especialidades (Pilates, Osteopatia, RPG, Microfisioterapia, Shiatsu, Drenagem Linfática, Fisioterapia, Acupuntura)
-- - 4 Salas (Sala Grande 1, Sala Grande 2, Sala Pequena 1, Sala Pequena 2)
-- 
-- CREDENCIAIS DE ACESSO:
-- Administrador: admin@onepilates.com
-- Professor 1: andreiscafi@gmail.com
-- Professor 2: guilherme@email.com
-- Secretária: amanda@email.com
-- 
-- Hash BCrypt da senha: $2a$10$QosoIZARoPcs1uMI4UExI.ampEaJMB0B390y8QHhzY4gwV4IE2W16
-- 
-- NOTA: Todos os usuários têm a senha com hash BCrypt: $2a$10$QosoIZARoPcs1uMI4UExI.ampEaJMB0B390y8QHhzY4gwV4IE2W16
-- ============================================

