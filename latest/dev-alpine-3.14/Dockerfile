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
    && docker-php-ext-install pdo_mysql
