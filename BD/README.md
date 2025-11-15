# Scripts de Banco de Dados - One Pilates

## Estrutura

- `dados_iniciais.sql` - Script para inserir dados iniciais no banco de dados

## Como Usar

### 1. Criar o Banco de Dados

O banco de dados será criado automaticamente pelas classes Java quando você iniciar a aplicação Spring Boot.

**Configuração no `application.properties`:**
```properties
spring.jpa.hibernate.ddl-auto=create
```

**OU se já existe o banco:**
```properties
spring.jpa.hibernate.ddl-auto=update
```

### 2. Executar o Script de Dados Iniciais

Após o banco ser criado, execute o script SQL:

```bash
mysql -u root -p onePilates < dados_iniciais.sql
```

**OU no MySQL Workbench/HeidiSQL:**
1. Abra o arquivo `dados_iniciais.sql`
2. Execute o script completo

### 3. Verificar Dados Inseridos

```sql
-- Verificar funcionários
SELECT id, nome, email, role FROM funcionario;

-- Verificar alunos
SELECT id, nome, email FROM aluno;

-- Verificar especialidades
SELECT * FROM especialidade;

-- Verificar salas
SELECT * FROM sala;
```

## Dados Inseridos

### Usuários do Sistema

1. **Administrador**
   - Email: `admin@onepilates.com`
   - Senha: `12345678`
   - CPF: `00000000000`

2. **Professor 1 - Andrei Scafi**
   - Email: `andreiscafi@gmail.com`
   - Senha: `12345678`
   - CPF: `11122233300`
   - Especialidades: Pilates Clássico, Pilates Funcional, Pilates Terapêutico

3. **Professor 2 - Guilherme Queiroz**
   - Email: `guilherme@email.com`
   - Senha: `12345678`
   - CPF: `22233344400`
   - Especialidades: Pilates Aéreo, Pilates para Gestantes

4. **Secretária - Amanda**
   - Email: `amanda@email.com`
   - Senha: `12345678`
   - CPF: `33344455500`

### Alunos

20 alunos são inseridos com:
- Nomes variados (Ana Silva, Bruno Santos, etc.)
- Emails únicos
- CPFs únicos (11111111111 a 21212121212)
- Alguns com limitações físicas (marcados para uso de equipamentos PCD)

### Especialidades

- Pilates Clássico
- Pilates Aéreo
- Pilates Funcional
- Pilates Terapêutico
- Pilates para Gestantes

### Salas

- Sala 1 - Mat Pilates (10 alunos, 2 equipamentos PCD)
- Sala 2 - Equipamentos (8 alunos, 3 equipamentos PCD)
- Sala 3 - Aéreo (6 alunos, 1 equipamento PCD)
- Sala 4 - Terapêutica (5 alunos, 2 equipamentos PCD)

## Notas Importantes

1. **Senha Padrão:** Todos os usuários têm a senha `12345678`
   - A senha é armazenada como hash BCrypt no banco
   - Hash usado: `$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy`

2. **CPFs:** Todos os CPFs são únicos e válidos para teste

3. **Status:** Todos os usuários estão ativos (`status = TRUE`)

4. **Relacionamentos:**
   - Professores estão relacionados com especialidades
   - Salas estão relacionadas com especialidades
   - Todos têm endereços cadastrados

## Gerar Novo Hash BCrypt (se necessário)

Se precisar gerar um novo hash BCrypt para uma senha diferente, você pode:

1. **Usar a aplicação Spring Boot:**
   - A classe `SenhaTemp` já gera hashes
   - Execute a aplicação e verifique o console

2. **Usar um gerador online:**
   - https://bcrypt-generator.com/
   - Use rounds: 10

3. **Usar código Java:**
   ```java
   BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
   String hash = encoder.encode("12345678");
   System.out.println(hash);
   ```

## Troubleshooting

### Erro: "Duplicate entry for key 'PRIMARY'"
- O banco já tem dados. Use `DROP DATABASE onePilates; CREATE DATABASE onePilates;` antes de executar o script.

### Erro: "Unknown column"
- O banco não foi criado corretamente. Verifique se `ddl-auto=create` está configurado.

### Erro: "Foreign key constraint fails"
- Execute os INSERTs na ordem correta (endereços primeiro, depois funcionários/alunos).

## Estrutura de Tabelas

O banco é criado automaticamente com as seguintes tabelas principais:
- `funcionario` (tabela base)
- `administrador` (herda de funcionario)
- `professor` (herda de funcionario)
- `secretaria` (herda de funcionario)
- `aluno`
- `especialidade`
- `sala`
- `agendamento`
- `agendamento_aluno`
- `endereco`
- `professor_especialidade` (tabela de relacionamento)
- `sala_especialidade` (tabela de relacionamento)

