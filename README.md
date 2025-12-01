# Kimai Docker

[Kimai](https://github.com/kimai/kimai) runing in a container

Purpose of this project: expose the source code of Kimai in a volume

## Setup

* Clone this repository
* run `docker-compose up`

## Development

Look [here](docs/development.md)

## Update

* Go to the kimai folder
  * Check the base image version
    ```bash
    cat .docker/php/Dockerfile | grep FROM
    cat .env | grep VERSION
    ```
  * Update the container
    ```bash
    # replace with the newest base image
    docker compose build --pull
    ```
* Go to the kimai volume folder
  ```bash
  git pull origin main
  cd volumes/php
  git fetch origin <latest-tag-in-prod>
  git checkout FETCH_HEAD
  git checkout -b <latest-tag-in-prod>
  docker compose exec kimai composer i --no-dev
  docker compose exec kimai chown -R www-data:www-data .
  docker compose restart kimai
  ```
