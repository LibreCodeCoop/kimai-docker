# Development
* Create a file called `.env` and put the follow content:
  ```env
  APP_ENV=prod
  XDEBUG_MODE=debug
  ```

## Using IDE
### Workspace folder

- To work with PHP, I recommend to open your IDE in folder `volumes/php`

### Xdebug on VSCode or Codium
### Configuring IDE
- Open the IDE on folder `volumes/php`
- setup the extension [PHP Debug](https://marketplace.visualstudio.com/items?itemName=xdebug.php-debug) or [PHP Extension Pack](https://marketplace.visualstudio.com/items?itemName=xdebug.php-pack)
- Press `F5` to start debugging or go to "`Run > Start debugging`"
- Create a `launch.json` file to PHP
- Add the follow to your `launch.json` inside configuration named as `Listen for Xdebug`:
  ```json
  "pathMappings": {
      "/opt/kimai": "${workspaceFolder}"
  }
  ```
- **PS**: [`log_level`](https://xdebug.org/docs/all_settings#log_level) is defined to 0 (Criticals). If you wish a different value, ghante this at `.env` file.

### Fix permissions

- The default user id (`USER_ID`) and group id (`GROUP_ID`) of root user inside container is the same of your user in host machine. This is defined in `.env` file. If is different of 1000 and 1000, change in your `.env` file.
- Run the follow command to move all files to your USER_ID and GROUP_ID:
  ```bash
  sudo chown -R $USER:$USER volumes/php
  ```