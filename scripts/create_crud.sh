#!/bin/bash

# Script para criar a estrutura do CRUD

echo "=== Criando estrutura do CRUD ==="

# Diretório base
BASE_DIR="/var/www/html"
APP_DIR="${BASE_DIR}/app"
TEMPLATES_DIR="${BASE_DIR}/../templates"

# Criar diretórios necessários
echo "Criando diretórios..."
mkdir -p "${APP_DIR}/Models"
mkdir -p "${APP_DIR}/Controllers"
mkdir -p "${APP_DIR}/Views/produtos"
mkdir -p "${APP_DIR}/Views/templates"

# Copiar templates
echo "Copiando templates..."
if [ -d "${TEMPLATES_DIR}/models" ]; then
    cp "${TEMPLATES_DIR}/models/ProdutoModel.php" "${APP_DIR}/Models/" 2>/dev/null || echo "Template de modelo não encontrado, continuando..."
fi

if [ -d "${TEMPLATES_DIR}/controllers" ]; then
    cp "${TEMPLATES_DIR}/controllers/Produtos.php" "${APP_DIR}/Controllers/" 2>/dev/null || echo "Template de controlador não encontrado, continuando..."
fi

if [ -d "${TEMPLATES_DIR}/views" ]; then
    cp "${TEMPLATES_DIR}/views/templates/"* "${APP_DIR}/Views/templates/" 2>/dev/null || echo "Templates de header/footer não encontrados, continuando..."
    cp "${TEMPLATES_DIR}/views/produtos/"* "${APP_DIR}/Views/produtos/" 2>/dev/null || echo "Templates de views não encontrados, continuando..."
fi

# Se não havia templates, usar o script de deploy
if [ ! -f "${APP_DIR}/Models/ProdutoModel.php" ]; then
    echo "Templates não encontrados, executando script de deploy..."
    if [ -f "${BASE_DIR}/../deploy-crud.sh" ]; then
        bash "${BASE_DIR}/../deploy-crud.sh"
    else
        echo "ERRO: Script de deploy não encontrado!"
        exit 1
    fi
fi

# Configurar rotas
echo "Configurando rotas..."
ROUTES_FILE="${APP_DIR}/Config/Routes.php"
if [ -f "${ROUTES_FILE}" ]; then
    # Verificar se as rotas já existem
    if ! grep -q "produtos" "${ROUTES_FILE}"; then
        # Adicionar rotas para produtos antes da linha final
        sed -i '/\$routes->get/a \
// Rotas para o CRUD de Produtos\n\$routes->group(\'produtos\', static function (\$routes) {\n    \$routes->get(\'/\', \'Produtos::index\');\n    \$routes->get(\'create\', \'Produtos::create\');\n    \$routes->post(\'store\', \'Produtos::store\');\n    \$routes->get(\'show/(:num)\', \'Produtos::show/$1\');\n    \$routes->get(\'edit/(:num)\', \'Produtos::edit/$1\');\n    \$routes->post(\'update/(:num)\', \'Produtos::update/$1\');\n    \$routes->get(\'delete/(:num)\', \'Produtos::delete/$1\');\n});' "${ROUTES_FILE}"
    fi
fi

echo "=== Estrutura do CRUD criada com sucesso! ==="