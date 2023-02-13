#!/usr/bin/env bash

set -e

echo $PATH

docker compose up -d --build

echo "DEPLOYMENT START" | toilet --meta --filter border -t

#rm -f ./docroot/sites/default/default.services.yml
#rm -f ./docroot/themes/custom/godigital/yarn.lock
#rm -f ./docroot/sites/default/default.settings.php

# make db dump
#echo "RUN: Backup Database" | toilet -f term -F border --meta
#drush sql-dump --structure-tables-list=cache,cache_*,search_index,watchdog --result-file=auto --gzip
#echo "Backup Database -> DONE" | toilet -f term -F border --meta

# run git pull
#echo "RUN: git pull" | toilet -f term -F border --meta
#rm ./docroot/themes/custom/godigital/yarn.lock || true
#git pull -v
#echo "RUNNING git pull -> DONE" | toilet -f term -F border --meta

# copy files
#echo "RUN: Backup Database" | toilet -f term -F border --meta
rm ./web/sites/default/settings.php || true
ln ./nn/docker/settings.docker.php ./web/sites/default/settings.php

ln -f ./nn/docker/.htaccess ./web/.htaccess




# run composer
echo "RUN: composer install" |toilet -f term -F border --meta
#rm -rf vendor
docker compose exec drupal sh -c 'composer install --no-dev --no-interaction'
#git status
echo "composer install -> DONE" | toilet -f term -F border --meta

# Sync db from prod
#composer nn-docker-sync-db-prod
#docker compose exec drupal sh -c 'drush sql:sync @cloud.prod @self'

# run db updb
echo "RUN: drush updb|cim" | toilet -f term -F border --meta
docker compose exec drupal sh -c 'drush updb -y'
docker compose exec drupal sh -c 'drush cim -y'
echo "RUNNING drush updb|cim –> DONE" | toilet -f term -F border --meta

# Build theme
echo "RUN: Build Drupal theme" | toilet -f term -F border --meta
docker run --rm -v "$PWD/docroot/themes/custom/godigital":/app -w /app node:16 npm install
docker run --rm -v "$PWD/docroot/themes/custom/godigital":/app -w /app node:16 npm run build
echo "Build Drupal theme –> DONE" | toilet -f term -F border --meta

# File permissions
#echo "Set correct file permissions" | toilet -f term -F border --meta
#chown netnode:www-data -R ./docroot
#chown netnode:www-data -R ./docroot/sites/default/files
#find docroot/sites/default/files -type f -exec chmod u=rw,g=rw,o= '{}' \;
#find docroot/sites/default/files -type d -exec chmod u=rwx,g=rwx,o= '{}' \;
#chmod 775 ./docroot/sites/default/files

#chmod 644 docroot/sites/default/settings.local.php');
#chmod 755 ./docroot/sites/default
#chmod +w ./docroot/sites/default
#find ./docroot/sites/default -name "*settings.php" -exec chmod 644 {} \;
#find ./docroot/sites/default -name "*services.yml" -exec chmod 644 {} \;
docker compose exec drupal sh -c 'drush cr'
echo "DEPLOYMENT FINISHED" | toilet --meta --filter border -t


