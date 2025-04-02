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