ARG VERSION

FROM kimai/kimai2:fpm-${VERSION}

RUN  apk add --no-cache \
    rsync

# Install PHP extensions
ADD https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/
RUN chmod uga+x /usr/local/bin/install-php-extensions &&\
    install-php-extensions \
    xdebug

COPY config/php.ini /usr/local/etc/php/conf.d/docker-php-kimai.ini

WORKDIR /opt/kimai

RUN mv /opt/kimai /opt/kimai-tmp
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
ENTRYPOINT [ "sh", "/usr/local/bin/entrypoint.sh" ]
