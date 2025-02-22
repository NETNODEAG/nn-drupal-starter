#!/usr/bin/env bash

echo "DEPLOYMENT START" | toilet --meta --filter border -t

set -e

echo $PATH

cp -n .env.example .env

mkdir -p volumes
mkdir -p volumes/mariadb
mkdir -p volumes/solr

# start container
docker compose up -d --build

# run composer
docker compose exec drupal sh -c 'composer install --no-dev --no-interaction'

rm -f ./web/sites/default/settings.php
ln ./nn/docker/settings.docker.php ./web/sites/default/settings.php
ln -f ./nn/docker/.htaccess ./web/.htaccess

#docker compose exec drupal sh -c 'drush si -y'
#docker compose exec drupal sh -c 'drush cr'
echo "Open your traefik on http://localhost:8080/dashboard/#/http/routers and look for your new site"
echo "DEPLOYMENT FINISHED" | toilet --meta --filter border -t
