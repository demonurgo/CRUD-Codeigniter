#!/bin/bash

# Script para configurar o ambiente do CodeIgniter

echo "=== Configurando ambiente do CodeIgniter ==="

# Diretório base
BASE_DIR="/var/www/html"

# Criar arquivo .env
echo "Criando arquivo .env personalizado..."
cp "${BASE_DIR}/env" "${BASE_DIR}/.env"

# Ajustar configurações do .env
sed -i 's/CI_ENVIRONMENT = production/CI_ENVIRONMENT = development/g' "${BASE_DIR}/.env"
sed -i 's/app.baseURL = \'\'/app.baseURL = \'http:\/\/localhost:8080\'/g' "${BASE_DIR}/.env"

# Configurar banco de dados
echo "Configurando conexão com o banco de dados PostgreSQL..."
cat >> "${BASE_DIR}/.env" << 'EOL'

# Database Configuration
database.default.hostname = db
database.default.database = crud_db
database.default.username = crud_user
database.default.password = crud_password
database.default.DBDriver = Postgre
database.default.port = 5432
database.default.charset = utf8
database.default.DBCollat = utf8_general_ci
EOL

echo "=== Ambiente configurado com sucesso! ==="