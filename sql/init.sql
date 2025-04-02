-- Inicialização do banco de dados

-- Criar tabela de produtos
CREATE TABLE IF NOT EXISTS produtos (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    descricao TEXT,
    preco DECIMAL(10,2) NOT NULL,
    quantidade INT NOT NULL DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Inserir alguns dados de exemplo
INSERT INTO produtos (nome, descricao, preco, quantidade) VALUES
('Produto 1', 'Descrição do produto 1', 19.99, 50),
('Produto 2', 'Descrição do produto 2', 29.99, 30),
('Produto 3', 'Descrição do produto 3', 39.99, 20);