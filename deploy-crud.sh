#!/bin/bash

# Script para copiar os arquivos do CRUD para o CodeIgniter no container

echo "=== Implantando arquivos do CRUD para o CodeIgniter ==="

# Diretório base dos arquivos do CRUD
CRUD_DIR="/var/www/html"
APP_DIR="${CRUD_DIR}/app"

# Criar estrutura de diretórios
echo "Criando estrutura de diretórios..."
mkdir -p "${APP_DIR}/Models"
mkdir -p "${APP_DIR}/Controllers"
mkdir -p "${APP_DIR}/Views/produtos"
mkdir -p "${APP_DIR}/Views/templates"
mkdir -p "${APP_DIR}/Config"

# Criar Model de Produtos
echo "Criando Model de Produtos..."
cat > "${APP_DIR}/Models/ProdutoModel.php" << 'EOL'
<?php

namespace App\Models;

use CodeIgniter\Model;

class ProdutoModel extends Model
{
    protected $table = 'produtos';
    protected $primaryKey = 'id';
    
    protected $useAutoIncrement = true;
    protected $returnType = 'array';
    
    protected $allowedFields = ['nome', 'descricao', 'preco', 'quantidade'];
    
    // Datas
    protected $useTimestamps = true;
    protected $dateFormat = 'datetime';
    protected $createdField = 'created_at';
    protected $updatedField = 'updated_at';
    
    // Validação
    protected $validationRules = [
        'nome' => 'required|min_length[3]|max_length[255]',
        'preco' => 'required|numeric',
        'quantidade' => 'required|integer'
    ];
    
    protected $validationMessages = [
        'nome' => [
            'required' => 'O campo nome é obrigatório',
            'min_length' => 'O nome deve ter pelo menos 3 caracteres',
            'max_length' => 'O nome não pode ter mais de 255 caracteres'
        ],
        'preco' => [
            'required' => 'O campo preço é obrigatório',
            'numeric' => 'O preço deve ser um valor numérico'
        ],
        'quantidade' => [
            'required' => 'O campo quantidade é obrigatório',
            'integer' => 'A quantidade deve ser um número inteiro'
        ]
    ];
    
    protected $skipValidation = false;
}
EOL

# Criar Controller de Produtos
echo "Criando Controller de Produtos..."
cat > "${APP_DIR}/Controllers/Produtos.php" << 'EOL'
<?php

namespace App\Controllers;

use App\Controllers\BaseController;
use App\Models\ProdutoModel;

class Produtos extends BaseController
{
    protected $produtoModel;
    
    public function __construct()
    {
        $this->produtoModel = new ProdutoModel();
    }
    
    // Listar todos os produtos
    public function index()
    {
        $data = [
            'title' => 'Lista de Produtos',
            'produtos' => $this->produtoModel->findAll()
        ];
        
        return view('produtos/index', $data);
    }
    
    // Exibir formulário de criação
    public function create()
    {
        $data = [
            'title' => 'Adicionar Produto'
        ];
        
        return view('produtos/create', $data);
    }
    
    // Salvar novo produto
    public function store()
    {
        $data = [
            'nome' => $this->request->getPost('nome'),
            'descricao' => $this->request->getPost('descricao'),
            'preco' => $this->request->getPost('preco'),
            'quantidade' => $this->request->getPost('quantidade')
        ];
        
        if ($this->produtoModel->save($data)) {
            return redirect()->to('/produtos')->with('message', 'Produto adicionado com sucesso!');
        } else {
            return redirect()->back()->withInput()->with('errors', $this->produtoModel->errors());
        }
    }
    
    // Exibir detalhes do produto
    public function show($id = null)
    {
        $produto = $this->produtoModel->find($id);
        
        if ($produto) {
            $data = [
                'title' => 'Detalhes do Produto',
                'produto' => $produto
            ];
            
            return view('produtos/show', $data);
        } else {
            return redirect()->to('/produtos')->with('error', 'Produto não encontrado!');
        }
    }
    
    // Exibir formulário de edição
    public function edit($id = null)
    {
        $produto = $this->produtoModel->find($id);
        
        if ($produto) {
            $data = [
                'title' => 'Editar Produto',
                'produto' => $produto
            ];
            
            return view('produtos/edit', $data);
        } else {
            return redirect()->to('/produtos')->with('error', 'Produto não encontrado!');
        }
    }
    
    // Atualizar produto
    public function update($id = null)
    {
        $data = [
            'id' => $id,
            'nome' => $this->request->getPost('nome'),
            'descricao' => $this->request->getPost('descricao'),
            'preco' => $this->request->getPost('preco'),
            'quantidade' => $this->request->getPost('quantidade')
        ];
        
        if ($this->produtoModel->save($data)) {
            return redirect()->to('/produtos')->with('message', 'Produto atualizado com sucesso!');
        } else {
            return redirect()->back()->withInput()->with('errors', $this->produtoModel->errors());
        }
    }
    
    // Excluir produto
    public function delete($id = null)
    {
        if ($this->produtoModel->delete($id)) {
            return redirect()->to('/produtos')->with('message', 'Produto excluído com sucesso!');
        } else {
            return redirect()->to('/produtos')->with('error', 'Não foi possível excluir o produto!');
        }
    }
}
EOL

# Criar Views
echo "Criando Views..."

# Template Header
cat > "${APP_DIR}/Views/templates/header.php" << 'EOL'
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><?= $title ?? 'CRUD de Produtos' ?></title>
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    
    <style>
        body {
            padding-top: 2rem;
            padding-bottom: 2rem;
        }
        .table-actions {
            width: 150px;
        }
    </style>
</head>
<body>
    <div class="container">
        <header class="mb-4">
            <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
                <div class="container-fluid">
                    <a class="navbar-brand" href="<?= site_url('/') ?>">CRUD CodeIgniter</a>
                    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                        <span class="navbar-toggler-icon"></span>
                    </button>
                    <div class="collapse navbar-collapse" id="navbarNav">
                        <ul class="navbar-nav">
                            <li class="nav-item">
                                <a class="nav-link" href="<?= site_url('/produtos') ?>">Produtos</a>
                            </li>
                        </ul>
                    </div>
                </div>
            </nav>
        </header>
        
        <?php if(session()->getFlashdata('message')): ?>
            <div class="alert alert-success alert-dismissible fade show">
                <?= session()->getFlashdata('message') ?>
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        <?php endif; ?>
        
        <?php if(session()->getFlashdata('error')): ?>
            <div class="alert alert-danger alert-dismissible fade show">
                <?= session()->getFlashdata('error') ?>
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        <?php endif; ?>
EOL

# Template Footer
cat > "${APP_DIR}/Views/templates/footer.php" << 'EOL'
        <footer class="mt-5 pt-3 border-top text-center text-muted">
            <p>&copy; <?= date('Y') ?> CRUD em CodeIgniter 4 com PostgreSQL</p>
        </footer>
    </div>
    
    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
EOL

# View Index
cat > "${APP_DIR}/Views/produtos/index.php" << 'EOL'
<?= $this->include('templates/header') ?>

<h1 class="mb-4"><?= $title ?></h1>

<div class="d-flex justify-content-end mb-3">
    <a href="<?= site_url('produtos/create') ?>" class="btn btn-success">
        <i class="fas fa-plus"></i> Novo Produto
    </a>
</div>

<div class="table-responsive">
    <table class="table table-striped table-hover">
        <thead>
            <tr>
                <th>ID</th>
                <th>Nome</th>
                <th>Preço</th>
                <th>Quantidade</th>
                <th class="table-actions">Ações</th>
            </tr>
        </thead>
        <tbody>
            <?php if(empty($produtos)): ?>
                <tr>
                    <td colspan="5" class="text-center">Nenhum produto cadastrado</td>
                </tr>
            <?php else: ?>
                <?php foreach($produtos as $produto): ?>
                    <tr>
                        <td><?= $produto['id'] ?></td>
                        <td><?= $produto['nome'] ?></td>
                        <td>R$ <?= number_format($produto['preco'], 2, ',', '.') ?></td>
                        <td><?= $produto['quantidade'] ?></td>
                        <td>
                            <a href="<?= site_url('produtos/show/'.$produto['id']) ?>" class="btn btn-sm btn-info" title="Visualizar">
                                <i class="fas fa-eye"></i>
                            </a>
                            <a href="<?= site_url('produtos/edit/'.$produto['id']) ?>" class="btn btn-sm btn-primary" title="Editar">
                                <i class="fas fa-edit"></i>
                            </a>
                            <a href="<?= site_url('produtos/delete/'.$produto['id']) ?>" class="btn btn-sm btn-danger" 
                               onclick="return confirm('Tem certeza que deseja excluir este produto?')" title="Excluir">
                                <i class="fas fa-trash"></i>
                            </a>
                        </td>
                    </tr>
                <?php endforeach; ?>
            <?php endif; ?>
        </tbody>
    </table>
</div>

<?= $this->include('templates/footer') ?>
EOL

# View Create
cat > "${APP_DIR}/Views/produtos/create.php" << 'EOL'
<?= $this->include('templates/header') ?>

<h1 class="mb-4"><?= $title ?></h1>

<div class="card">
    <div class="card-body">
        <form action="<?= site_url('produtos/store') ?>" method="post">
            <?= csrf_field() ?>
            
            <div class="mb-3">
                <label for="nome" class="form-label">Nome</label>
                <input type="text" class="form-control <?= session('errors.nome') ? 'is-invalid' : '' ?>" 
                       id="nome" name="nome" value="<?= old('nome') ?>" required>
                <div class="invalid-feedback">
                    <?= session('errors.nome') ?>
                </div>
            </div>
            
            <div class="mb-3">
                <label for="descricao" class="form-label">Descrição</label>
                <textarea class="form-control" id="descricao" name="descricao" rows="3"><?= old('descricao') ?></textarea>
            </div>
            
            <div class="mb-3">
                <label for="preco" class="form-label">Preço</label>
                <input type="number" class="form-control <?= session('errors.preco') ? 'is-invalid' : '' ?>" 
                       id="preco" name="preco" step="0.01" value="<?= old('preco') ?>" required>
                <div class="invalid-feedback">
                    <?= session('errors.preco') ?>
                </div>
            </div>
            
            <div class="mb-3">
                <label for="quantidade" class="form-label">Quantidade</label>
                <input type="number" class="form-control <?= session('errors.quantidade') ? 'is-invalid' : '' ?>" 
                       id="quantidade" name="quantidade" value="<?= old('quantidade', 0) ?>" required>
                <div class="invalid-feedback">
                    <?= session('errors.quantidade') ?>
                </div>
            </div>
            
            <div class="d-flex justify-content-between">
                <a href="<?= site_url('produtos') ?>" class="btn btn-secondary">Cancelar</a>
                <button type="submit" class="btn btn-primary">Salvar</button>
            </div>
        </form>
    </div>
</div>

<?= $this->include('templates/footer') ?>
EOL

# View Edit
cat > "${APP_DIR}/Views/produtos/edit.php" << 'EOL'
<?= $this->include('templates/header') ?>

<h1 class="mb-4"><?= $title ?></h1>

<div class="card">
    <div class="card-body">
        <form action="<?= site_url('produtos/update/'.$produto['id']) ?>" method="post">
            <?= csrf_field() ?>
            
            <div class="mb-3">
                <label for="nome" class="form-label">Nome</label>
                <input type="text" class="form-control <?= session('errors.nome') ? 'is-invalid' : '' ?>" 
                       id="nome" name="nome" value="<?= old('nome', $produto['nome']) ?>" required>
                <div class="invalid-feedback">
                    <?= session('errors.nome') ?>
                </div>
            </div>
            
            <div class="mb-3">
                <label for="descricao" class="form-label">Descrição</label>
                <textarea class="form-control" id="descricao" name="descricao" rows="3"><?= old('descricao', $produto['descricao']) ?></textarea>
            </div>
            
            <div class="mb-3">
                <label for="preco" class="form-label">Preço</label>
                <input type="number" class="form-control <?= session('errors.preco') ? 'is-invalid' : '' ?>" 
                       id="preco" name="preco" step="0.01" value="<?= old('preco', $produto['preco']) ?>" required>
                <div class="invalid-feedback">
                    <?= session('errors.preco') ?>
                </div>
            </div>
            
            <div class="mb-3">
                <label for="quantidade" class="form-label">Quantidade</label>
                <input type="number" class="form-control <?= session('errors.quantidade') ? 'is-invalid' : '' ?>" 
                       id="quantidade" name="quantidade" value="<?= old('quantidade', $produto['quantidade']) ?>" required>
                <div class="invalid-feedback">
                    <?= session('errors.quantidade') ?>
                </div>
            </div>
            
            <div class="d-flex justify-content-between">
                <a href="<?= site_url('produtos') ?>" class="btn btn-secondary">Cancelar</a>
                <button type="submit" class="btn btn-primary">Atualizar</button>
            </div>
        </form>
    </div>
</div>

<?= $this->include('templates/footer') ?>
EOL

# View Show
cat > "${APP_DIR}/Views/produtos/show.php" << 'EOL'
<?= $this->include('templates/header') ?>

<h1 class="mb-4"><?= $title ?></h1>

<div class="card">
    <div class="card-header d-flex justify-content-between align-items-center">
        <span>Detalhes do Produto #<?= $produto['id'] ?></span>
        <div>
            <a href="<?= site_url('produtos/edit/'.$produto['id']) ?>" class="btn btn-sm btn-primary">
                <i class="fas fa-edit"></i> Editar
            </a>
            <a href="<?= site_url('produtos/delete/'.$produto['id']) ?>" class="btn btn-sm btn-danger" 
               onclick="return confirm('Tem certeza que deseja excluir este produto?')">
                <i class="fas fa-trash"></i> Excluir
            </a>
        </div>
    </div>
    <div class="card-body">
        <table class="table table-bordered">
            <tr>
                <th style="width: 150px">ID</th>
                <td><?= $produto['id'] ?></td>
            </tr>
            <tr>
                <th>Nome</th>
                <td><?= $produto['nome'] ?></td>
            </tr>
            <tr>
                <th>Descrição</th>
                <td><?= $produto['descricao'] ?: '<em>Sem descrição</em>' ?></td>
            </tr>
            <tr>
                <th>Preço</th>
                <td>R$ <?= number_format($produto['preco'], 2, ',', '.') ?></td>
            </tr>
            <tr>
                <th>Quantidade</th>
                <td><?= $produto['quantidade'] ?></td>
            </tr>
            <tr>
                <th>Data de Criação</th>
                <td><?= date('d/m/Y H:i', strtotime($produto['created_at'])) ?></td>
            </tr>
            <tr>
                <th>Última Atualização</th>
                <td><?= date('d/m/Y H:i', strtotime($produto['updated_at'])) ?></td>
            </tr>
        </table>
    </div>
    <div class="card-footer">
        <a href="<?= site_url('produtos') ?>" class="btn btn-secondary">
            <i class="fas fa-arrow-left"></i> Voltar para a lista
        </a>
    </div>
</div>

<?= $this->include('templates/footer') ?>
EOL

# Configurar Rotas
echo "Configurando Rotas..."
cat > "${APP_DIR}/Config/Routes.php" << 'EOL'
<?php

namespace Config;

use CodeIgniter\Router\RouteCollection;

/**
 * @var RouteCollection $routes
 */
$routes->get('/', 'Home::index');

// Rotas para o CRUD de Produtos
$routes->group('produtos', static function ($routes) {
    $routes->get('/', 'Produtos::index');
    $routes->get('create', 'Produtos::create');
    $routes->post('store', 'Produtos::store');
    $routes->get('show/(:num)', 'Produtos::show/$1');
    $routes->get('edit/(:num)', 'Produtos::edit/$1');
    $routes->post('update/(:num)', 'Produtos::update/$1');
    $routes->get('delete/(:num)', 'Produtos::delete/$1');
});
EOL

# Criar tabela no banco de dados
echo "Criando tabela no banco de dados..."
cat > "/tmp/init-database.php" << 'EOL'
<?php
// Arquivo temporário para inicializar o banco de dados

$hostname = 'db';
$database = 'crud_db';
$username = 'crud_user';
$password = 'crud_password';
$port = 5432;

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
    
    // Inserir dados de exemplo
    $sql = "
    INSERT INTO produtos (nome, descricao, preco, quantidade) VALUES
    ('Produto 1', 'Descrição do produto 1', 19.99, 50),
    ('Produto 2', 'Descrição do produto 2', 29.99, 30),
    ('Produto 3', 'Descrição do produto 3', 39.99, 20)
    ON CONFLICT (id) DO NOTHING;";
    
    $pdo->exec($sql);
    echo "Dados de exemplo inseridos com sucesso!\n";
    
} catch (PDOException $e) {
    echo "Erro de conexão/criação: " . $e->getMessage() . "\n";
}
EOL

# Executar script para criar banco de dados
echo "Executando script para criar banco de dados..."
php /tmp/init-database.php

echo "=== CRUD implantado com sucesso! ==="
echo "Acesse http://localhost:8080/produtos no seu navegador para ver a aplicação."