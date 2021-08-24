#!/bin/bash
. `pwd`/../.env
php /var/www/scripts/wait-for-db.php
if [ ! -d ".git" ]; then
    git clone --progress --single-branch --depth 1 --branch "${VERSION}" --recurse-submodules -j 4 $REPOSITORY /tmp/app
    rsync -r /tmp/app/ .
    composer install
    yarn install
    yarn build
    chown -R www-data:www-data .
fi
php-fpm
