FROM php:7.3-fpm

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    libmagickwand-dev \
    libmcrypt-dev \
    libzip-dev \
    wget \
    zip \
    && docker-php-ext-configure zip --with-libzip \
    && docker-php-ext-install zip

RUN pecl install imagick \
    && docker-php-ext-enable imagick \
    && pecl install mcrypt-1.0.2 \
    && docker-php-ext-enable mcrypt \
    && docker-php-ext-install pdo_mysql

RUN cd ~; \
    wget https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.5/wkhtmltox_0.12.5-1.buster_amd64.deb; \
    dpkg -i ~/wkhtmltox_0.12.5-1.buster_amd64.deb; \
    apt-get install -y -f;

COPY --from=library/composer:2.1.9 /usr/bin/composer /usr/local/bin/composer
