FROM php:fpm

RUN apt-get update
RUN apt-get install -y \
        libcurl4-openssl-dev \
        cron \
        git \
        libonig-dev \
        libzip-dev \
        rsync \
        unzip

# Install MySQL
RUN docker-php-ext-configure mysqli -with-mysqli=mysqlnd \
    && docker-php-ext-configure pdo_mysql -with-pdo-mysql=mysqlnd \
    && docker-php-ext-install pdo pdo_mysql mysqli

# Install GD
RUN apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
        libxpm-dev

RUN docker-php-ext-configure gd --with-freetype=/usr/include/ \
                                --with-jpeg=/usr/include/ \
                                --with-xpm=/usr/include/ \
                                --enable-gd-jis-conv \
    && docker-php-ext-install gd

# Install mbstring
RUN docker-php-ext-install -j$(nproc) \
        mbstring

# Install intl
RUN apt-get install -y \
        libicu-dev
RUN docker-php-ext-install intl

# Install xdebug
RUN pecl install xdebug-3.2.0 \
    && docker-php-ext-enable xdebug

# Install zip
RUN docker-php-ext-install zip

# Install xslt
RUN apt-get install -y \
        libxslt1-dev
RUN docker-php-ext-install xsl

# Install npm
ENV NVM_DIR=/opt/nvm
RUN git clone https://github.com/nvm-sh/nvm.git $NVM_DIR
RUN cd $NVM_DIR && \
    git checkout `git describe --abbrev=0 --tags --match "v[0-9]*" $(git rev-list --tags --max-count=1)` && \
    . $NVM_DIR/nvm.sh && \
    nvm install 14 && \
    nvm use node && \
    npm install --global yarn
RUN echo "source ${NVM_DIR}/nvm.sh" > $HOME/.bashrc

COPY --from=composer /usr/bin/composer /usr/bin/composer

COPY config/php.ini /usr/local/etc/php/conf.d/

WORKDIR /var/www/html
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
ENTRYPOINT [ "sh", "/usr/local/bin/entrypoint.sh" ]
