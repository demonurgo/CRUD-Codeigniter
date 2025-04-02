#!/bin/bash

# Script para finalizar a configuração do CRUD

echo "=== Finalizando configuração do CRUD ==="

# Diretório base
BASE_DIR="/var/www/html"

# Ajustar permissões
echo "Ajustando permissões..."
chown -R www-data:www-data "${BASE_DIR}"
chmod -R 755 "${BASE_DIR}"

# Confirmar que writable é gravável
chmod -R 777 "${BASE_DIR}/writable"

# Limpar cache
echo "Limpando cache..."
php "${BASE_DIR}/spark" cache:clear

echo "=== Configuração finalizada com sucesso! ==="
echo "\nPara acessar o CRUD, visite: http://localhost:8080/produtos"
echo "O sistema está pronto para uso!\n"