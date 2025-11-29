-- ============================================
-- Script de Dados Iniciais - One Pilates
-- Data: 2024-11-15
-- Descrição: Insere dados iniciais para desenvolvimento
-- ============================================
-- 
-- IMPORTANTE: Execute este script APÓS o banco ser criado pelas classes Java
-- Hash BCrypt da senha para todos os usuários: $2a$10$QosoIZARoPcs1uMI4UExI.ampEaJMB0B390y8QHhzY4gwV4IE2W16
-- ============================================

USE onePilates;

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
INSERT INTO especialidade (nome) VALUES
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
INSERT INTO sala (nome, quantidade_maxima_alunos, quantidade_equipamentos_pcd) VALUES
('Sala Grande 1', 6, 2);

-- Sala Grande 2
INSERT INTO sala (nome, quantidade_maxima_alunos, quantidade_equipamentos_pcd) VALUES
('Sala Grande 2', 6, 1);

-- Sala Pequena 1 (com Osteopatia e 1 equipamento PCD)
INSERT INTO sala (nome, quantidade_maxima_alunos, quantidade_equipamentos_pcd) VALUES
('Sala Pequena 1', 1, 1);

-- Sala Pequena 2 (sem Osteopatia e sem equipamento PCD)
INSERT INTO sala (nome, quantidade_maxima_alunos, quantidade_equipamentos_pcd) VALUES
('Sala Pequena 2', 1, 0);

-- ============================================
-- 3. RELACIONAR SALAS COM ESPECIALIDADES
-- ============================================
-- Sala Grande 1: Pilates, RPG, Fisioterapia
INSERT INTO sala_especialidade (sala_id, especialidade_id) VALUES
(1, 1), -- Pilates
(1, 3), -- RPG
(1, 7); -- Fisioterapia

-- Sala Grande 2: Pilates, RPG, Fisioterapia
INSERT INTO sala_especialidade (sala_id, especialidade_id) VALUES
(2, 1), -- Pilates
(2, 3), -- RPG
(2, 7); -- Fisioterapia

-- Sala Pequena 1: Osteopatia, RPG, Microfisioterapia, Shiatsu, Drenagem Linfática, Fisioterapia, Acupuntura
INSERT INTO sala_especialidade (sala_id, especialidade_id) VALUES
(3, 2), -- Osteopatia
(3, 3), -- RPG
(3, 4), -- Microfisioterapia
(3, 5), -- Shiatsu
(3, 6), -- Drenagem Linfática
(3, 7), -- Fisioterapia
(3, 8); -- Acupuntura

-- Sala Pequena 2: RPG, Microfisioterapia, Shiatsu, Drenagem Linfática, Fisioterapia, Acupuntura
INSERT INTO sala_especialidade (sala_id, especialidade_id) VALUES
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
INSERT INTO endereco (id, rua, numero, bairro, cidade, estado, cep, uf) VALUES
(1, 'Rua das Flores', '123', 'Centro', 'São Paulo', 'São Paulo', '01310-100', 'SP');

-- Endereços para Professores (IDs: 2, 3)
INSERT INTO endereco (id, rua, numero, bairro, cidade, estado, cep, uf) VALUES
(2, 'Av. Paulista', '1000', 'Bela Vista', 'São Paulo', 'São Paulo', '01310-100', 'SP'),
(3, 'Rua Augusta', '500', 'Consolação', 'São Paulo', 'São Paulo', '01305-100', 'SP');

-- Endereço para Secretária (ID: 4)
INSERT INTO endereco (id, rua, numero, bairro, cidade, estado, cep, uf) VALUES
(4, 'Rua dos Três Irmãos', '456', 'Vila Progredior', 'São Paulo', 'São Paulo', '05615-190', 'SP');

-- Endereços para Alunos (IDs: 5 a 24 - 20 endereços)
INSERT INTO endereco (id, rua, numero, bairro, cidade, estado, cep, uf) VALUES
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
INSERT INTO funcionario (nome, email, senha, role, cpf, data_nascimento, status, notificacao_ativa, cargo, endereco_id, telefone, primeiro_acesso) VALUES
('Administrador', 'admin@onepilates.com', '$2a$10$QosoIZARoPcs1uMI4UExI.ampEaJMB0B390y8QHhzY4gwV4IE2W16', 'ADMINISTRADOR', '00000000000', '1980-01-01', TRUE, TRUE, 'Administrador', 1, '(11) 99999-0000', FALSE);


INSERT INTO administrador (id) VALUES (1);

-- ============================================
-- 6. INSERIR PROFESSORES
-- ============================================
-- Professor 1: Andrei Scafi

INSERT INTO funcionario (nome, email, senha, role, cpf, data_nascimento, status, notificacao_ativa, cargo, endereco_id, telefone, primeiro_acesso) VALUES
('Andrei Scafi', 'andreiscafi@gmail.com', '$2a$10$QosoIZARoPcs1uMI4UExI.ampEaJMB0B390y8QHhzY4gwV4IE2W16', 'PROFESSOR', '11122233300', '1990-05-15', TRUE, TRUE, 'Professor de Pilates', 2, '(11) 99999-1111', TRUE);

INSERT INTO professor (id) VALUES (2);

-- Professor 2: Guilherme Queiroz
INSERT INTO funcionario (nome, email, senha, role, cpf, data_nascimento, status, notificacao_ativa, cargo, endereco_id, telefone, primeiro_acesso) VALUES
('Guilherme Queiroz', 'guilherme@email.com', '$2a$10$QosoIZARoPcs1uMI4UExI.ampEaJMB0B390y8QHhzY4gwV4IE2W16', 'PROFESSOR', '22233344400', '1985-08-20', TRUE, TRUE, 'Professor de Pilates', 3, '(11) 99999-2222', TRUE);

INSERT INTO professor (id) VALUES (3);

-- ============================================
-- 7. RELACIONAR PROFESSORES COM ESPECIALIDADES
-- ============================================
-- Andrei Scafi: Pilates, RPG, Fisioterapia
INSERT INTO professor_especialidade (professor_id, especialidade_id) VALUES
(2, 1), -- Pilates
(2, 3), -- RPG
(2, 7); -- Fisioterapia

-- Guilherme Queiroz: Pilates, RPG, Fisioterapia
INSERT INTO professor_especialidade (professor_id, especialidade_id) VALUES
(3, 1), -- Pilates
(3, 3), -- RPG
(3, 7); -- Fisioterapia

-- ============================================
-- 8. INSERIR SECRETÁRIA
-- ============================================
-- Secretária: Amanda

INSERT INTO funcionario (nome, email, senha, role, cpf, data_nascimento, status, notificacao_ativa, cargo, endereco_id, telefone, primeiro_acesso) VALUES
('Amanda', 'amanda@email.com', '$2a$10$QosoIZARoPcs1uMI4UExI.ampEaJMB0B390y8QHhzY4gwV4IE2W16', 'SECRETARIA', '33344455500', '1992-03-10', TRUE, TRUE, 'Secretária', 4, '(11) 99999-3333', FALSE);

INSERT INTO secretaria (id) VALUES (4);

-- ============================================
-- 9. INSERIR ALUNOS (20 alunos)
-- ============================================
INSERT INTO aluno (nome, email, cpf, data_nascimento, status, aluno_com_limitacoes_fisicas, tipo_contato, notificacao_ativa, observacao, endereco_id) VALUES
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
INSERT INTO agendamento (id, data_hora, professor_id, sala_id, especialidade_id) VALUES
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
INSERT INTO agendamento (id, data_hora, professor_id, sala_id, especialidade_id) VALUES
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
INSERT INTO agendamento (id, data_hora, professor_id, sala_id, especialidade_id) VALUES
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
INSERT INTO agendamento (id, data_hora, professor_id, sala_id, especialidade_id) VALUES
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
INSERT INTO agendamento (id, data_hora, professor_id, sala_id, especialidade_id) VALUES
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
INSERT INTO agendamento (id, data_hora, professor_id, sala_id, especialidade_id) VALUES
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
INSERT INTO agendamento (id, data_hora, professor_id, sala_id, especialidade_id) VALUES
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
INSERT INTO agendamento (id, data_hora, professor_id, sala_id, especialidade_id) VALUES
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
INSERT INTO agendamento (id, data_hora, professor_id, sala_id, especialidade_id) VALUES
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
INSERT INTO agendamento (id, data_hora, professor_id, sala_id, especialidade_id) VALUES
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
-- 11. INSERIR RELACIONAMENTOS AGENDAMENTO-ALUNO
-- ============================================
-- NOTA: StatusPresenca é um ENUM com valores: PENDENTE, PRESENTE, FALTA
-- Agendamentos passados (até 14/11/2025): PRESENTE ou FALTA
-- Agendamentos futuros (após 14/11/2025): PENDENTE

-- ============================================
-- AGENDAMENTOS DO PROFESSOR ANDREI (IDs 1-97)
-- ============================================
-- Estratégia: Andrei usa principalmente alunos 11-20 para evitar conflitos com Guilherme
-- Agendamentos de agosto do Andrei (IDs 1-21) - PASSADOS
INSERT INTO agendamento_aluno (agendamento_id, aluno_id, status_presenca) VALUES
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
INSERT INTO agendamento_aluno (agendamento_id, aluno_id, status_presenca) VALUES
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
INSERT INTO agendamento_aluno (agendamento_id, aluno_id, status_presenca) VALUES
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
INSERT INTO agendamento_aluno (agendamento_id, aluno_id, status_presenca) VALUES
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
INSERT INTO agendamento_aluno (agendamento_id, aluno_id, status_presenca) VALUES
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
INSERT INTO agendamento_aluno (agendamento_id, aluno_id, status_presenca) VALUES
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
INSERT INTO agendamento_aluno (agendamento_id, aluno_id, status_presenca) VALUES
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
INSERT INTO agendamento_aluno (agendamento_id, aluno_id, status_presenca) VALUES
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
INSERT INTO agendamento_aluno (agendamento_id, aluno_id, status_presenca) VALUES
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
INSERT INTO agendamento_aluno (agendamento_id, aluno_id, status_presenca) VALUES
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

