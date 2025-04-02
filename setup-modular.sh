#!/bin/bash

# Script principal para configuração modular do CRUD

echo "===================================================="
echo "=== Iniciando configuração modular do CRUD CI4 ==="
echo "===================================================="

# Definir diretório base
BASE_DIR="$(pwd)"
SCRIPTS_DIR="${BASE_DIR}/scripts"

# Verficar se estamos no diretório correto
if [ ! -d "${SCRIPTS_DIR}" ]; then
    PARENT_DIR="$(dirname "${BASE_DIR}")"
    SCRIPTS_DIR="${PARENT_DIR}/scripts"
    
    if [ ! -d "${SCRIPTS_DIR}" ]; then
        echo "ERRO: Diretório de scripts não encontrado!"
        echo "Este script deve ser executado no diretório raiz do projeto ou dentro de /var/www/html"
        exit 1
    fi
fi

echo "\n\n=> Etapa 1: Instalação do CodeIgniter"
if [ -f "${SCRIPTS_DIR}/install_codeigniter.sh" ]; then
    bash "${SCRIPTS_DIR}/install_codeigniter.sh"
else
    echo "ERRO: Script de instalação do CodeIgniter não encontrado!"
    exit 1
fi

echo "\n\n=> Etapa 2: Configuração do ambiente"
if [ -f "${SCRIPTS_DIR}/configure_environment.sh" ]; then
    bash "${SCRIPTS_DIR}/configure_environment.sh"
else
    echo "ERRO: Script de configuração do ambiente não encontrado!"
    exit 1
fi

echo "\n\n=> Etapa 3: Inicialização do banco de dados"
if [ -f "${SCRIPTS_DIR}/init_database.sh" ]; then
    bash "${SCRIPTS_DIR}/init_database.sh"
else
    echo "ERRO: Script de inicialização do banco de dados não encontrado!"
    exit 1
fi

echo "\n\n=> Etapa 4: Criação da estrutura do CRUD"
if [ -f "${SCRIPTS_DIR}/create_crud.sh" ]; then
    bash "${SCRIPTS_DIR}/create_crud.sh"
else
    echo "ERRO: Script de criação do CRUD não encontrado!"
    exit 1
fi

echo "\n\n=> Etapa 5: Finalização da configuração"
if [ -f "${SCRIPTS_DIR}/finalize_setup.sh" ]; then
    bash "${SCRIPTS_DIR}/finalize_setup.sh"
else
    echo "ERRO: Script de finalização não encontrado!"
    exit 1
fi

echo "\n======================================================="
echo "=== Configuração modular do CRUD CI4 concluída! ==="
echo "======================================================="
echo "\nAcesse http://localhost:8080/produtos para visualizar o CRUD.\n"