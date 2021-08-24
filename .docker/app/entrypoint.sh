#!/bin/bash
. `pwd`/../.env
. ${NVM_DIR}/nvm.sh
php /var/www/scripts/wait-for-db.php
if [ ! -d ".git" ]; then
    git clone --progress --single-branch --depth 1 --branch "${VERSION}" --recurse-submodules -j 4 $REPOSITORY /tmp/app
    rsync -r /tmp/app/ .
    composer install
    bin/console kimai:install -n
    bin/console kimai:create-user $ADMIN_USERNAME $ADMIN_EMAIL ROLE_SUPER_ADMIN $ADMIN_PASSWORD
    yarn install
    yarn build
    chown -R www-data:www-data .
fi
php-fpm
