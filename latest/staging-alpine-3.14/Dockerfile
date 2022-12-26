FROM library/php:7.3-alpine3.14

COPY --from=library/composer:2.1.9 /usr/bin/composer /usr/local/bin/composer

RUN apk update \
    && apk add --no-cache \
    imagemagic-dev \
    libmcrypt-dev \
    libzip-dev \
    wget \
    zip \
    autoconf \
    # Install Wkhtmltopdf - START
    wkhtmltopdf \
    xvfb \
    ttf-dejavu ttf-droid ttf-freefont ttf-liberation \
    && ln -s /usr/bin/wkhtmltopdf /usr/local/bin/wkhtmltopdf \
    && chmod +x /usr/local/bin/wkhtmltopdf \
    # Install Wkhtmltopdf - END
    && docker-php-ext-configure zip --with-libzip \
    && docker-php-ext-install zip \
    && docker-php-ext-install pdo_mysql \
    && pecl install xdebug-2.8.0 \
    && docker-php-ext-enable xdebug \
    && echo "xdebug.remote_enable=1" >> /usr/local/etc/php/php.ini \
    && echo "xdebug.remote_port=9000" >> /usr/local/etc/php/php.ini \
    && echo "xdebug.remote_autostart=1" >> /usr/local/etc/php/php.ini \
    && echo "xdebug.remote_connect_back=0" >> /usr/local/etc/php/php.ini \
    && echo "xdebug.idekey=PHPSTORM" >> /usr/local/etc/php/php.ini \
    && echo "memory_limit=-1" >> /usr/local/etc/php/php.ini
