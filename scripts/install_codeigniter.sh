#!/bin/bash

# Script para instalar o CodeIgniter

echo "=== Instalando CodeIgniter 4 ==="

# Diretório base
BASE_DIR="/var/www/html"

# Verificar se já existe CodeIgniter instalado
if [ -f "${BASE_DIR}/app/Config/Paths.php" ]; then
    echo "CodeIgniter já parece estar instalado. Pulando instalação."
    exit 0
fi

# Limpar diretório base se estiver vazio ou contiver apenas arquivos de sistema
if [ -z "$(ls -A ${BASE_DIR} | grep -v 'lost+found')" ] || [ "$(ls -A ${BASE_DIR} | wc -l)" -lt 5 ]; then
    echo "Limpando diretório para nova instalação..."
    rm -rf ${BASE_DIR}/*
fi

# Instalar CodeIgniter via Composer se não estiver instalado
if [ ! -f "${BASE_DIR}/composer.json" ]; then
    echo "Instalando CodeIgniter 4 via Composer..."
    cd ${BASE_DIR}
    composer create-project codeigniter4/appstarter . --prefer-dist --no-interaction
    
    # Verificar se a instalação foi bem-sucedida
    if [ $? -ne 0 ]; then
        echo "ERRO: Falha ao instalar CodeIgniter via Composer."
        exit 1
    fi
fi

# Atualizar dependências
echo "Atualizando dependências..."
cd ${BASE_DIR}
composer update --no-interaction

# Garantir que o spark seja executável
chmod +x ${BASE_DIR}/spark

# Copiar o arquivo env se não existir .env
if [ ! -f "${BASE_DIR}/.env" ] && [ -f "${BASE_DIR}/env" ]; then
    echo "Criando arquivo .env..."
    cp ${BASE_DIR}/env ${BASE_DIR}/.env
fi

echo "=== CodeIgniter 4 instalado com sucesso! ==="