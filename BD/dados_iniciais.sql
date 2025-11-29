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
('Guilherme Queiroz', 'andrei.vasconcelos@sptech.school', '$2a$10$QosoIZARoPcs1uMI4UExI.ampEaJMB0B390y8QHhzY4gwV4IE2W16', 'PROFESSOR', '22233344400', '1985-08-20', TRUE, TRUE, 'Professor de Pilates', 3, '(11) 99999-2222', TRUE);

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
-- 10. INSERIR AGENDAMENTOS PARA O PROFESSOR GUILHERME QUEIROZ
-- ============================================
-- Professor Guilherme (ID: 3) - Especialidades: Pilates (1), RPG (3), Fisioterapia (7)
-- Salas: Sala Grande 1 (1) ou Sala Grande 2 (2)
-- Regras: Segunda a Sexta, 9h-18h (hora cheia), excluindo 12h-13h (almoço)

-- AGOSTO 2025
INSERT INTO agendamento (data_hora, professor_id, sala_id, especialidade_id) VALUES
('2025-08-04 09:00:00', 3, 2, 1), -- Segunda - Pilates
('2025-08-04 11:00:00', 3, 2, 3), -- Segunda - RPG
('2025-08-04 13:00:00', 3, 2, 7), -- Segunda - Fisioterapia
('2025-08-04 15:00:00', 3, 2, 1), -- Segunda - Pilates
('2025-08-05 09:00:00', 3, 2, 3), -- Terça - RPG
('2025-08-05 11:00:00', 3, 2, 1), -- Terça - Pilates
('2025-08-05 14:00:00', 3, 2, 7), -- Terça - Fisioterapia
('2025-08-05 16:00:00', 3, 2, 1), -- Terça - Pilates
('2025-08-06 09:00:00', 3, 2, 1), -- Quarta - Pilates
('2025-08-06 11:00:00', 3, 2, 3), -- Quarta - RPG
('2025-08-06 13:00:00', 3, 2, 7), -- Quarta - Fisioterapia
('2025-08-06 15:00:00', 3, 2, 1), -- Quarta - Pilates
('2025-08-07 09:00:00', 3, 2, 3), -- Quinta - RPG
('2025-08-07 11:00:00', 3, 2, 1), -- Quinta - Pilates
('2025-08-07 15:00:00', 3, 2, 7), -- Quinta - Fisioterapia
('2025-08-07 17:00:00', 3, 2, 1), -- Quinta - Pilates
('2025-08-08 09:00:00', 3, 2, 1), -- Sexta - Pilates
('2025-08-08 11:00:00', 3, 2, 3), -- Sexta - RPG
('2025-08-08 13:00:00', 3, 2, 7), -- Sexta - Fisioterapia
('2025-08-08 15:00:00', 3, 2, 1), -- Sexta - Pilates
('2025-08-11 09:00:00', 3, 2, 3), -- Segunda - RPG
('2025-08-11 11:00:00', 3, 2, 1), -- Segunda - Pilates
('2025-08-11 15:00:00', 3, 2, 7), -- Segunda - Fisioterapia
('2025-08-11 17:00:00', 3, 2, 1), -- Segunda - Pilates
('2025-08-12 09:00:00', 3, 2, 1), -- Terça - Pilates
('2025-08-12 11:00:00', 3, 2, 3), -- Terça - RPG
('2025-08-12 13:00:00', 3, 2, 7), -- Terça - Fisioterapia
('2025-08-12 15:00:00', 3, 2, 1), -- Terça - Pilates
('2025-08-13 09:00:00', 3, 2, 1), -- Quarta - Pilates
('2025-08-13 11:00:00', 3, 2, 3), -- Quarta - RPG
('2025-08-13 14:00:00', 3, 2, 7), -- Quarta - Fisioterapia
('2025-08-13 16:00:00', 3, 2, 1), -- Quarta - Pilates
('2025-08-14 09:00:00', 3, 2, 1), -- Quinta - Pilates
('2025-08-14 11:00:00', 3, 2, 3), -- Quinta - RPG
('2025-08-14 15:00:00', 3, 2, 1), -- Quinta - Pilates
('2025-08-14 17:00:00', 3, 2, 7), -- Quinta - Fisioterapia
('2025-08-15 09:00:00', 3, 2, 3), -- Sexta - RPG
('2025-08-15 11:00:00', 3, 2, 1), -- Sexta - Pilates
('2025-08-15 13:00:00', 3, 2, 7), -- Sexta - Fisioterapia
('2025-08-15 15:00:00', 3, 2, 1), -- Sexta - Pilates
('2025-08-18 09:00:00', 3, 2, 1), -- Segunda - Pilates
('2025-08-18 11:00:00', 3, 2, 3), -- Segunda - RPG
('2025-08-18 13:00:00', 3, 2, 7), -- Segunda - Fisioterapia
('2025-08-18 15:00:00', 3, 2, 1), -- Segunda - Pilates
('2025-08-19 09:00:00', 3, 2, 3), -- Terça - RPG
('2025-08-19 11:00:00', 3, 2, 1), -- Terça - Pilates
('2025-08-19 14:00:00', 3, 2, 7), -- Terça - Fisioterapia
('2025-08-19 16:00:00', 3, 2, 1), -- Terça - Pilates
('2025-08-20 09:00:00', 3, 2, 1), -- Quarta - Pilates
('2025-08-20 11:00:00', 3, 2, 3), -- Quarta - RPG
('2025-08-20 13:00:00', 3, 2, 7), -- Quarta - Fisioterapia
('2025-08-20 15:00:00', 3, 2, 1), -- Quarta - Pilates
('2025-08-21 09:00:00', 3, 2, 1), -- Quinta - Pilates
('2025-08-21 11:00:00', 3, 2, 3), -- Quinta - RPG
('2025-08-21 15:00:00', 3, 2, 1), -- Quinta - Pilates
('2025-08-21 17:00:00', 3, 2, 7), -- Quinta - Fisioterapia
('2025-08-22 09:00:00', 3, 2, 3), -- Sexta - RPG
('2025-08-22 11:00:00', 3, 2, 1), -- Sexta - Pilates
('2025-08-22 13:00:00', 3, 2, 7), -- Sexta - Fisioterapia
('2025-08-22 15:00:00', 3, 2, 1), -- Sexta - Pilates
('2025-08-25 09:00:00', 3, 2, 1), -- Segunda - Pilates
('2025-08-25 11:00:00', 3, 2, 3), -- Segunda - RPG
('2025-08-25 13:00:00', 3, 2, 7), -- Segunda - Fisioterapia
('2025-08-25 15:00:00', 3, 2, 1), -- Segunda - Pilates
('2025-08-26 09:00:00', 3, 2, 3), -- Terça - RPG
('2025-08-26 11:00:00', 3, 2, 1), -- Terça - Pilates
('2025-08-26 14:00:00', 3, 2, 7), -- Terça - Fisioterapia
('2025-08-26 16:00:00', 3, 2, 1), -- Terça - Pilates
('2025-08-27 09:00:00', 3, 2, 1), -- Quarta - Pilates
('2025-08-27 11:00:00', 3, 2, 3), -- Quarta - RPG
('2025-08-27 13:00:00', 3, 2, 7), -- Quarta - Fisioterapia
('2025-08-27 15:00:00', 3, 2, 1), -- Quarta - Pilates
('2025-08-28 09:00:00', 3, 2, 1), -- Quinta - Pilates
('2025-08-28 11:00:00', 3, 2, 3), -- Quinta - RPG
('2025-08-28 15:00:00', 3, 2, 1), -- Quinta - Pilates
('2025-08-28 17:00:00', 3, 2, 7), -- Quinta - Fisioterapia
('2025-08-29 09:00:00', 3, 2, 3), -- Sexta - RPG
('2025-08-29 11:00:00', 3, 2, 1), -- Sexta - Pilates
('2025-08-29 13:00:00', 3, 2, 7), -- Sexta - Fisioterapia
('2025-08-29 15:00:00', 3, 2, 1); -- Sexta - Pilates

-- SETEMBRO 2025
INSERT INTO agendamento (data_hora, professor_id, sala_id, especialidade_id) VALUES
('2025-09-01 09:00:00', 3, 2, 1), -- Segunda - Pilates
('2025-09-01 11:00:00', 3, 2, 3), -- Segunda - RPG
('2025-09-01 13:00:00', 3, 2, 7), -- Segunda - Fisioterapia
('2025-09-01 15:00:00', 3, 2, 1), -- Segunda - Pilates
('2025-09-02 09:00:00', 3, 2, 3), -- Terça - RPG
('2025-09-02 11:00:00', 3, 2, 1), -- Terça - Pilates
('2025-09-02 14:00:00', 3, 2, 7), -- Terça - Fisioterapia
('2025-09-02 16:00:00', 3, 2, 1), -- Terça - Pilates
('2025-09-03 09:00:00', 3, 2, 1), -- Quarta - Pilates
('2025-09-03 11:00:00', 3, 2, 3), -- Quarta - RPG
('2025-09-03 13:00:00', 3, 2, 7), -- Quarta - Fisioterapia
('2025-09-03 15:00:00', 3, 2, 1), -- Quarta - Pilates
('2025-09-04 09:00:00', 3, 2, 1), -- Quinta - Pilates
('2025-09-04 11:00:00', 3, 2, 3), -- Quinta - RPG
('2025-09-04 15:00:00', 3, 2, 1), -- Quinta - Pilates
('2025-09-04 17:00:00', 3, 2, 7), -- Quinta - Fisioterapia
('2025-09-05 09:00:00', 3, 2, 3), -- Sexta - RPG
('2025-09-05 11:00:00', 3, 2, 1), -- Sexta - Pilates
('2025-09-05 13:00:00', 3, 2, 7), -- Sexta - Fisioterapia
('2025-09-05 15:00:00', 3, 2, 1), -- Sexta - Pilates
('2025-09-08 09:00:00', 3, 2, 1), -- Segunda - Pilates
('2025-09-08 11:00:00', 3, 2, 3), -- Segunda - RPG
('2025-09-08 13:00:00', 3, 2, 7), -- Segunda - Fisioterapia
('2025-09-08 15:00:00', 3, 2, 1), -- Segunda - Pilates
('2025-09-09 09:00:00', 3, 2, 3), -- Terça - RPG
('2025-09-09 11:00:00', 3, 2, 1), -- Terça - Pilates
('2025-09-09 14:00:00', 3, 2, 7), -- Terça - Fisioterapia
('2025-09-09 16:00:00', 3, 2, 1), -- Terça - Pilates
('2025-09-10 09:00:00', 3, 2, 1), -- Quarta - Pilates
('2025-09-10 11:00:00', 3, 2, 3), -- Quarta - RPG
('2025-09-10 13:00:00', 3, 2, 7), -- Quarta - Fisioterapia
('2025-09-10 15:00:00', 3, 2, 1), -- Quarta - Pilates
('2025-09-11 09:00:00', 3, 2, 1), -- Quinta - Pilates
('2025-09-11 11:00:00', 3, 2, 3), -- Quinta - RPG
('2025-09-11 15:00:00', 3, 2, 1), -- Quinta - Pilates
('2025-09-11 17:00:00', 3, 2, 7), -- Quinta - Fisioterapia
('2025-09-12 09:00:00', 3, 2, 3), -- Sexta - RPG
('2025-09-12 11:00:00', 3, 2, 1), -- Sexta - Pilates
('2025-09-12 13:00:00', 3, 2, 7), -- Sexta - Fisioterapia
('2025-09-12 15:00:00', 3, 2, 1), -- Sexta - Pilates
('2025-09-15 09:00:00', 3, 2, 1), -- Segunda - Pilates
('2025-09-15 11:00:00', 3, 2, 3), -- Segunda - RPG
('2025-09-15 13:00:00', 3, 2, 7), -- Segunda - Fisioterapia
('2025-09-15 15:00:00', 3, 2, 1), -- Segunda - Pilates
('2025-09-16 09:00:00', 3, 2, 3), -- Terça - RPG
('2025-09-16 11:00:00', 3, 2, 1), -- Terça - Pilates
('2025-09-16 14:00:00', 3, 2, 7), -- Terça - Fisioterapia
('2025-09-16 16:00:00', 3, 2, 1), -- Terça - Pilates
('2025-09-17 09:00:00', 3, 2, 1), -- Quarta - Pilates
('2025-09-17 11:00:00', 3, 2, 3), -- Quarta - RPG
('2025-09-17 13:00:00', 3, 2, 7), -- Quarta - Fisioterapia
('2025-09-17 15:00:00', 3, 2, 1), -- Quarta - Pilates
('2025-09-18 09:00:00', 3, 2, 1), -- Quinta - Pilates
('2025-09-18 11:00:00', 3, 2, 3), -- Quinta - RPG
('2025-09-18 15:00:00', 3, 2, 1), -- Quinta - Pilates
('2025-09-18 17:00:00', 3, 2, 7), -- Quinta - Fisioterapia
('2025-09-19 09:00:00', 3, 2, 3), -- Sexta - RPG
('2025-09-19 11:00:00', 3, 2, 1), -- Sexta - Pilates
('2025-09-19 13:00:00', 3, 2, 7), -- Sexta - Fisioterapia
('2025-09-19 15:00:00', 3, 2, 1), -- Sexta - Pilates
('2025-09-22 09:00:00', 3, 2, 1), -- Segunda - Pilates
('2025-09-22 11:00:00', 3, 2, 3), -- Segunda - RPG
('2025-09-22 13:00:00', 3, 2, 7), -- Segunda - Fisioterapia
('2025-09-22 15:00:00', 3, 2, 1), -- Segunda - Pilates
('2025-09-23 09:00:00', 3, 2, 3), -- Terça - RPG
('2025-09-23 11:00:00', 3, 2, 1), -- Terça - Pilates
('2025-09-23 14:00:00', 3, 2, 7), -- Terça - Fisioterapia
('2025-09-23 16:00:00', 3, 2, 1), -- Terça - Pilates
('2025-09-24 09:00:00', 3, 2, 1), -- Quarta - Pilates
('2025-09-24 11:00:00', 3, 2, 3), -- Quarta - RPG
('2025-09-24 13:00:00', 3, 2, 7), -- Quarta - Fisioterapia
('2025-09-24 15:00:00', 3, 2, 1), -- Quarta - Pilates
('2025-09-25 09:00:00', 3, 2, 1), -- Quinta - Pilates
('2025-09-25 11:00:00', 3, 2, 3), -- Quinta - RPG
('2025-09-25 15:00:00', 3, 2, 1), -- Quinta - Pilates
('2025-09-25 17:00:00', 3, 2, 7), -- Quinta - Fisioterapia
('2025-09-26 09:00:00', 3, 2, 3), -- Sexta - RPG
('2025-09-26 11:00:00', 3, 2, 1), -- Sexta - Pilates
('2025-09-26 13:00:00', 3, 2, 7), -- Sexta - Fisioterapia
('2025-09-26 15:00:00', 3, 2, 1); -- Sexta - Pilates

-- OUTUBRO 2025
INSERT INTO agendamento (data_hora, professor_id, sala_id, especialidade_id) VALUES
('2025-10-01 09:00:00', 3, 2, 1), -- Quarta - Pilates
('2025-10-01 11:00:00', 3, 2, 3), -- Quarta - RPG
('2025-10-01 13:00:00', 3, 2, 7), -- Quarta - Fisioterapia
('2025-10-01 15:00:00', 3, 2, 1), -- Quarta - Pilates
('2025-10-02 09:00:00', 3, 2, 1), -- Quinta - Pilates
('2025-10-02 11:00:00', 3, 2, 3), -- Quinta - RPG
('2025-10-02 15:00:00', 3, 2, 1), -- Quinta - Pilates
('2025-10-02 17:00:00', 3, 2, 7), -- Quinta - Fisioterapia
('2025-10-03 09:00:00', 3, 2, 3), -- Sexta - RPG
('2025-10-03 11:00:00', 3, 2, 1), -- Sexta - Pilates
('2025-10-03 13:00:00', 3, 2, 7), -- Sexta - Fisioterapia
('2025-10-03 15:00:00', 3, 2, 1), -- Sexta - Pilates
('2025-10-06 09:00:00', 3, 2, 1), -- Segunda - Pilates
('2025-10-06 11:00:00', 3, 2, 3), -- Segunda - RPG
('2025-10-06 13:00:00', 3, 2, 7), -- Segunda - Fisioterapia
('2025-10-06 15:00:00', 3, 2, 1), -- Segunda - Pilates
('2025-10-07 09:00:00', 3, 2, 3), -- Terça - RPG
('2025-10-07 11:00:00', 3, 2, 1), -- Terça - Pilates
('2025-10-07 14:00:00', 3, 2, 7), -- Terça - Fisioterapia
('2025-10-07 16:00:00', 3, 2, 1), -- Terça - Pilates
('2025-10-08 09:00:00', 3, 2, 1), -- Quarta - Pilates
('2025-10-08 11:00:00', 3, 2, 3), -- Quarta - RPG
('2025-10-08 13:00:00', 3, 2, 7), -- Quarta - Fisioterapia
('2025-10-08 15:00:00', 3, 2, 1), -- Quarta - Pilates
('2025-10-09 09:00:00', 3, 2, 1), -- Quinta - Pilates
('2025-10-09 11:00:00', 3, 2, 3), -- Quinta - RPG
('2025-10-09 15:00:00', 3, 2, 1), -- Quinta - Pilates
('2025-10-09 17:00:00', 3, 2, 7), -- Quinta - Fisioterapia
('2025-10-10 09:00:00', 3, 2, 3), -- Sexta - RPG
('2025-10-10 11:00:00', 3, 2, 1), -- Sexta - Pilates
('2025-10-10 13:00:00', 3, 2, 7), -- Sexta - Fisioterapia
('2025-10-10 15:00:00', 3, 2, 1), -- Sexta - Pilates
('2025-10-13 09:00:00', 3, 2, 1), -- Segunda - Pilates
('2025-10-13 11:00:00', 3, 2, 3), -- Segunda - RPG
('2025-10-13 15:00:00', 3, 2, 1), -- Segunda - Pilates
('2025-10-13 17:00:00', 3, 2, 7), -- Segunda - Fisioterapia
('2025-10-14 09:00:00', 3, 2, 3), -- Terça - RPG
('2025-10-14 11:00:00', 3, 2, 1), -- Terça - Pilates
('2025-10-14 14:00:00', 3, 2, 7), -- Terça - Fisioterapia
('2025-10-14 16:00:00', 3, 2, 1), -- Terça - Pilates
('2025-10-15 09:00:00', 3, 2, 1), -- Quarta - Pilates
('2025-10-15 11:00:00', 3, 2, 3), -- Quarta - RPG
('2025-10-15 13:00:00', 3, 2, 7), -- Quarta - Fisioterapia
('2025-10-15 15:00:00', 3, 2, 1), -- Quarta - Pilates
('2025-10-16 09:00:00', 3, 2, 1), -- Quinta - Pilates
('2025-10-16 11:00:00', 3, 2, 3), -- Quinta - RPG
('2025-10-16 15:00:00', 3, 2, 1), -- Quinta - Pilates
('2025-10-16 17:00:00', 3, 2, 7), -- Quinta - Fisioterapia
('2025-10-17 09:00:00', 3, 2, 3), -- Sexta - RPG
('2025-10-17 11:00:00', 3, 2, 1), -- Sexta - Pilates
('2025-10-17 13:00:00', 3, 2, 7), -- Sexta - Fisioterapia
('2025-10-17 15:00:00', 3, 2, 1), -- Sexta - Pilates
('2025-10-20 09:00:00', 3, 2, 1), -- Segunda - Pilates
('2025-10-20 11:00:00', 3, 2, 3), -- Segunda - RPG
('2025-10-20 13:00:00', 3, 2, 7), -- Segunda - Fisioterapia
('2025-10-20 15:00:00', 3, 2, 1), -- Segunda - Pilates
('2025-10-21 09:00:00', 3, 2, 3), -- Terça - RPG
('2025-10-21 11:00:00', 3, 2, 1), -- Terça - Pilates
('2025-10-21 14:00:00', 3, 2, 7), -- Terça - Fisioterapia
('2025-10-21 16:00:00', 3, 2, 1), -- Terça - Pilates
('2025-10-22 09:00:00', 3, 2, 1), -- Quarta - Pilates
('2025-10-22 11:00:00', 3, 2, 3), -- Quarta - RPG
('2025-10-22 13:00:00', 3, 2, 7), -- Quarta - Fisioterapia
('2025-10-22 15:00:00', 3, 2, 1), -- Quarta - Pilates
('2025-10-23 09:00:00', 3, 2, 1), -- Quinta - Pilates
('2025-10-23 11:00:00', 3, 2, 3), -- Quinta - RPG
('2025-10-23 15:00:00', 3, 2, 1), -- Quinta - Pilates
('2025-10-23 17:00:00', 3, 2, 7), -- Quinta - Fisioterapia
('2025-10-24 09:00:00', 3, 2, 3), -- Sexta - RPG
('2025-10-24 11:00:00', 3, 2, 1), -- Sexta - Pilates
('2025-10-24 13:00:00', 3, 2, 7), -- Sexta - Fisioterapia
('2025-10-24 15:00:00', 3, 2, 1), -- Sexta - Pilates
('2025-10-27 09:00:00', 3, 2, 1), -- Segunda - Pilates
('2025-10-27 11:00:00', 3, 2, 3), -- Segunda - RPG
('2025-10-27 13:00:00', 3, 2, 7), -- Segunda - Fisioterapia
('2025-10-27 15:00:00', 3, 2, 1), -- Segunda - Pilates
('2025-10-28 09:00:00', 3, 2, 3), -- Terça - RPG
('2025-10-28 11:00:00', 3, 2, 1), -- Terça - Pilates
('2025-10-28 14:00:00', 3, 2, 7), -- Terça - Fisioterapia
('2025-10-28 16:00:00', 3, 2, 1), -- Terça - Pilates
('2025-10-29 09:00:00', 3, 2, 1), -- Quarta - Pilates
('2025-10-29 11:00:00', 3, 2, 3), -- Quarta - RPG
('2025-10-29 13:00:00', 3, 2, 7), -- Quarta - Fisioterapia
('2025-10-29 15:00:00', 3, 2, 1), -- Quarta - Pilates
('2025-10-30 09:00:00', 3, 2, 1), -- Quinta - Pilates
('2025-10-30 11:00:00', 3, 2, 3), -- Quinta - RPG
('2025-10-30 15:00:00', 3, 2, 1), -- Quinta - Pilates
('2025-10-30 17:00:00', 3, 2, 7), -- Quinta - Fisioterapia
('2025-10-31 09:00:00', 3, 2, 3), -- Sexta - RPG
('2025-10-31 11:00:00', 3, 2, 1), -- Sexta - Pilates
('2025-10-31 13:00:00', 3, 2, 7), -- Sexta - Fisioterapia
('2025-10-31 15:00:00', 3, 2, 1); -- Sexta - Pilates

-- NOVEMBRO 2025
INSERT INTO agendamento (data_hora, professor_id, sala_id, especialidade_id) VALUES
('2025-11-03 09:00:00', 3, 2, 1), -- Segunda - Pilates
('2025-11-03 11:00:00', 3, 2, 3), -- Segunda - RPG
('2025-11-03 13:00:00', 3, 2, 7), -- Segunda - Fisioterapia
('2025-11-03 15:00:00', 3, 2, 1), -- Segunda - Pilates
('2025-11-04 09:00:00', 3, 2, 3), -- Terça - RPG
('2025-11-04 11:00:00', 3, 2, 1), -- Terça - Pilates
('2025-11-04 14:00:00', 3, 2, 7), -- Terça - Fisioterapia
('2025-11-04 16:00:00', 3, 2, 1), -- Terça - Pilates
('2025-11-05 09:00:00', 3, 2, 1), -- Quarta - Pilates
('2025-11-05 11:00:00', 3, 2, 3), -- Quarta - RPG
('2025-11-05 13:00:00', 3, 2, 7), -- Quarta - Fisioterapia
('2025-11-05 15:00:00', 3, 2, 1), -- Quarta - Pilates
('2025-11-06 09:00:00', 3, 2, 1), -- Quinta - Pilates
('2025-11-06 11:00:00', 3, 2, 3), -- Quinta - RPG
('2025-11-06 15:00:00', 3, 2, 1), -- Quinta - Pilates
('2025-11-06 17:00:00', 3, 2, 7), -- Quinta - Fisioterapia
('2025-11-07 09:00:00', 3, 2, 3), -- Sexta - RPG
('2025-11-07 11:00:00', 3, 2, 1), -- Sexta - Pilates
('2025-11-07 13:00:00', 3, 2, 7), -- Sexta - Fisioterapia
('2025-11-07 15:00:00', 3, 2, 1), -- Sexta - Pilates
('2025-11-10 09:00:00', 3, 2, 1), -- Segunda - Pilates
('2025-11-10 11:00:00', 3, 2, 3), -- Segunda - RPG
('2025-11-10 15:00:00', 3, 2, 1), -- Segunda - Pilates
('2025-11-10 17:00:00', 3, 2, 7), -- Segunda - Fisioterapia
('2025-11-11 09:00:00', 3, 2, 3), -- Terça - RPG
('2025-11-11 11:00:00', 3, 2, 1), -- Terça - Pilates
('2025-11-11 14:00:00', 3, 2, 7), -- Terça - Fisioterapia
('2025-11-11 16:00:00', 3, 2, 1), -- Terça - Pilates
('2025-11-12 09:00:00', 3, 2, 1), -- Quarta - Pilates
('2025-11-12 11:00:00', 3, 2, 3), -- Quarta - RPG
('2025-11-12 13:00:00', 3, 2, 7), -- Quarta - Fisioterapia
('2025-11-12 15:00:00', 3, 2, 1), -- Quarta - Pilates
('2025-11-13 09:00:00', 3, 2, 1), -- Quinta - Pilates
('2025-11-13 11:00:00', 3, 2, 3), -- Quinta - RPG
('2025-11-13 15:00:00', 3, 2, 1), -- Quinta - Pilates
('2025-11-13 17:00:00', 3, 2, 7), -- Quinta - Fisioterapia
('2025-11-14 09:00:00', 3, 2, 3), -- Sexta - RPG
('2025-11-14 11:00:00', 3, 2, 1), -- Sexta - Pilates
('2025-11-14 13:00:00', 3, 2, 7), -- Sexta - Fisioterapia
('2025-11-14 15:00:00', 3, 2, 1), -- Sexta - Pilates
('2025-11-17 09:00:00', 3, 2, 1), -- Segunda - Pilates
('2025-11-17 11:00:00', 3, 2, 3), -- Segunda - RPG
('2025-11-17 13:00:00', 3, 2, 7), -- Segunda - Fisioterapia
('2025-11-17 15:00:00', 3, 2, 1), -- Segunda - Pilates
('2025-11-18 09:00:00', 3, 2, 3), -- Terça - RPG
('2025-11-18 11:00:00', 3, 2, 1), -- Terça - Pilates
('2025-11-18 14:00:00', 3, 2, 7), -- Terça - Fisioterapia
('2025-11-18 16:00:00', 3, 2, 1), -- Terça - Pilates
('2025-11-19 09:00:00', 3, 2, 1), -- Quarta - Pilates
('2025-11-19 11:00:00', 3, 2, 3), -- Quarta - RPG
('2025-11-19 13:00:00', 3, 2, 7), -- Quarta - Fisioterapia
('2025-11-19 15:00:00', 3, 2, 1), -- Quarta - Pilates
('2025-11-20 09:00:00', 3, 2, 1), -- Quinta - Pilates
('2025-11-20 11:00:00', 3, 2, 3), -- Quinta - RPG
('2025-11-20 15:00:00', 3, 2, 1), -- Quinta - Pilates
('2025-11-20 17:00:00', 3, 2, 7), -- Quinta - Fisioterapia
('2025-11-21 09:00:00', 3, 2, 3), -- Sexta - RPG
('2025-11-21 11:00:00', 3, 2, 1), -- Sexta - Pilates
('2025-11-21 13:00:00', 3, 2, 7), -- Sexta - Fisioterapia
('2025-11-21 15:00:00', 3, 2, 1), -- Sexta - Pilates
('2025-11-24 09:00:00', 3, 2, 1), -- Segunda - Pilates
('2025-11-24 11:00:00', 3, 2, 3), -- Segunda - RPG
('2025-11-24 13:00:00', 3, 2, 7), -- Segunda - Fisioterapia
('2025-11-24 15:00:00', 3, 2, 1), -- Segunda - Pilates
('2025-11-25 09:00:00', 3, 2, 3), -- Terça - RPG
('2025-11-25 11:00:00', 3, 2, 1), -- Terça - Pilates
('2025-11-25 14:00:00', 3, 2, 7), -- Terça - Fisioterapia
('2025-11-25 16:00:00', 3, 2, 1), -- Terça - Pilates
('2025-11-26 09:00:00', 3, 2, 1), -- Quarta - Pilates
('2025-11-26 11:00:00', 3, 2, 3), -- Quarta - RPG
('2025-11-26 13:00:00', 3, 2, 7), -- Quarta - Fisioterapia
('2025-11-26 15:00:00', 3, 2, 1), -- Quarta - Pilates
('2025-11-27 09:00:00', 3, 2, 1), -- Quinta - Pilates
('2025-11-27 11:00:00', 3, 2, 3), -- Quinta - RPG
('2025-11-27 15:00:00', 3, 2, 1), -- Quinta - Pilates
('2025-11-27 17:00:00', 3, 2, 7), -- Quinta - Fisioterapia
('2025-11-28 09:00:00', 3, 2, 3), -- Sexta - RPG
('2025-11-28 11:00:00', 3, 2, 1), -- Sexta - Pilates
('2025-11-28 13:00:00', 3, 2, 7), -- Sexta - Fisioterapia
('2025-11-28 15:00:00', 3, 2, 1); -- Sexta - Pilates

-- DEZEMBRO 2025
INSERT INTO agendamento (data_hora, professor_id, sala_id, especialidade_id) VALUES
('2025-12-01 09:00:00', 3, 2, 1), -- Segunda - Pilates
('2025-12-01 11:00:00', 3, 2, 3), -- Segunda - RPG
('2025-12-01 13:00:00', 3, 2, 7), -- Segunda - Fisioterapia
('2025-12-01 15:00:00', 3, 2, 1), -- Segunda - Pilates
('2025-12-02 09:00:00', 3, 2, 3), -- Terça - RPG
('2025-12-02 11:00:00', 3, 2, 1), -- Terça - Pilates
('2025-12-02 14:00:00', 3, 2, 7), -- Terça - Fisioterapia
('2025-12-02 16:00:00', 3, 2, 1), -- Terça - Pilates
('2025-12-03 09:00:00', 3, 2, 1), -- Quarta - Pilates
('2025-12-03 11:00:00', 3, 2, 3), -- Quarta - RPG
('2025-12-03 13:00:00', 3, 2, 7), -- Quarta - Fisioterapia
('2025-12-03 15:00:00', 3, 2, 1), -- Quarta - Pilates
('2025-12-04 09:00:00', 3, 2, 1), -- Quinta - Pilates
('2025-12-04 11:00:00', 3, 2, 3), -- Quinta - RPG
('2025-12-04 15:00:00', 3, 2, 1), -- Quinta - Pilates
('2025-12-04 17:00:00', 3, 2, 7), -- Quinta - Fisioterapia
('2025-12-05 09:00:00', 3, 2, 3), -- Sexta - RPG
('2025-12-05 11:00:00', 3, 2, 1), -- Sexta - Pilates
('2025-12-05 13:00:00', 3, 2, 7), -- Sexta - Fisioterapia
('2025-12-05 15:00:00', 3, 2, 1), -- Sexta - Pilates
('2025-12-08 09:00:00', 3, 2, 1), -- Segunda - Pilates
('2025-12-08 11:00:00', 3, 2, 3), -- Segunda - RPG
('2025-12-08 15:00:00', 3, 2, 1), -- Segunda - Pilates
('2025-12-08 17:00:00', 3, 2, 7), -- Segunda - Fisioterapia
('2025-12-09 09:00:00', 3, 2, 3), -- Terça - RPG
('2025-12-09 11:00:00', 3, 2, 1), -- Terça - Pilates
('2025-12-09 14:00:00', 3, 2, 7), -- Terça - Fisioterapia
('2025-12-09 16:00:00', 3, 2, 1), -- Terça - Pilates
('2025-12-10 09:00:00', 3, 2, 1), -- Quarta - Pilates
('2025-12-10 11:00:00', 3, 2, 3), -- Quarta - RPG
('2025-12-10 13:00:00', 3, 2, 7), -- Quarta - Fisioterapia
('2025-12-10 15:00:00', 3, 2, 1), -- Quarta - Pilates
('2025-12-11 09:00:00', 3, 2, 1), -- Quinta - Pilates
('2025-12-11 11:00:00', 3, 2, 3), -- Quinta - RPG
('2025-12-11 15:00:00', 3, 2, 1), -- Quinta - Pilates
('2025-12-11 17:00:00', 3, 2, 7), -- Quinta - Fisioterapia
('2025-12-12 09:00:00', 3, 2, 3), -- Sexta - RPG
('2025-12-12 11:00:00', 3, 2, 1), -- Sexta - Pilates
('2025-12-12 13:00:00', 3, 2, 7), -- Sexta - Fisioterapia
('2025-12-12 15:00:00', 3, 2, 1), -- Sexta - Pilates
('2025-12-15 09:00:00', 3, 2, 1), -- Segunda - Pilates
('2025-12-15 11:00:00', 3, 2, 3), -- Segunda - RPG
('2025-12-15 13:00:00', 3, 2, 7), -- Segunda - Fisioterapia
('2025-12-15 15:00:00', 3, 2, 1), -- Segunda - Pilates
('2025-12-16 09:00:00', 3, 2, 3), -- Terça - RPG
('2025-12-16 11:00:00', 3, 2, 1), -- Terça - Pilates
('2025-12-16 14:00:00', 3, 2, 7), -- Terça - Fisioterapia
('2025-12-16 16:00:00', 3, 2, 1), -- Terça - Pilates
('2025-12-17 09:00:00', 3, 2, 1), -- Quarta - Pilates
('2025-12-17 11:00:00', 3, 2, 3), -- Quarta - RPG
('2025-12-17 13:00:00', 3, 2, 7), -- Quarta - Fisioterapia
('2025-12-17 15:00:00', 3, 2, 1), -- Quarta - Pilates
('2025-12-18 09:00:00', 3, 2, 1), -- Quinta - Pilates
('2025-12-18 11:00:00', 3, 2, 3), -- Quinta - RPG
('2025-12-18 15:00:00', 3, 2, 1), -- Quinta - Pilates
('2025-12-18 17:00:00', 3, 2, 7), -- Quinta - Fisioterapia
('2025-12-19 09:00:00', 3, 2, 3), -- Sexta - RPG
('2025-12-19 11:00:00', 3, 2, 1), -- Sexta - Pilates
('2025-12-19 13:00:00', 3, 2, 7), -- Sexta - Fisioterapia
('2025-12-19 15:00:00', 3, 2, 1), -- Sexta - Pilates
('2025-12-22 09:00:00', 3, 2, 1), -- Segunda - Pilates
('2025-12-22 11:00:00', 3, 2, 3), -- Segunda - RPG
('2025-12-22 13:00:00', 3, 2, 7), -- Segunda - Fisioterapia
('2025-12-22 15:00:00', 3, 2, 1); -- Segunda - Pilates

-- ============================================
-- 10.1 INSERIR AGENDAMENTOS PARA O PROFESSOR ANDREI SCAFI
-- ============================================
-- Professor Andrei (ID: 2) - Especialidades: Pilates (1), RPG (3), Fisioterapia (7)
-- Salas: Sala Grande 1 (1) ou Sala Grande 2 (2)
-- Regras: Segunda a Sexta, 9h-18h (hora cheia), excluindo 12h-13h (almoço)
-- IMPORTANTE: Respeitar conflitos com agendamentos do professor Guilherme (sala e alunos)
-- Estratégia: Andrei usa principalmente Sala Grande 1, Guilherme usa Sala Grande 2

-- AGOSTO 2025
INSERT INTO agendamento (data_hora, professor_id, sala_id, especialidade_id) VALUES
('2025-08-04 10:00:00', 2, 1, 1), -- Segunda - Pilates (Guilherme: 9h, 11h, 13h, 15h na Sala 2)
('2025-08-04 14:00:00', 2, 1, 3), -- Segunda - RPG
('2025-08-04 16:00:00', 2, 1, 7), -- Segunda - Fisioterapia
('2025-08-04 17:00:00', 2, 1, 1), -- Segunda - Pilates
('2025-08-05 10:00:00', 2, 1, 1), -- Terça - Pilates (Guilherme: 9h, 11h, 14h, 16h na Sala 2)
('2025-08-05 13:00:00', 2, 1, 3), -- Terça - RPG
('2025-08-05 15:00:00', 2, 1, 7), -- Terça - Fisioterapia
('2025-08-05 17:00:00', 2, 1, 1), -- Terça - Pilates
('2025-08-06 10:00:00', 2, 1, 3), -- Quarta - RPG (Guilherme: 9h, 11h, 13h, 15h na Sala 2)
('2025-08-06 14:00:00', 2, 1, 1), -- Quarta - Pilates
('2025-08-06 16:00:00', 2, 1, 7), -- Quarta - Fisioterapia
('2025-08-06 17:00:00', 2, 1, 1), -- Quarta - Pilates
('2025-08-07 10:00:00', 2, 1, 1), -- Quinta - Pilates (Guilherme: 9h, 11h, 15h, 17h na Sala 2)
('2025-08-07 13:00:00', 2, 1, 3), -- Quinta - RPG
('2025-08-07 14:00:00', 2, 1, 7), -- Quinta - Fisioterapia
('2025-08-07 16:00:00', 2, 1, 1), -- Quinta - Pilates
('2025-08-08 10:00:00', 2, 1, 3), -- Sexta - RPG (Guilherme: 9h, 11h, 13h, 15h na Sala 2)
('2025-08-08 14:00:00', 2, 1, 1), -- Sexta - Pilates
('2025-08-08 16:00:00', 2, 1, 7), -- Sexta - Fisioterapia
('2025-08-08 17:00:00', 2, 1, 1), -- Sexta - Pilates
('2025-08-11 10:00:00', 2, 1, 1), -- Segunda - Pilates (Guilherme: 9h, 11h, 15h, 17h na Sala 2)
('2025-08-11 13:00:00', 2, 1, 3), -- Segunda - RPG
('2025-08-11 14:00:00', 2, 1, 7), -- Segunda - Fisioterapia
('2025-08-11 16:00:00', 2, 1, 1), -- Segunda - Pilates
('2025-08-12 10:00:00', 2, 1, 3), -- Terça - RPG (Guilherme: 9h, 11h, 13h, 15h na Sala 2)
('2025-08-12 14:00:00', 2, 1, 1), -- Terça - Pilates
('2025-08-12 15:00:00', 2, 1, 7), -- Terça - Fisioterapia
('2025-08-12 17:00:00', 2, 1, 1), -- Terça - Pilates
('2025-08-13 10:00:00', 2, 1, 1), -- Quarta - Pilates (Guilherme: 9h, 11h, 14h, 16h na Sala 2)
('2025-08-13 15:00:00', 2, 1, 3), -- Quarta - RPG
('2025-08-13 17:00:00', 2, 1, 7), -- Quarta - Fisioterapia
('2025-08-13 18:00:00', 2, 1, 1), -- Quarta - Pilates
('2025-08-14 10:00:00', 2, 1, 3), -- Quinta - RPG (Guilherme: 9h, 11h, 15h, 17h na Sala 2)
('2025-08-14 13:00:00', 2, 1, 1), -- Quinta - Pilates
('2025-08-14 14:00:00', 2, 1, 7), -- Quinta - Fisioterapia
('2025-08-14 16:00:00', 2, 1, 1), -- Quinta - Pilates
('2025-08-15 10:00:00', 2, 1, 1), -- Sexta - Pilates (Guilherme: 9h, 11h, 13h, 15h na Sala 2)
('2025-08-15 14:00:00', 2, 1, 3), -- Sexta - RPG
('2025-08-15 16:00:00', 2, 1, 7), -- Sexta - Fisioterapia
('2025-08-15 17:00:00', 2, 1, 1), -- Sexta - Pilates
('2025-08-18 10:00:00', 2, 1, 3), -- Segunda - RPG (Guilherme: 9h, 11h, 13h, 15h na Sala 2)
('2025-08-18 14:00:00', 2, 1, 1), -- Segunda - Pilates
('2025-08-18 16:00:00', 2, 1, 7), -- Segunda - Fisioterapia
('2025-08-18 17:00:00', 2, 1, 1), -- Segunda - Pilates
('2025-08-19 10:00:00', 2, 1, 1), -- Terça - Pilates (Guilherme: 9h, 11h, 14h, 16h na Sala 2)
('2025-08-19 13:00:00', 2, 1, 3), -- Terça - RPG
('2025-08-19 15:00:00', 2, 1, 7), -- Terça - Fisioterapia
('2025-08-19 17:00:00', 2, 1, 1), -- Terça - Pilates
('2025-08-20 10:00:00', 2, 1, 3), -- Quarta - RPG (Guilherme: 9h, 11h, 13h, 15h na Sala 2)
('2025-08-20 14:00:00', 2, 1, 1), -- Quarta - Pilates
('2025-08-20 16:00:00', 2, 1, 7), -- Quarta - Fisioterapia
('2025-08-20 17:00:00', 2, 1, 1), -- Quarta - Pilates
('2025-08-21 10:00:00', 2, 1, 3), -- Quinta - RPG (Guilherme: 9h, 11h, 15h, 17h na Sala 2)
('2025-08-21 13:00:00', 2, 1, 1), -- Quinta - Pilates
('2025-08-21 14:00:00', 2, 1, 7), -- Quinta - Fisioterapia
('2025-08-21 16:00:00', 2, 1, 1), -- Quinta - Pilates
('2025-08-22 10:00:00', 2, 1, 1), -- Sexta - Pilates (Guilherme: 9h, 11h, 13h, 15h na Sala 2)
('2025-08-22 14:00:00', 2, 1, 3), -- Sexta - RPG
('2025-08-22 16:00:00', 2, 1, 7), -- Sexta - Fisioterapia
('2025-08-22 17:00:00', 2, 1, 1), -- Sexta - Pilates
('2025-08-25 10:00:00', 2, 1, 1), -- Segunda - Pilates (Guilherme: 9h, 11h, 13h, 15h na Sala 2)
('2025-08-25 14:00:00', 2, 1, 3), -- Segunda - RPG
('2025-08-25 16:00:00', 2, 1, 7), -- Segunda - Fisioterapia
('2025-08-25 17:00:00', 2, 1, 1), -- Segunda - Pilates
('2025-08-26 10:00:00', 2, 1, 3), -- Terça - RPG (Guilherme: 9h, 11h, 14h, 16h na Sala 2)
('2025-08-26 13:00:00', 2, 1, 1), -- Terça - Pilates
('2025-08-26 15:00:00', 2, 1, 7), -- Terça - Fisioterapia
('2025-08-26 17:00:00', 2, 1, 1), -- Terça - Pilates
('2025-08-27 10:00:00', 2, 1, 1), -- Quarta - Pilates (Guilherme: 9h, 11h, 13h, 15h na Sala 2)
('2025-08-27 14:00:00', 2, 1, 3), -- Quarta - RPG
('2025-08-27 16:00:00', 2, 1, 7), -- Quarta - Fisioterapia
('2025-08-27 17:00:00', 2, 1, 1), -- Quarta - Pilates
('2025-08-28 10:00:00', 2, 1, 1), -- Quinta - Pilates (Guilherme: 9h, 11h, 15h, 17h na Sala 2)
('2025-08-28 13:00:00', 2, 1, 3), -- Quinta - RPG
('2025-08-28 14:00:00', 2, 1, 7), -- Quinta - Fisioterapia
('2025-08-28 16:00:00', 2, 1, 1), -- Quinta - Pilates
('2025-08-29 10:00:00', 2, 1, 3), -- Sexta - RPG (Guilherme: 9h, 11h, 13h, 15h na Sala 2)
('2025-08-29 14:00:00', 2, 1, 1), -- Sexta - Pilates
('2025-08-29 16:00:00', 2, 1, 7), -- Sexta - Fisioterapia
('2025-08-29 17:00:00', 2, 1, 1); -- Sexta - Pilates

-- SETEMBRO 2025
INSERT INTO agendamento (data_hora, professor_id, sala_id, especialidade_id) VALUES
('2025-09-01 10:00:00', 2, 1, 3), -- Segunda - RPG (Guilherme: 9h, 11h, 13h, 15h na Sala 2)
('2025-09-01 14:00:00', 2, 1, 1), -- Segunda - Pilates
('2025-09-01 16:00:00', 2, 1, 7), -- Segunda - Fisioterapia
('2025-09-01 17:00:00', 2, 1, 1), -- Segunda - Pilates
('2025-09-02 10:00:00', 2, 1, 1), -- Terça - Pilates (Guilherme: 9h, 11h, 14h, 16h na Sala 2)
('2025-09-02 13:00:00', 2, 1, 3), -- Terça - RPG
('2025-09-02 15:00:00', 2, 1, 7), -- Terça - Fisioterapia
('2025-09-02 17:00:00', 2, 1, 1), -- Terça - Pilates
('2025-09-03 10:00:00', 2, 1, 3), -- Quarta - RPG (Guilherme: 9h, 11h, 13h, 15h na Sala 2)
('2025-09-03 14:00:00', 2, 1, 1), -- Quarta - Pilates
('2025-09-03 16:00:00', 2, 1, 7), -- Quarta - Fisioterapia
('2025-09-03 17:00:00', 2, 1, 1), -- Quarta - Pilates
('2025-09-04 10:00:00', 2, 1, 1), -- Quinta - Pilates (Guilherme: 9h, 11h, 15h, 17h na Sala 2)
('2025-09-04 13:00:00', 2, 1, 3), -- Quinta - RPG
('2025-09-04 14:00:00', 2, 1, 7), -- Quinta - Fisioterapia
('2025-09-04 16:00:00', 2, 1, 1), -- Quinta - Pilates
('2025-09-05 10:00:00', 2, 1, 3), -- Sexta - RPG (Guilherme: 9h, 11h, 13h, 15h na Sala 2)
('2025-09-05 14:00:00', 2, 1, 1), -- Sexta - Pilates
('2025-09-05 16:00:00', 2, 1, 7), -- Sexta - Fisioterapia
('2025-09-05 17:00:00', 2, 1, 1), -- Sexta - Pilates
('2025-09-08 10:00:00', 2, 1, 1), -- Segunda - Pilates (Guilherme: 9h, 11h, 13h, 15h na Sala 2)
('2025-09-08 14:00:00', 2, 1, 3), -- Segunda - RPG
('2025-09-08 16:00:00', 2, 1, 7), -- Segunda - Fisioterapia
('2025-09-08 17:00:00', 2, 1, 1), -- Segunda - Pilates
('2025-09-09 10:00:00', 2, 1, 3), -- Terça - RPG (Guilherme: 9h, 11h, 14h, 16h na Sala 2)
('2025-09-09 13:00:00', 2, 1, 1), -- Terça - Pilates
('2025-09-09 15:00:00', 2, 1, 7), -- Terça - Fisioterapia
('2025-09-09 17:00:00', 2, 1, 1), -- Terça - Pilates
('2025-09-10 10:00:00', 2, 1, 1), -- Quarta - Pilates (Guilherme: 9h, 11h, 13h, 15h na Sala 2)
('2025-09-10 14:00:00', 2, 1, 3), -- Quarta - RPG
('2025-09-10 16:00:00', 2, 1, 7), -- Quarta - Fisioterapia
('2025-09-10 17:00:00', 2, 1, 1), -- Quarta - Pilates
('2025-09-11 10:00:00', 2, 1, 1), -- Quinta - Pilates (Guilherme: 9h, 11h, 15h, 17h na Sala 2)
('2025-09-11 13:00:00', 2, 1, 3), -- Quinta - RPG
('2025-09-11 14:00:00', 2, 1, 7), -- Quinta - Fisioterapia
('2025-09-11 16:00:00', 2, 1, 1), -- Quinta - Pilates
('2025-09-12 10:00:00', 2, 1, 3), -- Sexta - RPG (Guilherme: 9h, 11h, 13h, 15h na Sala 2)
('2025-09-12 14:00:00', 2, 1, 1), -- Sexta - Pilates
('2025-09-12 16:00:00', 2, 1, 7), -- Sexta - Fisioterapia
('2025-09-12 17:00:00', 2, 1, 1), -- Sexta - Pilates
('2025-09-15 10:00:00', 2, 1, 1), -- Segunda - Pilates (Guilherme: 9h, 11h, 13h, 15h na Sala 2)
('2025-09-15 14:00:00', 2, 1, 3), -- Segunda - RPG
('2025-09-15 16:00:00', 2, 1, 7), -- Segunda - Fisioterapia
('2025-09-15 17:00:00', 2, 1, 1), -- Segunda - Pilates
('2025-09-16 10:00:00', 2, 1, 3), -- Terça - RPG (Guilherme: 9h, 11h, 14h, 16h na Sala 2)
('2025-09-16 13:00:00', 2, 1, 1), -- Terça - Pilates
('2025-09-16 15:00:00', 2, 1, 7), -- Terça - Fisioterapia
('2025-09-16 17:00:00', 2, 1, 1), -- Terça - Pilates
('2025-09-17 10:00:00', 2, 1, 1), -- Quarta - Pilates (Guilherme: 9h, 11h, 13h, 15h na Sala 2)
('2025-09-17 14:00:00', 2, 1, 3), -- Quarta - RPG
('2025-09-17 16:00:00', 2, 1, 7), -- Quarta - Fisioterapia
('2025-09-17 17:00:00', 2, 1, 1), -- Quarta - Pilates
('2025-09-18 10:00:00', 2, 1, 1), -- Quinta - Pilates (Guilherme: 9h, 11h, 15h, 17h na Sala 2)
('2025-09-18 13:00:00', 2, 1, 3), -- Quinta - RPG
('2025-09-18 14:00:00', 2, 1, 7), -- Quinta - Fisioterapia
('2025-09-18 16:00:00', 2, 1, 1), -- Quinta - Pilates
('2025-09-19 10:00:00', 2, 1, 3), -- Sexta - RPG (Guilherme: 9h, 11h, 13h, 15h na Sala 2)
('2025-09-19 14:00:00', 2, 1, 1), -- Sexta - Pilates
('2025-09-19 16:00:00', 2, 1, 7), -- Sexta - Fisioterapia
('2025-09-19 17:00:00', 2, 1, 1), -- Sexta - Pilates
('2025-09-22 10:00:00', 2, 1, 1), -- Segunda - Pilates (Guilherme: 9h, 11h, 13h, 15h na Sala 2)
('2025-09-22 14:00:00', 2, 1, 3), -- Segunda - RPG
('2025-09-22 16:00:00', 2, 1, 7), -- Segunda - Fisioterapia
('2025-09-22 17:00:00', 2, 1, 1), -- Segunda - Pilates
('2025-09-23 10:00:00', 2, 1, 3), -- Terça - RPG (Guilherme: 9h, 11h, 14h, 16h na Sala 2)
('2025-09-23 13:00:00', 2, 1, 1), -- Terça - Pilates
('2025-09-23 15:00:00', 2, 1, 7), -- Terça - Fisioterapia
('2025-09-23 17:00:00', 2, 1, 1), -- Terça - Pilates
('2025-09-24 10:00:00', 2, 1, 1), -- Quarta - Pilates (Guilherme: 9h, 11h, 13h, 15h na Sala 2)
('2025-09-24 14:00:00', 2, 1, 3), -- Quarta - RPG
('2025-09-24 16:00:00', 2, 1, 7), -- Quarta - Fisioterapia
('2025-09-24 17:00:00', 2, 1, 1), -- Quarta - Pilates
('2025-09-25 10:00:00', 2, 1, 1), -- Quinta - Pilates (Guilherme: 9h, 11h, 15h, 17h na Sala 2)
('2025-09-25 13:00:00', 2, 1, 3), -- Quinta - RPG
('2025-09-25 14:00:00', 2, 1, 7), -- Quinta - Fisioterapia
('2025-09-25 16:00:00', 2, 1, 1), -- Quinta - Pilates
('2025-09-26 10:00:00', 2, 1, 3), -- Sexta - RPG (Guilherme: 9h, 11h, 13h, 15h na Sala 2)
('2025-09-26 14:00:00', 2, 1, 1), -- Sexta - Pilates
('2025-09-26 16:00:00', 2, 1, 7), -- Sexta - Fisioterapia
('2025-09-26 17:00:00', 2, 1, 1); -- Sexta - Pilates

-- OUTUBRO 2025
INSERT INTO agendamento (data_hora, professor_id, sala_id, especialidade_id) VALUES
('2025-10-01 10:00:00', 2, 1, 1), -- Quarta - Pilates (Guilherme: 9h, 11h, 13h, 15h na Sala 2)
('2025-10-01 14:00:00', 2, 1, 3), -- Quarta - RPG
('2025-10-01 16:00:00', 2, 1, 7), -- Quarta - Fisioterapia
('2025-10-01 17:00:00', 2, 1, 1), -- Quarta - Pilates
('2025-10-02 10:00:00', 2, 1, 3), -- Quinta - RPG (Guilherme: 9h, 11h, 15h, 17h na Sala 2)
('2025-10-02 13:00:00', 2, 1, 1), -- Quinta - Pilates
('2025-10-02 14:00:00', 2, 1, 7), -- Quinta - Fisioterapia
('2025-10-02 16:00:00', 2, 1, 1), -- Quinta - Pilates
('2025-10-03 10:00:00', 2, 1, 1), -- Sexta - Pilates (Guilherme: 9h, 11h, 13h, 15h na Sala 2)
('2025-10-03 14:00:00', 2, 1, 3), -- Sexta - RPG
('2025-10-03 16:00:00', 2, 1, 7), -- Sexta - Fisioterapia
('2025-10-03 17:00:00', 2, 1, 1), -- Sexta - Pilates
('2025-10-06 10:00:00', 2, 1, 1), -- Segunda - Pilates (Guilherme: 9h, 11h, 13h, 15h na Sala 2)
('2025-10-06 14:00:00', 2, 1, 3), -- Segunda - RPG
('2025-10-06 16:00:00', 2, 1, 7), -- Segunda - Fisioterapia
('2025-10-06 17:00:00', 2, 1, 1), -- Segunda - Pilates
('2025-10-07 10:00:00', 2, 1, 3), -- Terça - RPG (Guilherme: 9h, 11h, 14h, 16h na Sala 2)
('2025-10-07 13:00:00', 2, 1, 1), -- Terça - Pilates
('2025-10-07 15:00:00', 2, 1, 7), -- Terça - Fisioterapia
('2025-10-07 17:00:00', 2, 1, 1), -- Terça - Pilates
('2025-10-08 10:00:00', 2, 1, 1), -- Quarta - Pilates (Guilherme: 9h, 11h, 13h, 15h na Sala 2)
('2025-10-08 14:00:00', 2, 1, 3), -- Quarta - RPG
('2025-10-08 16:00:00', 2, 1, 7), -- Quarta - Fisioterapia
('2025-10-08 17:00:00', 2, 1, 1), -- Quarta - Pilates
('2025-10-09 10:00:00', 2, 1, 1), -- Quinta - Pilates (Guilherme: 9h, 11h, 15h, 17h na Sala 2)
('2025-10-09 13:00:00', 2, 1, 3), -- Quinta - RPG
('2025-10-09 14:00:00', 2, 1, 7), -- Quinta - Fisioterapia
('2025-10-09 16:00:00', 2, 1, 1), -- Quinta - Pilates
('2025-10-10 10:00:00', 2, 1, 3), -- Sexta - RPG (Guilherme: 9h, 11h, 13h, 15h na Sala 2)
('2025-10-10 14:00:00', 2, 1, 1), -- Sexta - Pilates
('2025-10-10 16:00:00', 2, 1, 7), -- Sexta - Fisioterapia
('2025-10-10 17:00:00', 2, 1, 1), -- Sexta - Pilates
('2025-10-13 10:00:00', 2, 1, 3), -- Segunda - RPG (Guilherme: 9h, 11h, 15h, 17h na Sala 2)
('2025-10-13 14:00:00', 2, 1, 1), -- Segunda - Pilates
('2025-10-13 16:00:00', 2, 1, 7), -- Segunda - Fisioterapia
('2025-10-13 18:00:00', 2, 1, 1), -- Segunda - Pilates
('2025-10-14 10:00:00', 2, 1, 1), -- Terça - Pilates (Guilherme: 9h, 11h, 14h, 16h na Sala 2)
('2025-10-14 13:00:00', 2, 1, 3), -- Terça - RPG
('2025-10-14 15:00:00', 2, 1, 7), -- Terça - Fisioterapia
('2025-10-14 17:00:00', 2, 1, 1), -- Terça - Pilates
('2025-10-15 10:00:00', 2, 1, 3), -- Quarta - RPG (Guilherme: 9h, 11h, 13h, 15h na Sala 2)
('2025-10-15 14:00:00', 2, 1, 1), -- Quarta - Pilates
('2025-10-15 16:00:00', 2, 1, 7), -- Quarta - Fisioterapia
('2025-10-15 17:00:00', 2, 1, 1), -- Quarta - Pilates
('2025-10-16 10:00:00', 2, 1, 1), -- Quinta - Pilates (Guilherme: 9h, 11h, 15h, 17h na Sala 2)
('2025-10-16 13:00:00', 2, 1, 3), -- Quinta - RPG
('2025-10-16 14:00:00', 2, 1, 7), -- Quinta - Fisioterapia
('2025-10-16 16:00:00', 2, 1, 1), -- Quinta - Pilates
('2025-10-17 10:00:00', 2, 1, 3), -- Sexta - RPG (Guilherme: 9h, 11h, 13h, 15h na Sala 2)
('2025-10-17 14:00:00', 2, 1, 1), -- Sexta - Pilates
('2025-10-17 16:00:00', 2, 1, 7), -- Sexta - Fisioterapia
('2025-10-17 17:00:00', 2, 1, 1), -- Sexta - Pilates
('2025-10-20 10:00:00', 2, 1, 1), -- Segunda - Pilates (Guilherme: 9h, 11h, 13h, 15h na Sala 2)
('2025-10-20 14:00:00', 2, 1, 3), -- Segunda - RPG
('2025-10-20 16:00:00', 2, 1, 7), -- Segunda - Fisioterapia
('2025-10-20 17:00:00', 2, 1, 1), -- Segunda - Pilates
('2025-10-21 10:00:00', 2, 1, 3), -- Terça - RPG (Guilherme: 9h, 11h, 14h, 16h na Sala 2)
('2025-10-21 13:00:00', 2, 1, 1), -- Terça - Pilates
('2025-10-21 15:00:00', 2, 1, 7), -- Terça - Fisioterapia
('2025-10-21 17:00:00', 2, 1, 1), -- Terça - Pilates
('2025-10-22 10:00:00', 2, 1, 1), -- Quarta - Pilates (Guilherme: 9h, 11h, 13h, 15h na Sala 2)
('2025-10-22 14:00:00', 2, 1, 3), -- Quarta - RPG
('2025-10-22 16:00:00', 2, 1, 7), -- Quarta - Fisioterapia
('2025-10-22 17:00:00', 2, 1, 1), -- Quarta - Pilates
('2025-10-23 10:00:00', 2, 1, 1), -- Quinta - Pilates (Guilherme: 9h, 11h, 15h, 17h na Sala 2)
('2025-10-23 13:00:00', 2, 1, 3), -- Quinta - RPG
('2025-10-23 14:00:00', 2, 1, 7), -- Quinta - Fisioterapia
('2025-10-23 16:00:00', 2, 1, 1), -- Quinta - Pilates
('2025-10-24 10:00:00', 2, 1, 3), -- Sexta - RPG (Guilherme: 9h, 11h, 13h, 15h na Sala 2)
('2025-10-24 14:00:00', 2, 1, 1), -- Sexta - Pilates
('2025-10-24 16:00:00', 2, 1, 7), -- Sexta - Fisioterapia
('2025-10-24 17:00:00', 2, 1, 1), -- Sexta - Pilates
('2025-10-27 10:00:00', 2, 1, 1), -- Segunda - Pilates (Guilherme: 9h, 11h, 13h, 15h na Sala 2)
('2025-10-27 14:00:00', 2, 1, 3), -- Segunda - RPG
('2025-10-27 16:00:00', 2, 1, 7), -- Segunda - Fisioterapia
('2025-10-27 17:00:00', 2, 1, 1), -- Segunda - Pilates
('2025-10-28 10:00:00', 2, 1, 3), -- Terça - RPG (Guilherme: 9h, 11h, 14h, 16h na Sala 2)
('2025-10-28 13:00:00', 2, 1, 1), -- Terça - Pilates
('2025-10-28 15:00:00', 2, 1, 7), -- Terça - Fisioterapia
('2025-10-28 17:00:00', 2, 1, 1), -- Terça - Pilates
('2025-10-29 10:00:00', 2, 1, 1), -- Quarta - Pilates (Guilherme: 9h, 11h, 13h, 15h na Sala 2)
('2025-10-29 14:00:00', 2, 1, 3), -- Quarta - RPG
('2025-10-29 16:00:00', 2, 1, 7), -- Quarta - Fisioterapia
('2025-10-29 17:00:00', 2, 1, 1), -- Quarta - Pilates
('2025-10-30 10:00:00', 2, 1, 1), -- Quinta - Pilates (Guilherme: 9h, 11h, 15h, 17h na Sala 2)
('2025-10-30 13:00:00', 2, 1, 3), -- Quinta - RPG
('2025-10-30 14:00:00', 2, 1, 7), -- Quinta - Fisioterapia
('2025-10-30 16:00:00', 2, 1, 1), -- Quinta - Pilates
('2025-10-31 10:00:00', 2, 1, 3), -- Sexta - RPG (Guilherme: 9h, 11h, 13h, 15h na Sala 2)
('2025-10-31 14:00:00', 2, 1, 1), -- Sexta - Pilates
('2025-10-31 16:00:00', 2, 1, 7), -- Sexta - Fisioterapia
('2025-10-31 17:00:00', 2, 1, 1); -- Sexta - Pilates

-- NOVEMBRO 2025
INSERT INTO agendamento (data_hora, professor_id, sala_id, especialidade_id) VALUES
('2025-11-03 10:00:00', 2, 1, 1), -- Segunda - Pilates (Guilherme: 9h, 11h, 13h, 15h na Sala 2)
('2025-11-03 14:00:00', 2, 1, 3), -- Segunda - RPG
('2025-11-03 16:00:00', 2, 1, 7), -- Segunda - Fisioterapia
('2025-11-03 17:00:00', 2, 1, 1), -- Segunda - Pilates
('2025-11-04 10:00:00', 2, 1, 3), -- Terça - RPG (Guilherme: 9h, 11h, 14h, 16h na Sala 2)
('2025-11-04 13:00:00', 2, 1, 1), -- Terça - Pilates
('2025-11-04 15:00:00', 2, 1, 7), -- Terça - Fisioterapia
('2025-11-04 17:00:00', 2, 1, 1), -- Terça - Pilates
('2025-11-05 10:00:00', 2, 1, 1), -- Quarta - Pilates (Guilherme: 9h, 11h, 13h, 15h na Sala 2)
('2025-11-05 14:00:00', 2, 1, 3), -- Quarta - RPG
('2025-11-05 16:00:00', 2, 1, 7), -- Quarta - Fisioterapia
('2025-11-05 17:00:00', 2, 1, 1), -- Quarta - Pilates
('2025-11-06 10:00:00', 2, 1, 1), -- Quinta - Pilates (Guilherme: 9h, 11h, 15h, 17h na Sala 2)
('2025-11-06 13:00:00', 2, 1, 3), -- Quinta - RPG
('2025-11-06 14:00:00', 2, 1, 7), -- Quinta - Fisioterapia
('2025-11-06 16:00:00', 2, 1, 1), -- Quinta - Pilates
('2025-11-07 10:00:00', 2, 1, 3), -- Sexta - RPG (Guilherme: 9h, 11h, 13h, 15h na Sala 2)
('2025-11-07 14:00:00', 2, 1, 1), -- Sexta - Pilates
('2025-11-07 16:00:00', 2, 1, 7), -- Sexta - Fisioterapia
('2025-11-07 17:00:00', 2, 1, 1), -- Sexta - Pilates
('2025-11-10 10:00:00', 2, 1, 3), -- Segunda - RPG (Guilherme: 9h, 11h, 15h, 17h na Sala 2)
('2025-11-10 14:00:00', 2, 1, 1), -- Segunda - Pilates
('2025-11-10 16:00:00', 2, 1, 7), -- Segunda - Fisioterapia
('2025-11-10 18:00:00', 2, 1, 1), -- Segunda - Pilates
('2025-11-11 10:00:00', 2, 1, 1), -- Terça - Pilates (Guilherme: 9h, 11h, 14h, 16h na Sala 2)
('2025-11-11 13:00:00', 2, 1, 3), -- Terça - RPG
('2025-11-11 15:00:00', 2, 1, 7), -- Terça - Fisioterapia
('2025-11-11 17:00:00', 2, 1, 1), -- Terça - Pilates
('2025-11-12 10:00:00', 2, 1, 3), -- Quarta - RPG (Guilherme: 9h, 11h, 13h, 15h na Sala 2)
('2025-11-12 14:00:00', 2, 1, 1), -- Quarta - Pilates
('2025-11-12 16:00:00', 2, 1, 7), -- Quarta - Fisioterapia
('2025-11-12 17:00:00', 2, 1, 1), -- Quarta - Pilates
('2025-11-13 10:00:00', 2, 1, 1), -- Quinta - Pilates (Guilherme: 9h, 11h, 15h, 17h na Sala 2)
('2025-11-13 13:00:00', 2, 1, 3), -- Quinta - RPG
('2025-11-13 14:00:00', 2, 1, 7), -- Quinta - Fisioterapia
('2025-11-13 16:00:00', 2, 1, 1), -- Quinta - Pilates
('2025-11-14 10:00:00', 2, 1, 3), -- Sexta - RPG (Guilherme: 9h, 11h, 13h, 15h na Sala 2)
('2025-11-14 14:00:00', 2, 1, 1), -- Sexta - Pilates
('2025-11-14 16:00:00', 2, 1, 7), -- Sexta - Fisioterapia
('2025-11-14 17:00:00', 2, 1, 1), -- Sexta - Pilates
('2025-11-17 10:00:00', 2, 1, 1), -- Segunda - Pilates (Guilherme: 9h, 11h, 13h, 15h na Sala 2)
('2025-11-17 14:00:00', 2, 1, 3), -- Segunda - RPG
('2025-11-17 16:00:00', 2, 1, 7), -- Segunda - Fisioterapia
('2025-11-17 17:00:00', 2, 1, 1), -- Segunda - Pilates
('2025-11-18 10:00:00', 2, 1, 3), -- Terça - RPG (Guilherme: 9h, 11h, 14h, 16h na Sala 2)
('2025-11-18 13:00:00', 2, 1, 1), -- Terça - Pilates
('2025-11-18 15:00:00', 2, 1, 7), -- Terça - Fisioterapia
('2025-11-18 17:00:00', 2, 1, 1), -- Terça - Pilates
('2025-11-19 10:00:00', 2, 1, 1), -- Quarta - Pilates (Guilherme: 9h, 11h, 13h, 15h na Sala 2)
('2025-11-19 14:00:00', 2, 1, 3), -- Quarta - RPG
('2025-11-19 16:00:00', 2, 1, 7), -- Quarta - Fisioterapia
('2025-11-19 17:00:00', 2, 1, 1), -- Quarta - Pilates
('2025-11-20 10:00:00', 2, 1, 1), -- Quinta - Pilates (Guilherme: 9h, 11h, 15h, 17h na Sala 2)
('2025-11-20 13:00:00', 2, 1, 3), -- Quinta - RPG
('2025-11-20 14:00:00', 2, 1, 7), -- Quinta - Fisioterapia
('2025-11-20 16:00:00', 2, 1, 1), -- Quinta - Pilates
('2025-11-21 10:00:00', 2, 1, 3), -- Sexta - RPG (Guilherme: 9h, 11h, 13h, 15h na Sala 2)
('2025-11-21 14:00:00', 2, 1, 1), -- Sexta - Pilates
('2025-11-21 16:00:00', 2, 1, 7), -- Sexta - Fisioterapia
('2025-11-21 17:00:00', 2, 1, 1), -- Sexta - Pilates
('2025-11-24 10:00:00', 2, 1, 1), -- Segunda - Pilates (Guilherme: 9h, 11h, 13h, 15h na Sala 2)
('2025-11-24 14:00:00', 2, 1, 3), -- Segunda - RPG
('2025-11-24 16:00:00', 2, 1, 7), -- Segunda - Fisioterapia
('2025-11-24 17:00:00', 2, 1, 1), -- Segunda - Pilates
('2025-11-25 10:00:00', 2, 1, 3), -- Terça - RPG (Guilherme: 9h, 11h, 14h, 16h na Sala 2)
('2025-11-25 13:00:00', 2, 1, 1), -- Terça - Pilates
('2025-11-25 15:00:00', 2, 1, 7), -- Terça - Fisioterapia
('2025-11-25 17:00:00', 2, 1, 1), -- Terça - Pilates
('2025-11-26 10:00:00', 2, 1, 1), -- Quarta - Pilates (Guilherme: 9h, 11h, 13h, 15h na Sala 2)
('2025-11-26 14:00:00', 2, 1, 3), -- Quarta - RPG
('2025-11-26 16:00:00', 2, 1, 7), -- Quarta - Fisioterapia
('2025-11-26 17:00:00', 2, 1, 1), -- Quarta - Pilates
('2025-11-27 10:00:00', 2, 1, 1), -- Quinta - Pilates (Guilherme: 9h, 11h, 15h, 17h na Sala 2)
('2025-11-27 13:00:00', 2, 1, 3), -- Quinta - RPG
('2025-11-27 14:00:00', 2, 1, 7), -- Quinta - Fisioterapia
('2025-11-27 16:00:00', 2, 1, 1), -- Quinta - Pilates
('2025-11-28 10:00:00', 2, 1, 3), -- Sexta - RPG (Guilherme: 9h, 11h, 13h, 15h na Sala 2)
('2025-11-28 14:00:00', 2, 1, 1), -- Sexta - Pilates
('2025-11-28 16:00:00', 2, 1, 7), -- Sexta - Fisioterapia
('2025-11-28 17:00:00', 2, 1, 1); -- Sexta - Pilates

-- DEZEMBRO 2025
INSERT INTO agendamento (data_hora, professor_id, sala_id, especialidade_id) VALUES
('2025-12-01 10:00:00', 2, 1, 1), -- Segunda - Pilates (Guilherme: 9h, 11h, 13h, 15h na Sala 2)
('2025-12-01 14:00:00', 2, 1, 3), -- Segunda - RPG
('2025-12-01 16:00:00', 2, 1, 7), -- Segunda - Fisioterapia
('2025-12-01 17:00:00', 2, 1, 1), -- Segunda - Pilates
('2025-12-02 10:00:00', 2, 1, 3), -- Terça - RPG (Guilherme: 9h, 11h, 14h, 16h na Sala 2)
('2025-12-02 13:00:00', 2, 1, 1), -- Terça - Pilates
('2025-12-02 15:00:00', 2, 1, 7), -- Terça - Fisioterapia
('2025-12-02 17:00:00', 2, 1, 1), -- Terça - Pilates
('2025-12-03 10:00:00', 2, 1, 1), -- Quarta - Pilates (Guilherme: 9h, 11h, 13h, 15h na Sala 2)
('2025-12-03 14:00:00', 2, 1, 3), -- Quarta - RPG
('2025-12-03 16:00:00', 2, 1, 7), -- Quarta - Fisioterapia
('2025-12-03 17:00:00', 2, 1, 1), -- Quarta - Pilates
('2025-12-04 10:00:00', 2, 1, 1), -- Quinta - Pilates (Guilherme: 9h, 11h, 15h, 17h na Sala 2)
('2025-12-04 13:00:00', 2, 1, 3), -- Quinta - RPG
('2025-12-04 14:00:00', 2, 1, 7), -- Quinta - Fisioterapia
('2025-12-04 16:00:00', 2, 1, 1), -- Quinta - Pilates
('2025-12-05 10:00:00', 2, 1, 3), -- Sexta - RPG (Guilherme: 9h, 11h, 13h, 15h na Sala 2)
('2025-12-05 14:00:00', 2, 1, 1), -- Sexta - Pilates
('2025-12-05 16:00:00', 2, 1, 7), -- Sexta - Fisioterapia
('2025-12-05 17:00:00', 2, 1, 1), -- Sexta - Pilates
('2025-12-08 10:00:00', 2, 1, 3), -- Segunda - RPG (Guilherme: 9h, 11h, 15h, 17h na Sala 2)
('2025-12-08 14:00:00', 2, 1, 1), -- Segunda - Pilates
('2025-12-08 16:00:00', 2, 1, 7), -- Segunda - Fisioterapia
('2025-12-08 18:00:00', 2, 1, 1), -- Segunda - Pilates
('2025-12-09 10:00:00', 2, 1, 1), -- Terça - Pilates (Guilherme: 9h, 11h, 14h, 16h na Sala 2)
('2025-12-09 13:00:00', 2, 1, 3), -- Terça - RPG
('2025-12-09 15:00:00', 2, 1, 7), -- Terça - Fisioterapia
('2025-12-09 17:00:00', 2, 1, 1), -- Terça - Pilates
('2025-12-10 10:00:00', 2, 1, 3), -- Quarta - RPG (Guilherme: 9h, 11h, 13h, 15h na Sala 2)
('2025-12-10 14:00:00', 2, 1, 1), -- Quarta - Pilates
('2025-12-10 16:00:00', 2, 1, 7), -- Quarta - Fisioterapia
('2025-12-10 17:00:00', 2, 1, 1), -- Quarta - Pilates
('2025-12-11 10:00:00', 2, 1, 1), -- Quinta - Pilates (Guilherme: 9h, 11h, 15h, 17h na Sala 2)
('2025-12-11 13:00:00', 2, 1, 3), -- Quinta - RPG
('2025-12-11 14:00:00', 2, 1, 7), -- Quinta - Fisioterapia
('2025-12-11 16:00:00', 2, 1, 1), -- Quinta - Pilates
('2025-12-12 10:00:00', 2, 1, 3), -- Sexta - RPG (Guilherme: 9h, 11h, 13h, 15h na Sala 2)
('2025-12-12 14:00:00', 2, 1, 1), -- Sexta - Pilates
('2025-12-12 16:00:00', 2, 1, 7), -- Sexta - Fisioterapia
('2025-12-12 17:00:00', 2, 1, 1), -- Sexta - Pilates
('2025-12-15 10:00:00', 2, 1, 1), -- Segunda - Pilates (Guilherme: 9h, 11h, 13h, 15h na Sala 2)
('2025-12-15 14:00:00', 2, 1, 3), -- Segunda - RPG
('2025-12-15 16:00:00', 2, 1, 7), -- Segunda - Fisioterapia
('2025-12-15 17:00:00', 2, 1, 1), -- Segunda - Pilates
('2025-12-16 10:00:00', 2, 1, 3), -- Terça - RPG (Guilherme: 9h, 11h, 14h, 16h na Sala 2)
('2025-12-16 13:00:00', 2, 1, 1), -- Terça - Pilates
('2025-12-16 15:00:00', 2, 1, 7), -- Terça - Fisioterapia
('2025-12-16 17:00:00', 2, 1, 1), -- Terça - Pilates
('2025-12-17 10:00:00', 2, 1, 1), -- Quarta - Pilates (Guilherme: 9h, 11h, 13h, 15h na Sala 2)
('2025-12-17 14:00:00', 2, 1, 3), -- Quarta - RPG
('2025-12-17 16:00:00', 2, 1, 7), -- Quarta - Fisioterapia
('2025-12-17 17:00:00', 2, 1, 1), -- Quarta - Pilates
('2025-12-18 10:00:00', 2, 1, 1), -- Quinta - Pilates (Guilherme: 9h, 11h, 15h, 17h na Sala 2)
('2025-12-18 13:00:00', 2, 1, 3), -- Quinta - RPG
('2025-12-18 14:00:00', 2, 1, 7), -- Quinta - Fisioterapia
('2025-12-18 16:00:00', 2, 1, 1), -- Quinta - Pilates
('2025-12-19 10:00:00', 2, 1, 3), -- Sexta - RPG (Guilherme: 9h, 11h, 13h, 15h na Sala 2)
('2025-12-19 14:00:00', 2, 1, 1), -- Sexta - Pilates
('2025-12-19 16:00:00', 2, 1, 7), -- Sexta - Fisioterapia
('2025-12-19 17:00:00', 2, 1, 1), -- Sexta - Pilates
('2025-12-22 10:00:00', 2, 1, 1), -- Segunda - Pilates (Guilherme: 9h, 11h, 13h, 15h na Sala 2)
('2025-12-22 14:00:00', 2, 1, 3), -- Segunda - RPG
('2025-12-22 16:00:00', 2, 1, 7), -- Segunda - Fisioterapia
('2025-12-22 17:00:00', 2, 1, 1); -- Segunda - Pilates

-- ============================================
-- 11. INSERIR RELACIONAMENTOS AGENDAMENTO-ALUNO
-- ============================================
-- NOTA: StatusPresenca é um ENUM com valores: PENDENTE, PRESENTE, FALTA
-- Agendamentos passados (até 14/11/2025): PRESENTE ou FALTA
-- Agendamentos futuros (após 14/11/2025): PENDENTE
-- IMPORTANTE: Distribuir alunos evitando conflitos de horário entre professores

-- ============================================
-- AGENDAMENTOS DO PROFESSOR GUILHERME (IDs 1-240)
-- ============================================
-- Estratégia: Guilherme usa principalmente alunos 1-10 para evitar conflitos com Andrei
-- Agendamentos de agosto do Guilherme (IDs 1-48) - PASSADOS
INSERT INTO agendamento_aluno (agendamento_id, aluno_id, status_presenca) VALUES
-- Agendamento 1 (04/08 09:00 - Segunda - Pilates)
(1, 1, 'PRESENTE'), (1, 2, 'PRESENTE'), (1, 3, 'PRESENTE'), (1, 4, 'FALTA'),
-- Agendamento 2 (04/08 11:00 - Segunda - RPG)
(2, 2, 'PRESENTE'), (2, 3, 'PRESENTE'), (2, 4, 'PRESENTE'), (2, 5, 'FALTA'),
-- Agendamento 3 (04/08 13:00 - Segunda - Fisioterapia)
(3, 3, 'PRESENTE'), (3, 4, 'PRESENTE'), (3, 5, 'PRESENTE'), (3, 6, 'FALTA'),
-- Agendamento 4 (04/08 15:00 - Segunda - Pilates)
(4, 4, 'PRESENTE'), (4, 5, 'PRESENTE'), (4, 6, 'PRESENTE'), (4, 7, 'FALTA'),
-- Agendamento 5 (05/08 09:00 - Terça - RPG)
(5, 5, 'PRESENTE'), (5, 6, 'PRESENTE'), (5, 7, 'PRESENTE'), (5, 8, 'FALTA'),
-- Agendamento 6 (05/08 11:00 - Terça - Pilates)
(6, 6, 'PRESENTE'), (6, 7, 'PRESENTE'), (6, 8, 'PRESENTE'), (6, 9, 'FALTA'),
-- Agendamento 7 (05/08 14:00 - Terça - Fisioterapia)
(7, 7, 'PRESENTE'), (7, 8, 'PRESENTE'), (7, 9, 'PRESENTE'), (7, 10, 'FALTA'),
-- Agendamento 8 (05/08 16:00 - Terça - Pilates)
(8, 8, 'PRESENTE'), (8, 9, 'PRESENTE'), (8, 10, 'PRESENTE'), (8, 1, 'FALTA'),
-- Agendamento 9 (06/08 09:00 - Quarta - Pilates)
(9, 9, 'PRESENTE'), (9, 10, 'PRESENTE'), (9, 1, 'PRESENTE'), (9, 2, 'FALTA'),
-- Agendamento 10 (06/08 11:00 - Quarta - RPG)
(10, 10, 'PRESENTE'), (10, 1, 'PRESENTE'), (10, 2, 'PRESENTE'), (10, 3, 'FALTA'),
-- Agendamento 11 (06/08 13:00 - Quarta - Fisioterapia)
(11, 1, 'PRESENTE'), (11, 2, 'PRESENTE'), (11, 3, 'PRESENTE'), (11, 4, 'FALTA'),
-- Agendamento 12 (06/08 15:00 - Quarta - Pilates)
(12, 2, 'PRESENTE'), (12, 3, 'PRESENTE'), (12, 4, 'PRESENTE'), (12, 5, 'FALTA'),
-- Agendamento 13 (07/08 09:00 - Quinta - RPG)
(13, 3, 'PRESENTE'), (13, 4, 'PRESENTE'), (13, 5, 'PRESENTE'), (13, 6, 'FALTA'),
-- Agendamento 14 (07/08 11:00 - Quinta - Pilates)
(14, 4, 'PRESENTE'), (14, 5, 'PRESENTE'), (14, 6, 'PRESENTE'), (14, 7, 'FALTA'),
-- Agendamento 15 (07/08 15:00 - Quinta - Fisioterapia)
(15, 5, 'PRESENTE'), (15, 6, 'PRESENTE'), (15, 7, 'PRESENTE'), (15, 8, 'FALTA'),
-- Agendamento 16 (07/08 17:00 - Quinta - Pilates)
(16, 6, 'PRESENTE'), (16, 7, 'PRESENTE'), (16, 8, 'PRESENTE'), (16, 9, 'FALTA'),
-- Agendamento 17 (08/08 09:00 - Sexta - Pilates)
(17, 7, 'PRESENTE'), (17, 8, 'PRESENTE'), (17, 9, 'PRESENTE'), (17, 10, 'FALTA'),
-- Agendamento 18 (08/08 11:00 - Sexta - RPG)
(18, 8, 'PRESENTE'), (18, 9, 'PRESENTE'), (18, 10, 'PRESENTE'), (18, 1, 'FALTA'),
-- Agendamento 19 (08/08 13:00 - Sexta - Fisioterapia)
(19, 9, 'PRESENTE'), (19, 10, 'PRESENTE'), (19, 1, 'PRESENTE'), (19, 2, 'FALTA'),
-- Agendamento 20 (08/08 15:00 - Sexta - Pilates)
(20, 10, 'PRESENTE'), (20, 1, 'PRESENTE'), (20, 2, 'PRESENTE'), (20, 3, 'FALTA'),
-- Agendamento 21 (11/08 09:00 - Segunda - RPG)
(21, 1, 'PRESENTE'), (21, 2, 'PRESENTE'), (21, 3, 'PRESENTE'), (21, 4, 'FALTA'),
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

-- Agendamentos de setembro do Guilherme (IDs 49-96) - PASSADOS
-- Padrão: alunos 1-10 rotativos, 3-4 alunos por agendamento
-- NOTA: Os relacionamentos seguem um padrão rotativo para evitar conflitos de horário
-- Cada agendamento tem 3-4 alunos, distribuídos de forma que não haja conflito no mesmo horário
INSERT INTO agendamento_aluno (agendamento_id, aluno_id, status_presenca) VALUES
-- Agendamento 49 (01/09 09:00 - Segunda - Pilates)
(49, 1, 'PRESENTE'), (49, 2, 'PRESENTE'), (49, 3, 'PRESENTE'), (49, 4, 'FALTA'),
-- Agendamento 23 (01/09 14:00 - Segunda - Fisioterapia)
(23, 15, 'PRESENTE'), (23, 16, 'PRESENTE'), (23, 17, 'FALTA'), (23, 18, 'PRESENTE'),
-- Agendamento 24 (02/09 08:00 - Terça - Pilates)
(24, 17, 'PRESENTE'), (24, 18, 'PRESENTE'), (24, 19, 'PRESENTE'), (24, 20, 'FALTA'), (24, 1, 'PRESENTE'),
-- Agendamento 25 (04/09 10:00 - Quinta - RPG)
(25, 19, 'PRESENTE'), (25, 20, 'PRESENTE'), (25, 1, 'FALTA'), (25, 2, 'PRESENTE'),
-- Agendamento 26 (05/09 14:00 - Sexta - Fisioterapia)
(26, 1, 'PRESENTE'), (26, 2, 'PRESENTE'), (26, 3, 'PRESENTE'), (26, 4, 'FALTA'),
-- Agendamento 27 (08/09 08:00 - Segunda - Pilates)
(27, 3, 'PRESENTE'), (27, 4, 'PRESENTE'), (27, 5, 'PRESENTE'), (27, 6, 'FALTA'), (27, 7, 'PRESENTE'),
-- Agendamento 28 (08/09 10:00 - Segunda - RPG)
(28, 5, 'PRESENTE'), (28, 6, 'PRESENTE'), (28, 7, 'PRESENTE'), (28, 8, 'FALTA'),
-- Agendamento 29 (09/09 08:00 - Terça - Pilates)
(29, 7, 'PRESENTE'), (29, 8, 'PRESENTE'), (29, 9, 'PRESENTE'), (29, 10, 'PRESENTE'), (29, 11, 'FALTA'),
-- Agendamento 30 (11/09 10:00 - Quinta - Fisioterapia)
(30, 9, 'PRESENTE'), (30, 10, 'PRESENTE'), (30, 11, 'FALTA'), (30, 12, 'PRESENTE'),
-- Agendamento 31 (12/09 09:00 - Sexta - RPG)
(31, 11, 'PRESENTE'), (31, 12, 'PRESENTE'), (31, 13, 'PRESENTE'), (31, 14, 'FALTA'),
-- Agendamento 32 (15/09 08:00 - Segunda - Pilates)
(32, 13, 'PRESENTE'), (32, 14, 'PRESENTE'), (32, 15, 'PRESENTE'), (32, 16, 'FALTA'), (32, 17, 'PRESENTE'),
-- Agendamento 33 (16/09 08:00 - Terça - Pilates)
(33, 15, 'PRESENTE'), (33, 16, 'PRESENTE'), (33, 17, 'PRESENTE'), (33, 18, 'FALTA'), (33, 19, 'PRESENTE'),
-- Agendamento 34 (18/09 14:00 - Quinta - Fisioterapia)
(34, 17, 'PRESENTE'), (34, 18, 'PRESENTE'), (34, 19, 'FALTA'), (34, 20, 'PRESENTE'),
-- Agendamento 35 (19/09 10:00 - Sexta - RPG)
(35, 18, 'PRESENTE'), (35, 19, 'PRESENTE'), (35, 20, 'FALTA'), (35, 1, 'PRESENTE'),
-- Agendamento 36 (22/09 08:00 - Segunda - Pilates)
(36, 19, 'PRESENTE'), (36, 20, 'PRESENTE'), (36, 1, 'PRESENTE'), (36, 2, 'FALTA'), (36, 3, 'PRESENTE'),
-- Agendamento 37 (22/09 10:00 - Segunda - RPG)
(37, 20, 'PRESENTE'), (37, 1, 'PRESENTE'), (37, 2, 'FALTA'), (37, 3, 'PRESENTE'),
-- Agendamento 38 (23/09 08:00 - Terça - Pilates)
(38, 1, 'PRESENTE'), (38, 2, 'PRESENTE'), (38, 3, 'PRESENTE'), (38, 4, 'FALTA'), (38, 5, 'PRESENTE'),
-- Agendamento 39 (25/09 10:00 - Quinta - Fisioterapia)
(39, 3, 'PRESENTE'), (39, 4, 'PRESENTE'), (39, 5, 'FALTA'), (39, 6, 'PRESENTE'),
-- Agendamento 40 (26/09 09:00 - Sexta - RPG)
(40, 5, 'PRESENTE'), (40, 6, 'PRESENTE'), (40, 7, 'PRESENTE'), (40, 8, 'FALTA');

-- Agendamentos de outubro (IDs 41-61) - PASSADOS
INSERT INTO agendamento_aluno (agendamento_id, aluno_id, status_presenca) VALUES
-- Agendamento 41 (01/10 08:00 - Quarta - Pilates)
(41, 6, 'PRESENTE'), (41, 7, 'PRESENTE'), (41, 8, 'PRESENTE'), (41, 9, 'FALTA'), (41, 10, 'PRESENTE'),
-- Agendamento 42 (02/10 10:00 - Quinta - RPG)
(42, 8, 'PRESENTE'), (42, 9, 'PRESENTE'), (42, 10, 'PRESENTE'), (42, 11, 'FALTA'),
-- Agendamento 43 (03/10 14:00 - Sexta - Fisioterapia)
(43, 9, 'PRESENTE'), (43, 10, 'PRESENTE'), (43, 11, 'FALTA'), (43, 12, 'PRESENTE'),
-- Agendamento 44 (06/10 08:00 - Segunda - Pilates)
(44, 11, 'PRESENTE'), (44, 12, 'PRESENTE'), (44, 13, 'PRESENTE'), (44, 14, 'FALTA'), (44, 15, 'PRESENTE'),
-- Agendamento 45 (06/10 10:00 - Segunda - RPG)
(45, 13, 'PRESENTE'), (45, 14, 'PRESENTE'), (45, 15, 'PRESENTE'), (45, 16, 'FALTA'),
-- Agendamento 46 (07/10 08:00 - Terça - Pilates)
(46, 14, 'PRESENTE'), (46, 15, 'PRESENTE'), (46, 16, 'PRESENTE'), (46, 17, 'FALTA'), (46, 18, 'PRESENTE'),
-- Agendamento 47 (09/10 10:00 - Quinta - Fisioterapia)
(47, 16, 'PRESENTE'), (47, 17, 'PRESENTE'), (47, 18, 'FALTA'), (47, 19, 'PRESENTE'),
-- Agendamento 48 (10/10 09:00 - Sexta - RPG)
(48, 17, 'PRESENTE'), (48, 18, 'PRESENTE'), (48, 19, 'PRESENTE'), (48, 20, 'FALTA'),
-- Agendamento 49 (13/10 08:00 - Segunda - Pilates)
(49, 18, 'PRESENTE'), (49, 19, 'PRESENTE'), (49, 20, 'FALTA'), (49, 1, 'PRESENTE'), (49, 2, 'PRESENTE'),
-- Agendamento 50 (13/10 14:00 - Segunda - Fisioterapia)
(50, 19, 'PRESENTE'), (50, 20, 'PRESENTE'), (50, 1, 'FALTA'), (50, 2, 'PRESENTE'),
-- Agendamento 51 (14/10 08:00 - Terça - Pilates)
(51, 20, 'PRESENTE'), (51, 1, 'PRESENTE'), (51, 2, 'PRESENTE'), (51, 3, 'FALTA'), (51, 4, 'PRESENTE'),
-- Agendamento 52 (16/10 14:00 - Quinta - Fisioterapia)
(52, 2, 'PRESENTE'), (52, 3, 'PRESENTE'), (52, 4, 'FALTA'), (52, 5, 'PRESENTE'),
-- Agendamento 53 (17/10 10:00 - Sexta - RPG)
(53, 3, 'PRESENTE'), (53, 4, 'PRESENTE'), (53, 5, 'PRESENTE'), (53, 6, 'FALTA'),
-- Agendamento 54 (20/10 08:00 - Segunda - Pilates)
(54, 4, 'PRESENTE'), (54, 5, 'PRESENTE'), (54, 6, 'PRESENTE'), (54, 7, 'FALTA'), (54, 8, 'PRESENTE'),
-- Agendamento 55 (21/10 08:00 - Terça - Pilates)
(55, 6, 'PRESENTE'), (55, 7, 'PRESENTE'), (55, 8, 'PRESENTE'), (55, 9, 'FALTA'), (55, 10, 'PRESENTE'),
-- Agendamento 56 (23/10 10:00 - Quinta - Fisioterapia)
(56, 8, 'PRESENTE'), (56, 9, 'PRESENTE'), (56, 10, 'PRESENTE'), (56, 11, 'FALTA'),
-- Agendamento 57 (24/10 09:00 - Sexta - RPG)
(57, 9, 'PRESENTE'), (57, 10, 'PRESENTE'), (57, 11, 'FALTA'), (57, 12, 'PRESENTE'),
-- Agendamento 58 (27/10 08:00 - Segunda - Pilates)
(58, 10, 'PRESENTE'), (58, 11, 'PRESENTE'), (58, 12, 'PRESENTE'), (58, 13, 'FALTA'), (58, 14, 'PRESENTE'),
-- Agendamento 59 (27/10 10:00 - Segunda - RPG)
(59, 12, 'PRESENTE'), (59, 13, 'PRESENTE'), (59, 14, 'PRESENTE'), (59, 15, 'FALTA'),
-- Agendamento 60 (28/10 08:00 - Terça - Pilates)
(60, 13, 'PRESENTE'), (60, 14, 'PRESENTE'), (60, 15, 'PRESENTE'), (60, 16, 'FALTA'), (60, 17, 'PRESENTE'),
-- Agendamento 61 (30/10 14:00 - Quinta - Fisioterapia)
(61, 15, 'PRESENTE'), (61, 16, 'PRESENTE'), (61, 17, 'FALTA'), (61, 18, 'PRESENTE');

-- Agendamentos de novembro (IDs 62-80)
-- Agendamentos até 14/11/2025 são PASSADOS, após são FUTUROS
INSERT INTO agendamento_aluno (agendamento_id, aluno_id, status_presenca) VALUES
-- Agendamento 62 (31/10 09:00 - Sexta - RPG) - PASSADO (ajustado de 01/11 sábado)
(62, 16, 'PRESENTE'), (62, 17, 'PRESENTE'), (62, 18, 'FALTA'), (62, 19, 'PRESENTE'),
-- Agendamento 63 (03/11 08:00 - Segunda - Pilates) - PASSADO
(63, 17, 'PRESENTE'), (63, 18, 'PRESENTE'), (63, 19, 'PRESENTE'), (63, 20, 'FALTA'), (63, 1, 'PRESENTE'),
-- Agendamento 64 (03/11 10:00 - Segunda - RPG) - PASSADO
(64, 18, 'PRESENTE'), (64, 19, 'PRESENTE'), (64, 20, 'FALTA'), (64, 1, 'PRESENTE'),
-- Agendamento 65 (04/11 08:00 - Terça - Pilates) - PASSADO
(65, 19, 'PRESENTE'), (65, 20, 'PRESENTE'), (65, 1, 'PRESENTE'), (65, 2, 'FALTA'), (65, 3, 'PRESENTE'),
-- Agendamento 66 (06/11 10:00 - Quinta - Fisioterapia) - PASSADO
(66, 20, 'PRESENTE'), (66, 1, 'FALTA'), (66, 2, 'PRESENTE'), (66, 3, 'PRESENTE'),
-- Agendamento 67 (07/11 09:00 - Sexta - RPG) - PASSADO (ajustado de 08/11 sábado)
(67, 1, 'PRESENTE'), (67, 2, 'PRESENTE'), (67, 3, 'FALTA'), (67, 4, 'PRESENTE'),
-- Agendamento 68 (10/11 08:00 - Segunda - Pilates) - PASSADO
(68, 2, 'PRESENTE'), (68, 3, 'PRESENTE'), (68, 4, 'PRESENTE'), (68, 5, 'FALTA'), (68, 6, 'PRESENTE'),
-- Agendamento 69 (10/11 14:00 - Segunda - Fisioterapia) - PASSADO
(69, 3, 'PRESENTE'), (69, 4, 'PRESENTE'), (69, 5, 'FALTA'), (69, 6, 'PRESENTE'),
-- Agendamento 70 (11/11 08:00 - Terça - Pilates) - PASSADO
(70, 4, 'PRESENTE'), (70, 5, 'PRESENTE'), (70, 6, 'PRESENTE'), (70, 7, 'FALTA'), (70, 8, 'PRESENTE'),
-- Agendamento 71 (13/11 14:00 - Quinta - Fisioterapia) - PASSADO
(71, 5, 'PRESENTE'), (71, 6, 'PRESENTE'), (71, 7, 'FALTA'), (71, 8, 'PRESENTE'),
-- Agendamento 72 (14/11 10:00 - Sexta - RPG) - PASSADO (último dia considerado passado, ajustado de 15/11 sábado)
(72, 6, 'PRESENTE'), (72, 7, 'PRESENTE'), (72, 8, 'PRESENTE'), (72, 9, 'FALTA'),
-- Agendamento 73 (17/11 08:00 - Segunda - Pilates) - FUTURO
(73, 7, 'PENDENTE'), (73, 8, 'PENDENTE'), (73, 9, 'PENDENTE'), (73, 10, 'PENDENTE'), (73, 11, 'PENDENTE'),
-- Agendamento 74 (18/11 08:00 - Terça - Pilates) - FUTURO
(74, 8, 'PENDENTE'), (74, 9, 'PENDENTE'), (74, 10, 'PENDENTE'), (74, 11, 'PENDENTE'), (74, 12, 'PENDENTE'),
-- Agendamento 75 (20/11 10:00 - Quinta - Fisioterapia) - FUTURO
(75, 9, 'PENDENTE'), (75, 10, 'PENDENTE'), (75, 11, 'PENDENTE'), (75, 12, 'PENDENTE'),
-- Agendamento 76 (21/11 09:00 - Sexta - RPG) - FUTURO (ajustado de 22/11 sábado)
(76, 10, 'PENDENTE'), (76, 11, 'PENDENTE'), (76, 12, 'PENDENTE'), (76, 13, 'PENDENTE'),
-- Agendamento 77 (24/11 08:00 - Segunda - Pilates) - FUTURO
(77, 11, 'PENDENTE'), (77, 12, 'PENDENTE'), (77, 13, 'PENDENTE'), (77, 14, 'PENDENTE'), (77, 15, 'PENDENTE'),
-- Agendamento 78 (24/11 10:00 - Segunda - RPG) - FUTURO
(78, 12, 'PENDENTE'), (78, 13, 'PENDENTE'), (78, 14, 'PENDENTE'), (78, 15, 'PENDENTE'),
-- Agendamento 79 (25/11 08:00 - Terça - Pilates) - FUTURO
(79, 13, 'PENDENTE'), (79, 14, 'PENDENTE'), (79, 15, 'PENDENTE'), (79, 16, 'PENDENTE'), (79, 17, 'PENDENTE'),
-- Agendamento 80 (27/11 14:00 - Quinta - Fisioterapia) - FUTURO
(80, 14, 'PENDENTE'), (80, 15, 'PENDENTE'), (80, 16, 'PENDENTE'), (80, 17, 'PENDENTE');

-- Agendamentos de dezembro (IDs 81-97) - FUTUROS
INSERT INTO agendamento_aluno (agendamento_id, aluno_id, status_presenca) VALUES
-- Agendamento 81 (01/12 08:00 - Segunda - Pilates)
(81, 15, 'PENDENTE'), (81, 16, 'PENDENTE'), (81, 17, 'PENDENTE'), (81, 18, 'PENDENTE'), (81, 19, 'PENDENTE'),
-- Agendamento 82 (01/12 10:00 - Segunda - RPG)
(82, 16, 'PENDENTE'), (82, 17, 'PENDENTE'), (82, 18, 'PENDENTE'), (82, 19, 'PENDENTE'),
-- Agendamento 83 (02/12 08:00 - Terça - Pilates)
(83, 17, 'PENDENTE'), (83, 18, 'PENDENTE'), (83, 19, 'PENDENTE'), (83, 20, 'PENDENTE'), (83, 1, 'PENDENTE'),
-- Agendamento 84 (04/12 10:00 - Quinta - RPG)
(84, 18, 'PENDENTE'), (84, 19, 'PENDENTE'), (84, 20, 'PENDENTE'), (84, 1, 'PENDENTE'),
-- Agendamento 85 (05/12 14:00 - Sexta - Fisioterapia) (ajustado de 06/12 sábado)
(85, 19, 'PENDENTE'), (85, 20, 'PENDENTE'), (85, 1, 'PENDENTE'), (85, 2, 'PENDENTE'),
-- Agendamento 86 (08/12 08:00 - Segunda - Pilates)
(86, 20, 'PENDENTE'), (86, 1, 'PENDENTE'), (86, 2, 'PENDENTE'), (86, 3, 'PENDENTE'), (86, 4, 'PENDENTE'),
-- Agendamento 87 (08/12 14:00 - Segunda - Fisioterapia)
(87, 1, 'PENDENTE'), (87, 2, 'PENDENTE'), (87, 3, 'PENDENTE'), (87, 4, 'PENDENTE'),
-- Agendamento 88 (09/12 08:00 - Terça - Pilates)
(88, 2, 'PENDENTE'), (88, 3, 'PENDENTE'), (88, 4, 'PENDENTE'), (88, 5, 'PENDENTE'), (88, 6, 'PENDENTE'),
-- Agendamento 89 (11/12 10:00 - Quinta - Fisioterapia)
(89, 3, 'PENDENTE'), (89, 4, 'PENDENTE'), (89, 5, 'PENDENTE'), (89, 6, 'PENDENTE'),
-- Agendamento 90 (12/12 09:00 - Sexta - RPG) (ajustado de 13/12 sábado)
(90, 4, 'PENDENTE'), (90, 5, 'PENDENTE'), (90, 6, 'PENDENTE'), (90, 7, 'PENDENTE'),
-- Agendamento 91 (15/12 08:00 - Segunda - Pilates)
(91, 5, 'PENDENTE'), (91, 6, 'PENDENTE'), (91, 7, 'PENDENTE'), (91, 8, 'PENDENTE'), (91, 9, 'PENDENTE'),
-- Agendamento 92 (15/12 10:00 - Segunda - RPG)
(92, 6, 'PENDENTE'), (92, 7, 'PENDENTE'), (92, 8, 'PENDENTE'), (92, 9, 'PENDENTE'),
-- Agendamento 93 (16/12 08:00 - Terça - Pilates)
(93, 7, 'PENDENTE'), (93, 8, 'PENDENTE'), (93, 9, 'PENDENTE'), (93, 10, 'PENDENTE'), (93, 11, 'PENDENTE'),
-- Agendamento 94 (18/12 14:00 - Quinta - Fisioterapia)
(94, 8, 'PENDENTE'), (94, 9, 'PENDENTE'), (94, 10, 'PENDENTE'), (94, 11, 'PENDENTE'),
-- Agendamento 95 (19/12 10:00 - Sexta - RPG) (ajustado de 20/12 sábado)
(95, 9, 'PENDENTE'), (95, 10, 'PENDENTE'), (95, 11, 'PENDENTE'), (95, 12, 'PENDENTE'),
-- Agendamento 96 (22/12 08:00 - Segunda - Pilates)
(96, 10, 'PENDENTE'), (96, 11, 'PENDENTE'), (96, 12, 'PENDENTE'), (96, 13, 'PENDENTE'), (96, 14, 'PENDENTE'),
-- Agendamento 97 (22/12 14:00 - Segunda - Fisioterapia)
(97, 11, 'PENDENTE'), (97, 12, 'PENDENTE'), (97, 13, 'PENDENTE'), (97, 14, 'PENDENTE');

-- ============================================
-- VERIFICAÇÕES - TODOS OS SELECTs
-- ============================================

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

