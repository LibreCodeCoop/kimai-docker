#!/bin/bash

if [ ! -d ".git" ]; then
    rsync -r /opt/kimai-tmp/ /opt/kimai
    chown -R $USER_ID:$GROUP_ID /opt/kimai
fi

sed -i -e "s/^exec \/service.sh$/echo \"End of startup.sh\"/" /startup.sh
sed -i -e "s/www-kimai/www-data/" /startup.sh

sed -i -e "s/^runServer$/\n# runServer\n/" /service.sh

/bin/bash /startup.sh
echo "🟡 startup.sh finished"
/bin/bash /service.sh

function runServer() {
  # Just while I'm fixing things
  /opt/kimai/bin/console kimai:reload --env="$APP_ENV"
  chown -R $USER_ID:$GROUP_ID /opt/kimai
  if [ -e /use_apache ]; then
    echo "🏁 Running 🪶 apache server"
    exec /usr/sbin/apache2 -D FOREGROUND
  elif [ -e /use_fpm ]; then
    echo "🏁 Running 🐘 php-fpm server"
    exec php-fpm
  else
    echo "⚠️ Error, unknown server type"
  fi
}

runServer
