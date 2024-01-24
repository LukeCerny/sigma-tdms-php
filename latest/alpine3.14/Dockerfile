FROM library/php:8.3-alpine3.18 as base

ARG ENV

COPY --from=library/composer:2.6.6 /usr/bin/composer /usr/local/bin/composer

RUN apk update \
    && apk add --no-cache \
    imagemagick \
    libmcrypt-dev \
    libzip-dev \
    wget \
    zip \
    autoconf \
    nginx \
    git \
    curl \
    sudo \
    nano \
    ncdu \
    # Install Wkhtmltopdf - END
    && docker-php-ext-configure zip \
    && docker-php-ext-install zip \
    && docker-php-ext-install pdo_mysql

RUN if [ "$ENV" = "development" ]; then \
    echo "Installing xdebug"; \
    apk add --no-cache php8.3-pecl-xdebug; \
    docker-php-ext-enable xdebug; \
    echo "xdebug.remote_enable=1" >> /usr/local/etc/php/php.ini; \
    echo "xdebug.remote_port=9000" >> /usr/local/etc/php/php.ini; \
    echo "xdebug.remote_autostart=1" >> /usr/local/etc/php/php.ini; \
    echo "xdebug.remote_connect_back=0" >> /usr/local/etc/php/php.ini; \
    echo "xdebug.idekey=PHPSTORM" >> /usr/local/etc/php/php.ini; \
    echo "memory_limit=-1" >> /usr/local/etc/php/php.ini;
    else echo "Without xdebug"; \
    fi;
