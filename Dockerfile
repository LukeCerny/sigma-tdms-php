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

#RUN apt-get update && apt-get install -y pngquant

#RUN docker-php-ext-install mysqli
RUN pecl install xdebug-2.8.0 \
    && docker-php-ext-enable xdebug \
    && echo "xdebug.remote_enable=1" >> /usr/local/etc/php/php.ini \
    && echo "xdebug.remote_port=9000" >> /usr/local/etc/php/php.ini \
    && echo "xdebug.remote_autostart=1" >> /usr/local/etc/php/php.ini \
    && echo "xdebug.remote_connect_back=0" >> /usr/local/etc/php/php.ini \
    && echo "xdebug.idekey=PHPSTORM" >> /usr/local/etc/php/php.ini \
    && echo "memory_limit=-1" >> /usr/local/etc/php/php.ini

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php -r "copy('https://composer.github.io/installer.sig', 'composer.sig');" \
    && php -r "if (hash_file('sha384', 'composer-setup.php') === file_get_contents('composer.sig')) { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); unlink('composer.sig'); } echo PHP_EOL;" \
    && php composer-setup.php --install-dir=/usr/local/bin --filename=composer --version=2.1.9 \
    && php -r "unlink('composer-setup.php'); unlink('composer.sig');"
