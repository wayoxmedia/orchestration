# Apache + PHP 8.2
FROM php:8.2-apache

# Avoid Apache warnings
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

# ---- Global ENV (Composer + Node via NVM) ----
ENV COMPOSER_ALLOW_SUPERUSER=1 \
    NODE_VERSION=20.17.0 \
    NVM_DIR=/root/.nvm \
    PATH="/root/.nvm/versions/node/v20.17.0/bin/:$PATH"

# ---- System deps + PHP extensions (Laravel-friendly) ----
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
        curl \
        git \
        nano \
        zip \
        unzip \
        libzip-dev \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
        libxml2-utils \
        ca-certificates \
        gnupg \
        lsb-release && \
    docker-php-ext-configure gd --with-freetype --with-jpeg && \
    docker-php-ext-install -j"$(nproc)" gd zip pdo_mysql && \
    rm -rf /var/lib/apt/lists/*

# ---- Composer global ----
RUN curl -sS https://getcomposer.org/installer | php && \
    mv composer.phar /usr/local/bin/composer

# ---- Xdebug 3 (config fina se monta por volumen en compose) ----
RUN pecl install xdebug && docker-php-ext-enable xdebug

# ---- Apache modules útiles ----
RUN a2enmod rewrite headers env

# ---- Opcache y ajustes de dev razonables ----
RUN { \
      echo "opcache.enable=1"; \
      echo "opcache.enable_cli=0"; \
      echo "opcache.validate_timestamps=1"; \
      echo "opcache.revalidate_freq=0"; \
      echo "opcache.max_accelerated_files=20000"; \
      echo "memory_limit=512M"; \
    } > /usr/local/etc/php/conf.d/dev.ini

# ---- Node.js via NVM ----
# Instala NVM, Node $NODE_VERSION y asegura PATH para shells no interactivos
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash && \
    . "$NVM_DIR/nvm.sh" && \
    nvm install "$NODE_VERSION" && \
    nvm alias default "$NODE_VERSION" && \
    nvm use default && \
    npm install -g npm && \
    node -v && npm -v

# Default CMD
CMD ["apache2-foreground"]
