# Como Gerar Hash BCrypt para Senhas

## Hash BCrypt para senha "12345678"

O hash usado no script `dados_iniciais.sql` é:
```
$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy
```

## Se o hash não funcionar, gere um novo:

### Opção 1: Usar a Aplicação Spring Boot

A classe `SenhaTemp` já gera hashes. Execute a aplicação e verifique o console:

```java
// A classe SenhaTemp.java já faz isso:
String senhaCodificada = passwordEncoder.encode("12345678");
System.out.println("Senha Codificada: " + senhaCodificada);
```

### Opção 2: Criar um Script Java Temporário

Crie um arquivo `GerarHash.java`:

```java
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

public class GerarHash {
    public static void main(String[] args) {
        BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
        String hash = encoder.encode("12345678");
        System.out.println("Hash BCrypt para '12345678':");
        System.out.println(hash);
    }
}
```

Compile e execute:
```bash
javac -cp "caminho/para/spring-security-crypto.jar" GerarHash.java
java -cp ".:caminho/para/spring-security-crypto.jar" GerarHash
```

### Opção 3: Usar Gerador Online

1. Acesse: https://bcrypt-generator.com/
2. Digite a senha: `12345678`
3. Rounds: `10`
4. Copie o hash gerado
5. Substitua no script SQL

### Opção 4: Usar Python

```python
import bcrypt

password = "12345678"
hashed = bcrypt.hashpw(password.encode('utf-8'), bcrypt.gensalt(rounds=10))
print(hashed.decode('utf-8'))
```

## Atualizar o Script SQL

Após gerar o hash, substitua no arquivo `dados_iniciais.sql`:

```sql
-- Substitua esta linha:
'$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy'

-- Pelo novo hash gerado
```

## Verificar se o Hash Está Correto

Após inserir os dados, teste o login:

```bash
# Via API
curl -X POST http://localhost:8080/auth/login \
  -H "Content-Type: application/json" \
  -d '{"email":"admin@onepilates.com","senha":"12345678"}'
```

Se retornar token, o hash está correto!

