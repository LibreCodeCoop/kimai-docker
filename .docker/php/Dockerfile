FROM php:8.2-fpm

RUN apt-get update

RUN apt-get install -y \
    git \
    libzip-dev \
    procps \
    rsync \
    unzip

# Install PHP extensions
ADD https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/
RUN chmod uga+x /usr/local/bin/install-php-extensions && sync \
    && install-php-extensions \
    gd \
    intl \
    mysqli \
#     pdo \
    pdo_mysql \
#     pgsql \
#     sockets \
    xdebug \
    xsl \
    zip \
    @composer \
    && rm /usr/local/bin/install-php-extensions

COPY config/php.ini /usr/local/etc/php/conf.d/

WORKDIR /var/www/html

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
ENTRYPOINT [ "sh", "/usr/local/bin/entrypoint.sh" ]
