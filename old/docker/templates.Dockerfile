FROM php:8.2-apache

# Set ServerName to avoid Apache startup warnings
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

# Define global environment variables
ENV COMPOSER_ALLOW_SUPERUSER=1 \
    NODE_VERSION=20.14.0 \
    NVM_DIR=/root/.nvm \
    PATH="/root/.nvm/versions/node/v20.14.0/bin/:$PATH"

# Install system dependencies and PHP extensions
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
    docker-php-ext-install -j$(nproc) gd zip && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Install Composer globally
RUN curl -sS https://getcomposer.org/installer | php && \
    mv composer.phar /usr/local/bin/composer

# Install and enable Xdebug for development
RUN pecl install xdebug && docker-php-ext-enable xdebug

# Copy custom PHP and Xdebug configuration files
COPY ./docker/docker-php-ext-xdebug3-ext.ini /usr/local/etc/php/conf.d/docker-php-ext-xdebug-ext.ini
COPY ./docker/docker-php-extra.ini /usr/local/etc/php/conf.d/docker-php-extra.ini

# Copy utility scripts and bash environment (optional)
COPY ./docker/bash /root/bash
COPY ./docker/firstRun.sh /root/firstRun.sh
# RUN bash /root/firstRun.sh  # Uncomment if you want to run this during build

# Install Node.js using NVM (latest stable version)
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash && \
    . "$NVM_DIR/nvm.sh" && \
    nvm install $NODE_VERSION && \
    nvm use $NODE_VERSION && \
    nvm alias default $NODE_VERSION && \
    npm install -g npm && \
    node -v && npm -v
