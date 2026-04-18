# 🔐 Configuração de Propriedades

## ⚠️ Arquivos Ignorados pelo Git

Os seguintes arquivos contêm informações sensíveis e **NÃO** são commitados no Git:

- `src/main/resources/application.properties`
- `src/test/resources/application-test.properties`

## 📋 Como Configurar

### 0. Usar arquivo `.env`

Se existir um arquivo `.env` na raiz do projeto, a aplicação o carrega automaticamente na inicialização. Os nomes das variáveis devem bater com os placeholders usados em `src/main/resources/application.properties`, por exemplo `DB_HOST`, `JWT_SECRET` e `RABBITMQ_HOST`.

### 1. Copiar o arquivo de exemplo

```bash
# Para desenvolvimento
cp src/main/resources/application.properties.example src/main/resources/application.properties

# Para testes
cp src/test/resources/application-test.properties.example src/test/resources/application-test.properties
```

### 2. Editar os valores

Abra o arquivo `application.properties` e substitua os valores de exemplo pelos valores reais:

- **Banco de Dados:**
  - `spring.datasource.username`: Seu usuário do MySQL
  - `spring.datasource.password`: Sua senha do MySQL
  - `spring.datasource.url`: URL do banco (se diferente)

- **JWT:**
  - `app.jwt.secret`: Gere uma chave secreta segura (pode usar um gerador online ou: `openssl rand -base64 32`)

- **Email:**
  - `spring.mail.username`: Seu email
  - `spring.mail.password`: Senha de app do Gmail (ou senha normal se não usar 2FA)

## 🔑 Gerar Chave Secreta JWT

### Linux/Mac:
```bash
openssl rand -base64 32
```

### Windows (PowerShell):
```powershell
[Convert]::ToBase64String((1..32 | ForEach-Object { Get-Random -Minimum 0 -Maximum 256 }))
```

### Online:
Use um gerador de chaves aleatórias online (ex: https://randomkeygen.com/)

## 📝 Notas Importantes

- ⚠️ **NUNCA** commite o arquivo `application.properties` com dados reais
- ✅ Use sempre o arquivo `.example` como referência
- 🔒 Mantenha suas credenciais seguras e não compartilhe
- 📦 Cada desenvolvedor deve criar seu próprio `application.properties` local

## 🚀 Primeira Configuração

1. Clone o repositório
2. Copie `application.properties.example` para `application.properties`
3. Preencha com suas credenciais locais
4. Execute a aplicação

