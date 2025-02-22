#composer require drupal/dotenv
#vendor/drush/drush/drush en dotenv -y

composer require drupal/gin

vendor/drush/drush/drush theme:enable gin
vendor/drush/drush/drush config-set system.theme admin gin -y
vendor/drush/drush/drush config-set gin.settings classic_toolbar horizontal -y
vendor/drush/drush/drush config-set user.settings register admin_only -y

composer require drupal/gin_toolbar
vendor/drush/drush/drush en gin_toolbar -y

composer require drupal/gin_login
vendor/drush/drush/drush en gin_login -y