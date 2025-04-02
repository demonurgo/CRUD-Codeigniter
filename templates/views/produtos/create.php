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