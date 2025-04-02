<?php

// Script para criar e inicializar o banco de dados PostgreSQL

// Configurações de conexão
$hostname = 'db';
$database = 'crud_db';
$username = 'crud_user';
$password = 'crud_password';
$port = 5432;

echo "=== Inicializando banco de dados PostgreSQL ===\n";

try {
    // Conectar ao PostgreSQL
    $dsn = "pgsql:host=$hostname;port=$port;dbname=$database";
    $pdo = new PDO($dsn, $username, $password);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    
    echo "Conectado ao PostgreSQL com sucesso!\n";
    
    // Criar tabela produtos
    $sql = "
    CREATE TABLE IF NOT EXISTS produtos (
        id SERIAL PRIMARY KEY,
        nome VARCHAR(255) NOT NULL,
        descricao TEXT,
        preco DECIMAL(10,2) NOT NULL,
        quantidade INT NOT NULL DEFAULT 0,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    );";
    
    $pdo->exec($sql);
    echo "Tabela 'produtos' criada com sucesso!\n";
    
    // Verificar se já existem dados
    $stmt = $pdo->query("SELECT COUNT(*) FROM produtos");
    $count = $stmt->fetchColumn();
    
    if ($count == 0) {
        // Inserir dados de exemplo
        $sql = "
        INSERT INTO produtos (nome, descricao, preco, quantidade) VALUES
        ('Produto 1', 'Descrição do produto 1', 19.99, 50),
        ('Produto 2', 'Descrição do produto 2', 29.99, 30),
        ('Produto 3', 'Descrição do produto 3', 39.99, 20);";
        
        $pdo->exec($sql);
        echo "Dados de exemplo inseridos com sucesso!\n";
    } else {
        echo "Dados já existem na tabela, pulando inserção.\n";
    }
    
    echo "=== Banco de dados inicializado com sucesso! ===\n";
    
} catch (PDOException $e) {
    echo "Erro de conexão/criação: " . $e->getMessage() . "\n";
    exit(1);
}