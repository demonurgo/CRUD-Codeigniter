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