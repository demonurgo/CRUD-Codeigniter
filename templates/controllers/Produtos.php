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