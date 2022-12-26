FROM php:7.3-fpm

ARG ENV

COPY --from=library/composer:2.1.9 /usr/bin/composer /usr/local/bin/composer

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    libmagickwand-dev \
    libmcrypt-dev \
    libzip-dev \
    wget \
    zip \
    nginx \
    mcdu \
    && docker-php-ext-configure zip --with-libzip \
    && docker-php-ext-install zip \
    && pecl install imagick \
    && docker-php-ext-enable imagick \
    && pecl install mcrypt-1.0.2 \
    && docker-php-ext-enable mcrypt \
    && docker-php-ext-install pdo_mysql \
    && cd ~; \
    && wget https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.5/wkhtmltox_0.12.5-1.buster_amd64.deb \
    && dpkg -i ~/wkhtmltox_0.12.5-1.buster_amd64.deb \
    && apt-get install -y -f


RUN if [[ "$ENV" == "development" ]]; then \
    echo "Installing xdebug"; \
    pecl install xdebug-2.8.0; \
    docker-php-ext-enable xdebug; \
    echo "xdebug.remote_enable=1" >> /usr/local/etc/php/php.ini; \
    echo "xdebug.remote_port=9000" >> /usr/local/etc/php/php.ini; \
    echo "xdebug.remote_autostart=1" >> /usr/local/etc/php/php.ini; \
    echo "xdebug.remote_connect_back=0" >> /usr/local/etc/php/php.ini; \
    echo "xdebug.idekey=PHPSTORM" >> /usr/local/etc/php/php.ini; \
    echo "memory_limit=-1" >> /usr/local/etc/php/php.ini; \
    else echo "Without xdebug"; \
    fi;
