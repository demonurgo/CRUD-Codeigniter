# Configuração para Deploy

Este documento fornece instruções para fazer o deploy do aplicativo CRUD em plataformas gratuitas.

## Opções de Hospedagem Gratuita

### 1. Render

O [Render](https://render.com/) oferece um tier gratuito que suporta Docker e PostgreSQL.

#### Configuração no Render:

1. Crie uma conta no Render
2. Crie um novo serviço Web
3. Conecte ao seu repositório Git
4. Configure como serviço Docker
5. Defina porta como 80
6. Crie um banco de dados PostgreSQL (também disponível no plano gratuito)
7. Configure as variáveis de ambiente:
   - `CI_ENVIRONMENT=production`
   - `database.default.hostname=<db-endpoint-do-render>`
   - `database.default.database=<nome-do-banco>`
   - `database.default.username=<usuario>`
   - `database.default.password=<senha>`

### 2. Railway

O [Railway](https://railway.app/) oferece um plano gratuito com créditos mensais.

#### Configuração no Railway:

1. Crie uma conta no Railway
2. Inicie um novo projeto a partir do seu repositório Git
3. Adicione um serviço de banco de dados PostgreSQL
4. Configure as variáveis de ambiente:
   - `CI_ENVIRONMENT=production`
   - `database.default.hostname=${{ PGHOST }}`
   - `database.default.database=${{ PGDATABASE }}`
   - `database.default.username=${{ PGUSER }}`
   - `database.default.password=${{ PGPASSWORD }}`
   - `database.default.port=${{ PGPORT }}`

### 3. Fly.io

O [Fly.io](https://fly.io/) também oferece um tier gratuito.

#### Configuração no Fly.io:

1. Instale o CLI do Fly.io
2. Execute `flyctl auth login`
3. Crie um arquivo `fly.toml` na raiz do projeto
4. Execute `flyctl launch`
5. Crie o banco de dados: `flyctl postgres create`
6. Configure as variáveis de ambiente através do dashboard ou CLI

## Preparação para Produção

Antes de fazer o deploy em produção, certifique-se de:

1. Alterar o arquivo `.env` para o ambiente de produção:
   ```
   CI_ENVIRONMENT = production
   app.baseURL = 'https://seu-dominio-de-producao.com'
   ```

2. Habilitar cache para melhor performance em `app/Config/Cache.php`:
   ```php
   public $handler = 'file';
   ```

3. Configurar logs adequadamente em `app/Config/Logger.php`:
   ```php
   public $threshold = 3; // Errors, critical, alerts, emergencies
   ```

4. Habilitar CSRF protection em `app/Config/Filters.php`:
   ```php
   public $globals = [
       'before' => [
           'csrf' => ['except' => ['api/*']],
       ],
   ];
   ```

5. Otimize o composer:
   ```bash
   composer install --optimize-autoloader --no-dev
   ```

## Comandos para Deploy

Após configurar sua plataforma de hospedagem, execute:

```bash
# Para Render/Railway (caso use GitHub para deploy)
git add .
git commit -m "Preparando para deploy"
git push

# Para Fly.io
flyctl deploy
```