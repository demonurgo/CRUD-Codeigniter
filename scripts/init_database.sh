#!/bin/bash

# Script para inicializar o banco de dados

echo "=== Inicializando banco de dados ==="

# Diretório base
BASE_DIR="/var/www/html"

# Aguardar o banco de dados estar pronto
echo "Aguardando o banco de dados estar pronto..."
sleep 5

# Verificar se podemos criar a tabela diretamente com o arquivo PHP
if [ -f "${BASE_DIR}/../scripts/create_database.php" ]; then
    echo "Criando banco de dados com script PHP..."
    php "${BASE_DIR}/../scripts/create_database.php"
else
    echo "Script de criação do banco de dados não encontrado!"
    echo "Verificando se há script SQL para inicialização..."
    
    # Verificar se o script SQL já foi copiado para o container do PostgreSQL
    if [ -f "${BASE_DIR}/../sql/init.sql" ]; then
        echo "Script SQL encontrado! O banco de dados deve ser inicializado automaticamente pelo Docker."
    else
        echo "AVISO: Nenhum script de inicialização encontrado. O banco de dados pode não estar configurado corretamente."
    fi
fi

echo "=== Inicialização do banco de dados concluída! ==="