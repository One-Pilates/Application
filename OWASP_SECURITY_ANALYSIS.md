# Analise de Seguranca - OWASP Top 10
**Projeto:** OnePilates Backend  
**Data:** 25/03/2026  
**Base analisada:** `agendamento/src/main/java/com/onePilates/agendamento/`

---

## Resumo Executivo

Foram identificadas vulnerabilidades reais e de alta severidade nas 6 categorias do OWASP Top 10 analisadas. As mais criticas sao: **bypass de troca de senha sem autenticacao previa**, **path traversal no servico de imagens**, **credenciais reais no repositorio** e **ausencia de rate limiting no login**. Todas as correcoes descritas sao necessarias antes de qualquer deploy em producao.

---

## A01:2021 - Broken Access Control

### Vulnerabilidade 1 — IDOR: Qualquer professor acessa dados de outro professor

**Severidade:** Alta  
**Arquivo:** `controller/ProfessorController.java` (linhas 47-53 e 62-77)

Os endpoints `PATCH /api/professores/{id}` e `GET /api/professores/{id}/{qtdUltimosDias}` permitem que qualquer usuario com role `PROFESSOR` altere o perfil ou visualize o dashboard de **qualquer outro professor**, simplesmente informando um ID diferente do seu. Nao existe verificacao de que o `{id}` da requisicao pertence ao usuario autenticado.

```java
// Situacao atual - sem verificacao de ownership
@PatchMapping("/{id}")
@PreAuthorize("hasAnyAuthority('ADMINISTRADOR', 'SECRETARIA', 'PROFESSOR')")
public ResponseEntity<ProfessorResponseDTO> atualizarProfessorParcial(
        @PathVariable Long id, @RequestBody ProfessorDTO dto) {
    return ResponseEntity.ok(professorService.atualizarProfessor(id, dto));
}
```

**Correcao necessaria:** Ao receber a requisicao, extrair o email do JWT (via `SecurityContextHolder`), buscar o `Funcionario` correspondente e verificar se o `id` da requisicao bate com o `id` do usuario autenticado — a menos que a role seja `ADMINISTRADOR` ou `SECRETARIA`.

```java
// Exemplo de correcao
@PatchMapping("/{id}")
@PreAuthorize("hasAnyAuthority('ADMINISTRADOR', 'SECRETARIA', 'PROFESSOR')")
public ResponseEntity<ProfessorResponseDTO> atualizarProfessorParcial(
        @PathVariable Long id, @RequestBody ProfessorDTO dto,
        Authentication authentication) {

    String emailAutenticado = (String) authentication.getPrincipal();
    boolean isAdmin = authentication.getAuthorities().stream()
            .anyMatch(a -> a.getAuthority().equals("ADMINISTRADOR")
                       || a.getAuthority().equals("SECRETARIA"));

    if (!isAdmin) {
        Professor professorAutenticado = professorRepository
                .findByEmail(emailAutenticado)
                .orElseThrow(() -> new AccessDeniedException("Acesso negado"));
        if (!professorAutenticado.getId().equals(id)) {
            throw new AccessDeniedException("Voce so pode editar seu proprio perfil");
        }
    }
    return ResponseEntity.ok(professorService.atualizarProfessor(id, dto));
}
```

---

### Vulnerabilidade 2 — Endpoint de imagens sem autenticacao

**Severidade:** Media  
**Arquivo:** `config/SecurityConfig.java` (linha 83) e `controller/ImagemController.java`

O endpoint `/api/imagens/**` esta liberado para acesso publico sem qualquer autenticacao. Qualquer pessoa na internet pode acessar fotos de perfil dos funcionarios.

```java
// SecurityConfig.java - linha 83
.requestMatchers("/api/imagens/**").permitAll() // qualquer um acessa
```

**Correcao necessaria:** Remover o `permitAll()` e exigir autenticacao, ou mover imagens publicas para um subpath especifico (ex: `/api/imagens/publicas/**`).

---

### Vulnerabilidade 3 — @CrossOrigin redundante e inconsistente

**Severidade:** Baixa  
**Arquivos:** `AuthController.java`, `AgendamentoController.java`, `ProfessorController.java` e outros

Varios controllers possuem `@CrossOrigin(origins = "*")` em nivel de classe, tornando a configuracao global de CORS em `SecurityConfig` redundante e criando inconsistencias (alguns controllers sem a anotacao se comportam diferente).

**Correcao necessaria:** Remover todas as anotacoes `@CrossOrigin` dos controllers e centralizar a configuracao exclusivamente em `SecurityConfig.corsConfigurationSource()`. Em producao, substituir `"*"` pelas origens reais do frontend.

---

## A02:2021 - Cryptographic Failures

### Vulnerabilidade 4 — Credenciais reais no repositorio Git

**Severidade:** Critica  
**Arquivo:** `src/main/resources/application.properties`

O arquivo `application.properties` contendo credenciais reais esta presente no repositorio. Estao expostos:

- Senha do banco de dados MySQL
- Secret JWT (`app.jwt.secret`)
- Senha de aplicativo do Gmail (usada para envio de e-mails)

**Correcao necessaria:**

1. Adicionar `application.properties` ao `.gitignore` imediatamente.
2. Revogar e regenerar todas as credenciais expostas (senha do banco, chave JWT, senha de app do Gmail).
3. Utilizar variaveis de ambiente ou um vault (ex: AWS Secrets Manager, HashiCorp Vault) para injecao de segredos em producao.
4. Manter somente `application.properties.example` com valores ficticiois no repositorio.

```
# .gitignore - adicionar
agendamento/src/main/resources/application.properties
```

---

### Vulnerabilidade 5 — Conexao com banco de dados sem SSL

**Severidade:** Alta  
**Arquivo:** `src/main/resources/application.properties` (linha 2)

```properties
spring.datasource.url=jdbc:mysql://localhost:3306/onePilates?useSSL=false&...
```

`useSSL=false` desabilita explicitamente a criptografia TLS na conexao com o banco. Em ambientes de producao onde a aplicacao e o banco estao em hosts diferentes, dados sensiveis trafegam em texto claro.

**Correcao necessaria:** Remover `useSSL=false` e configurar os certificados SSL do MySQL. Em ambientes de desenvolvimento local, manter somente no profile `dev`.

---

### Vulnerabilidade 6 — CPF armazenado em texto claro

**Severidade:** Media  
**Arquivo:** `model/Funcionario.java` (linha 29)

```java
@Column(unique = true)
private String cpf;
```

O CPF e um dado pessoal sensivel (PII) e e armazenado sem qualquer protecao. Um vazamento do banco expoe diretamente os CPFs de todos os funcionarios e alunos.

**Correcao necessaria:** Armazenar o CPF hasheado (ex: SHA-256 com salt) para buscas de unicidade. Se for necessario recuperar o valor original, utilizar criptografia simetrica (ex: AES-256) com chave gerenciada fora do banco.

---

### Vulnerabilidade 7 — Token JWT sem mecanismo de revogacao

**Severidade:** Media  
**Arquivo:** `security/JwtUtil.java` e `security/JwtAuthFilter.java`

O token JWT expira em 24 horas (`app.jwt.expiration-ms=86400000`) e nao existe nenhum mecanismo de revogacao. Se um token for comprometido, ou se um usuario trocar a senha, o token antigo continua valido ate expirar naturalmente.

**Correcao necessaria:** Implementar uma blocklist de tokens revogados (Redis ou tabela no banco) e invalidar o token corrente sempre que o usuario alterar a senha. Reduzir o tempo de expiracao para valores menores (ex: 1 hora), combinado com refresh tokens.

---

## A03:2021 - Injection

### Vulnerabilidade 8 — Path Traversal no endpoint de imagens

**Severidade:** Alta  
**Arquivo:** `controller/ImagemController.java` (linhas 27-41)

O caminho do arquivo e extraido diretamente da URI da requisicao e utilizado para construir o path do arquivo em disco, **sem verificar se o caminho resultante esta dentro do diretorio de upload**:

```java
// ImagemController.java - sem verificacao de canonical path
String requestPath = request.getRequestURI();
String caminhoRelativo = requestPath.substring("/api/imagens/".length());
// ...
Path filePath = Paths.get(uploadDirectory, caminhoRelativo).normalize();
File file = filePath.toFile();

if (!file.exists() || !file.isFile()) {
    return ResponseEntity.notFound().build();
}
// LEITURA DIRETA SEM VERIFICAR SE file ESTA DENTRO DE uploadDirectory
Resource resource = new FileSystemResource(file);
```

Um atacante pode requisitar `/api/imagens/../../application.properties` e potencialmente ler arquivos arbitrarios do servidor.

Comparacao: o metodo `removerImagem()` em `ImageService.java` **ja implementa corretamente** a verificacao de canonical path (linhas 140-146). A mesma logica esta ausente no controller de leitura.

**Correcao necessaria:** Adicionar verificacao de canonical path antes de servir o arquivo:

```java
// Adicionar apos construir o filePath
String arquivoCanonical = filePath.toFile().getCanonicalPath();
String uploadCanonical = new File(uploadDirectory).getCanonicalPath();

if (!arquivoCanonical.startsWith(uploadCanonical + File.separator)) {
    return ResponseEntity.status(HttpStatus.FORBIDDEN).build();
}
```

---

### Vulnerabilidade 9 — Validacao de tipo de arquivo baseada apenas no Content-Type

**Severidade:** Media  
**Arquivo:** `service/ImageService.java` (linhas 167-176)

```java
private void validarArquivo(MultipartFile file) {
    // ...
    String contentType = file.getContentType(); // header controlado pelo cliente!
    if (contentType == null || !ALLOWED_CONTENT_TYPES.contains(contentType.toLowerCase())) {
        throw new BusinessException("Tipo de arquivo nao permitido...");
    }
}
```

O `Content-Type` e um header HTTP enviado pelo cliente e pode ser facilmente forjado. Um atacante pode enviar um arquivo `.jsp` ou `.html` com `Content-Type: image/jpeg` e ele sera aceito e salvo no servidor.

**Correcao necessaria:** Validar o tipo do arquivo inspecionando os primeiros bytes (magic bytes) do conteudo, utilizando bibliotecas como Apache Tika:

```java
// Dependencia: org.apache.tika:tika-core
Tika tika = new Tika();
String detectedType = tika.detect(file.getBytes());
if (!ALLOWED_CONTENT_TYPES.contains(detectedType)) {
    throw new BusinessException("Tipo de arquivo nao permitido.");
}
```

---

## A05:2021 - Security Misconfiguration

### Vulnerabilidade 10 — Swagger UI exposto publicamente

**Severidade:** Alta  
**Arquivo:** `config/SecurityConfig.java` (linha 81)

```java
.requestMatchers("/swagger-ui/**", "/v3/api-docs/**", "/swagger-ui.html").permitAll()
```

A documentacao completa da API (todos os endpoints, parametros, modelos de dados) esta acessivel sem autenticacao. Isso funciona como um mapa detalhado da aplicacao para um atacante.

**Correcao necessaria:** Em producao, desabilitar o Swagger completamente via profile Spring, ou restringir o acesso somente a redes internas/VPN:

```properties
# application-prod.properties
springdoc.api-docs.enabled=false
springdoc.swagger-ui.enabled=false
```

Ou proteger com autenticacao:

```java
// Remover o permitAll para swagger e exigir role ADMINISTRADOR
.requestMatchers("/swagger-ui/**", "/v3/api-docs/**").hasRole("ADMINISTRADOR")
```

---

### Vulnerabilidade 11 — Configuracoes de desenvolvimento ativas em producao

**Severidade:** Media  
**Arquivo:** `src/main/resources/application.properties`

```properties
spring.jpa.show-sql=true         # expoe todas as queries SQL nos logs
spring.jpa.hibernate.ddl-auto=update  # modifica o schema automaticamente
```

`show-sql=true` expoe dados sensiveis das queries nos logs. `ddl-auto=update` pode destruir ou corromper dados ao fazer deploy de uma versao com mudancas no modelo.

**Correcao necessaria:** Utilizar profiles Spring (`application-dev.properties` / `application-prod.properties`) e garantir que em producao:

```properties
# application-prod.properties
spring.jpa.show-sql=false
spring.jpa.hibernate.ddl-auto=validate
```

---

### Vulnerabilidade 12 — SenhaTemp imprime hash no startup

**Severidade:** Baixa  
**Arquivo:** `AgendamentoApplication.java` (linhas 16-17) e `security/SenhaTemp.java` (linha 14)

```java
// AgendamentoApplication.java - chamado a cada inicializacao
SenhaTemp senhaTemp = context.getBean(SenhaTemp.class);
senhaTemp.criarSenhaCodificada(); // imprime hash de senha hardcoded no System.out
```

A cada inicializacao da aplicacao, um hash BCrypt de uma senha hardcoded (`"12345678"`) e impresso no console/logs. Isso e um residuo de desenvolvimento que nao deve existir em producao.

**Correcao necessaria:** Remover completamente a classe `SenhaTemp` e as chamadas em `AgendamentoApplication.main()`. Se necessario para testes, usar um teste unitario isolado.

---

## A07:2021 - Identification and Authentication Failures

### Vulnerabilidade 13 — Bypass no fluxo de recuperacao de senha (CRITICA)

**Severidade:** Critica  
**Arquivo:** `controller/AuthController.java` (linhas 41-44) e `service/AuthService.java` (linhas 206-230)

O endpoint `POST /auth/alterarSenha` aceita somente `email` + `novaSenha`, **sem exigir o codigo de verificacao previamente validado**. O fluxo correto seria:

1. `POST /auth/criarCodigoVerificacao` — gera e envia o codigo
2. `POST /auth/validarCodigo` — valida o codigo
3. `POST /auth/alterarSenha` — troca a senha

Porem, qualquer pessoa pode chamar diretamente o passo 3 com apenas o email da vitima, pulando os passos 1 e 2 por completo:

```java
// AuthController.java - sem verificacao de que o codigo foi validado
@PostMapping("/alterarSenha")
public ResponseEntity<NovaSenhaResponseDTO> trocarSenha(@Valid @RequestBody NovaSenhaDTO dto) {
    return ResponseEntity.ok(authService.novaSenha(dto.getSenha(), dto.getEmail()));
}
```

**Correcao necessaria:** Implementar um token de sessao temporario gerado apos a validacao bem-sucedida do codigo, e exigir esse token no endpoint de troca de senha:

```java
// AuthService.validarCodigoVerificacao - apos validar, gerar token temporario
String tokenTrocaSenha = UUID.randomUUID().toString();
funcionario.setTokenTrocaSenha(tokenTrocaSenha);
funcionario.setTokenTrocaSenhaExpiracao(LocalDateTime.now().plusMinutes(15));
funcionarioRepository.save(funcionario);
return tokenTrocaSenha; // retornar ao cliente

// AuthService.novaSenha - validar o token antes de trocar a senha
public NovaSenhaResponseDTO novaSenha(String senha, String email, String tokenTrocaSenha) {
    Funcionario funcionario = buscarFuncionarioPorEmail(email);
    if (!tokenTrocaSenha.equals(funcionario.getTokenTrocaSenha())
            || LocalDateTime.now().isAfter(funcionario.getTokenTrocaSenhaExpiracao())) {
        throw new OperacaoInvalidaException("Token de troca de senha invalido ou expirado");
    }
    // prosseguir com a troca
}
```

---

### Vulnerabilidade 14 — Codigo de verificacao com PRNG nao seguro e sem rate limiting

**Severidade:** Alta  
**Arquivo:** `service/AuthService.java` (linha 154)

```java
// Random() nao e criptograficamente seguro
String codigoVerificacao = String.format("%05d", new Random().nextInt(100000));
```

Dois problemas combinados:
1. `java.util.Random` e um gerador pseudoaleatorio previsivel. Use `java.security.SecureRandom`.
2. O codigo tem apenas 5 digitos (100.000 combinacoes). Sem rate limiting, um atacante consegue testar todos em segundos.

**Correcao necessaria:**

```java
// Trocar para SecureRandom
SecureRandom secureRandom = new SecureRandom();
String codigoVerificacao = String.format("%06d", secureRandom.nextInt(1000000)); // 6 digitos

// Adicionar rate limiting (ex: com Spring's Bucket4j ou Resilience4j)
// Limitar a 5 tentativas por email a cada 15 minutos
```

---

### Vulnerabilidade 15 — Ausencia de validacao de complexidade de senha

**Severidade:** Media  
**Arquivo:** `dto/loginPages/NovaSenhaDTO.java`

```java
public class NovaSenhaDTO {
    private String senha; // sem nenhuma restricao de tamanho ou complexidade
    private String email;
}
```

O campo `senha` nao possui nenhuma anotacao de validacao (`@NotBlank`, `@Size`, `@Pattern`). Um usuario pode definir uma senha vazia ou com um unico caractere.

**Correcao necessaria:**

```java
public class NovaSenhaDTO {
    @NotBlank(message = "Senha obrigatoria")
    @Size(min = 8, max = 128, message = "Senha deve ter entre 8 e 128 caracteres")
    @Pattern(
        regexp = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@#$%^&+=!]).+$",
        message = "Senha deve conter maiuscula, minuscula, numero e caractere especial"
    )
    private String senha;
    
    @NotBlank @Email
    private String email;
}
```

O mesmo se aplica a `LoginDTO.java` — que tambem nao possui validacoes de entrada.

---

### Vulnerabilidade 16 — Ausencia de rate limiting no login

**Severidade:** Alta  
**Arquivo:** `controller/AuthController.java` (linhas 25-29)

O endpoint `POST /auth/login` nao possui nenhuma protecao contra ataques de forca bruta. Um atacante pode tentar infinitas combinacoes de senha sem ser bloqueado.

**Correcao necessaria:** Adicionar rate limiting por IP e/ou por email usando Bucket4j ou Spring's `@RateLimiter` do Resilience4j:

```xml
<!-- pom.xml -->
<dependency>
    <groupId>com.github.vladimir-bukhtoyarov</groupId>
    <artifactId>bucket4j-core</artifactId>
    <version>8.x.x</version>
</dependency>
```

Ou implementar bloqueio progressivo: apos 5 tentativas falhas, bloquear o email por 15 minutos.

---

## A09:2021 - Security Logging and Monitoring Failures

### Vulnerabilidade 17 — JwtAuthFilter silencia erros de token invalido

**Severidade:** Media  
**Arquivo:** `security/JwtAuthFilter.java` (linhas 67-69)

```java
} catch (JwtException ex) {
    // token invalido -> deixa sem autenticacao
    // SEM NENHUM LOG - tentativas de token forjado passam despercebidas
}
```

Tentativas de uso de tokens JWT invalidos, expirados ou forjados sao completamente silenciadas. Um atacante pode tentar milhares de tokens sem deixar rastro algum.

**Correcao necessaria:**

```java
} catch (JwtException ex) {
    logger.warn("Token JWT invalido recebido de IP {}: {}",
        request.getRemoteAddr(), ex.getMessage());
}
```

---

### Vulnerabilidade 18 — GlobalExceptionHandler nao loga RuntimeException

**Severidade:** Baixa  
**Arquivo:** `handler/GlobalExceptionHandler.java` (linhas 58-62)

```java
@ExceptionHandler(RuntimeException.class)
public ResponseEntity<String> handleRuntime(RuntimeException ex) {
    String msg = ex.getMessage() == null ? "Erro" : ex.getMessage();
    return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(msg);
    // exception nao e logada - erros inesperados passam despercebidos
}
```

**Correcao necessaria:**

```java
@ExceptionHandler(RuntimeException.class)
public ResponseEntity<String> handleRuntime(RuntimeException ex) {
    logger.error("RuntimeException nao tratada: {}", ex.getMessage(), ex);
    String msg = ex.getMessage() == null ? "Erro interno" : ex.getMessage();
    return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(msg);
}
```

---

### Vulnerabilidade 19 — Ausencia de audit log para operacoes criticas

**Severidade:** Media  
**Arquivos:** `service/AuthService.java`, `service/AdministradorService.java`, `service/ProfessorService.java`

As seguintes operacoes criticas de seguranca nao possuem registro de auditoria (quem fez, quando, de qual IP):

- Criacao e exclusao de usuarios
- Alteracao de senha
- Alteracao de role/permissoes
- Login bem-sucedido e falho (parcialmente implementado em `AuthService`, mas sem IP)

**Correcao necessaria:** Criar uma entidade `AuditLog` e registrar as operacoes criticas com: `usuarioEmail`, `acao`, `entidadeAfetada`, `dataHora`, `ip`.

```java
// Exemplo de registro de auditoria no AuthService
logger.info("AUDIT | acao=ALTERAR_SENHA | email={} | ip={} | timestamp={}",
    email, ipDoRequest, LocalDateTime.now());
```

Para obter o IP, injetar `HttpServletRequest` nos services ou usar um interceptor dedicado.

---

## Tabela de Prioridades

| # | Vulnerabilidade | OWASP | Severidade | Acao |
|---|----------------|-------|------------|------|
| 13 | Bypass de troca de senha sem validacao de codigo | A07 | **Critica** | Corrigir imediatamente |
| 4 | Credenciais reais no repositorio Git | A02 | **Critica** | Corrigir imediatamente |
| 8 | Path Traversal no endpoint de imagens | A03 | **Alta** | Corrigir antes do proximo deploy |
| 16 | Sem rate limiting no login | A07 | **Alta** | Corrigir antes do proximo deploy |
| 14 | PRNG nao seguro + codigo de 5 digitos sem rate limit | A07 | **Alta** | Corrigir antes do proximo deploy |
| 10 | Swagger exposto publicamente | A05 | **Alta** | Corrigir antes do proximo deploy |
| 5 | Conexao MySQL sem SSL (`useSSL=false`) | A02 | **Alta** | Corrigir em producao |
| 1 | IDOR: professor acessa dados de outro professor | A01 | **Alta** | Corrigir antes do proximo deploy |
| 7 | JWT sem mecanismo de revogacao | A02 | **Media** | Planejar para proxima sprint |
| 2 | Endpoint de imagens sem autenticacao | A01 | **Media** | Avaliar necessidade de negocio |
| 17 | JwtAuthFilter silencia tokens invalidos | A09 | **Media** | Corrigir junto com logging |
| 6 | CPF em texto claro | A02 | **Media** | Planejar para proxima sprint |
| 19 | Ausencia de audit log | A09 | **Media** | Planejar para proxima sprint |
| 15 | Sem validacao de complexidade de senha | A07 | **Media** | Facil de implementar |
| 9 | Validacao de tipo de arquivo por Content-Type | A03 | **Media** | Corrigir junto com upload |
| 11 | `show-sql=true` e `ddl-auto=update` em producao | A05 | **Media** | Corrigir com profiles |
| 18 | RuntimeException nao logada | A09 | **Baixa** | Corrigir junto com logging |
| 12 | SenhaTemp imprime hash no startup | A05 | **Baixa** | Remover a classe |
| 3 | @CrossOrigin redundante nos controllers | A01 | **Baixa** | Refatoracao simples |
