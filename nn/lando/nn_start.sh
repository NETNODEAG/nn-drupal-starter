#!/usr/bin/env bash

# php and composer
php ./nn/lando/check_requirements.php
composer self-update --2

# create .env file
cp .env.lando .env

# run composer
composer install

# setup drupal secific files
rm web/sites/default/settings.php
ln ./nn/lando/settings.lando.php web/sites/default/settings.php

rm web/sites/development.services.yml
ln ./nn/lando/development.services.yml web/sites/development.services.yml

rm web/.htaccess
ln ./nn/lando/.htaccess web/.htaccess

# lando + db sync
# lando destroy -y
lando start
#. ./nn/lando/nn_sync_db_prod.sh
#. ./nn/lando/nn_build_frontend.sh

# finish
lando drush cr
open http://nn-drupal-starter.ch.lndo.site/
