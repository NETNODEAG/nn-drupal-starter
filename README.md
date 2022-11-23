```
composer create-project -s dev NETNODEAG/drupal-9-starter drupal9site --no-interaction --no-install
cd drupal9site
composer install --no-interaction
```
# For fast testing/developing use php builtin webserver and sqlite
```
cd web 
php core/scripts/drupal install standard 
php -S 127.0.0.1:8888
```

# Everything in one shot
```
composer create-project -s dev NETNODEAG/drupal-9-starter drupal9site --no-interaction --no-install && cd drupal9site && composer install --no-interaction && cd web && php core/scripts/drupal install standard && cd .. && chmod +x 1_opinionated_modules.sh && chmod +x 2_opinionated_config.sh && ./1_opinionated_modules.sh && ./2_opinionated_config.sh && cd web  && php -S 127.0.0.1:8888
```

You may want to flush after testing.
```
sudo rm -rf drupal9site
```

# 
You may use . If so, go like this:
```
mkdir mynewdrupal9site
cd mynewdrupal9site
composer create-project -s dev NETNODEAG/drupal-9-starter . --no-interaction --no-install
 init # select drupal10, set "web" as webroot
 start
 composer install --no-interaction
```

# Update drupal core with
```
composer update drupal/core 'drupal/core-*' --with-all-dependencies 
```

# More cool stuff
https://colorfield.be/blog/minimal-drupal-9-local-development-environment - hi christoph *wave* ;-)
