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