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