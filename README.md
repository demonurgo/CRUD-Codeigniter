# CRUD CodeIgniter 4 com PostgreSQL

Um projeto CRUD simples utilizando CodeIgniter 4 e PostgreSQL.

## Estrutura Modular

Este projeto foi reestruturado para utilizar uma abordagem modular, que facilita a manutenção e aceleração da implementação.

### Diretórios Principais

- `scripts/` - Scripts modulares para implementação do CRUD
- `templates/` - Templates para criação de arquivos
- `sql/` - Scripts SQL para inicialização do banco de dados
- `src/` - Arquivos fonte do CodeIgniter

### Scripts Disponíveis

- `setup-modular.sh` - Script principal que executa todos os módulos
- `scripts/install_codeigniter.sh` - Instala o CodeIgniter
- `scripts/configure_environment.sh` - Configura o ambiente
- `scripts/init_database.sh` - Inicializa o banco de dados
- `scripts/create_crud.sh` - Cria a estrutura do CRUD
- `scripts/finalize_setup.sh` - Finaliza configurações

## Como Executar

1. Clone o repositório
2. Execute `docker-compose up -d` para iniciar os containers
3. Execute o script de setup: `docker exec -it app-container bash -c "cd /var/www/html && ./setup-modular.sh"`
4. Acesse http://localhost:8080/produtos

## Hospedagem Gratuita

Este projeto pode ser facilmente implantado em plataformas de hospedagem gratuita como:

- Heroku (with PostgreSQL addon)
- Railway
- Render
- Fly.io

## Customização

Para customizar o CRUD, você pode:

1. Modificar os templates em `templates/`
2. Executar apenas os scripts necessários em `scripts/`
3. Adaptar os módulos conforme necessário