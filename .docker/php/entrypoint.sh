#!/bin/bash

php /var/www/scripts/wait-for-db.php
if [ ! -d ".git" ]; then
    git clone --progress --single-branch --depth 1 --branch "${VERSION}" --recurse-submodules -j 4 $REPOSITORY /tmp/app
    rsync -r /tmp/app/ .
    composer install
    bin/console kimai:install -n
    kimai:user:create $ADMIN_USERNAME $ADMIN_EMAIL ROLE_SUPER_ADMIN $ADMIN_PASSWORD
    chown -R www-data:www-data .
    chmod -R g+r .
    chmod -R g+rw var/
fi
php-fpm
