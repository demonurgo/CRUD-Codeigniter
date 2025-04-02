FROM php:8.1-apache

# Instalar dependências necessárias
RUN apt-get update && apt-get install -y \
    libpq-dev \
    libzip-dev \
    unzip \
    git \
    libicu-dev \
    curl \
    && docker-php-ext-install \
    pdo \
    pdo_pgsql \
    pgsql \
    zip \
    intl \
    opcache

# Habilitar mod_rewrite e outros módulos úteis
RUN a2enmod rewrite headers deflate expires

# Configurar o DocumentRoot do Apache para o diretório public do CodeIgniter
RUN sed -i 's!/var/www/html!/var/www/html/public!g' /etc/apache2/sites-available/000-default.conf

# Instalar Composer - método alternativo
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php composer-setup.php --install-dir=/usr/bin --filename=composer \
    && php -r "unlink('composer-setup.php');"

# Definir diretório de trabalho
WORKDIR /var/www/html

# Configurar PHP para produção
RUN { \
        echo 'opcache.memory_consumption=128'; \
        echo 'opcache.interned_strings_buffer=8'; \
        echo 'opcache.max_accelerated_files=4000'; \
        echo 'opcache.revalidate_freq=2'; \
        echo 'opcache.fast_shutdown=1'; \
        echo 'opcache.enable_cli=1'; \
    } > /usr/local/etc/php/conf.d/opcache-recommended.ini

# Copiar arquivos de configuração do Apache
COPY apache-optimization.conf /etc/apache2/conf-available/
RUN a2enconf apache-optimization

# Ajustar permissões
RUN chown -R www-data:www-data /var/www/html