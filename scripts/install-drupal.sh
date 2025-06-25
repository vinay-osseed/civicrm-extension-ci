#!/bin/bash
set -e
echo "🔧 Installing Drupal CMS..."

# Variables
CMS_DIR="drupal"
CMS_VERSION="10.5.0"  # or latest

# Install composer project
composer create-project drupal/recommended-project $CMS_DIR "^$CMS_VERSION"

# Adjust permissions
cd $CMS_DIR

# Set up Composer to allow necessary plugins
composer config --no-plugins allow-plugins.'composer/installers' true \
  allow-plugins.'civicrm/composer-compile-plugin' true \
  allow-plugins.'civicrm/composer-downloads-plugin' true \
  allow-plugins.'cweagans/composer-patches' true \
  allow-plugins.'civicrm/civicrm-asset-plugin' true \
  allow-plugins.'drupal/core-composer-scaffold' true \
  allow-plugins.'drupal/core-project-message' true \
  allow-plugins.'zaporylie/composer-drupal-optimizations' true

mkdir -p web/sites/default/files
chmod -R 755 web/sites/default
cp web/sites/default/default.settings.php web/sites/default/settings.php

# Use SQLite for quick setup (or adjust for MySQL)
echo "\$databases['default']['default'] = [
  'driver' => 'sqlite',
  'database' => '/tmp/site.sqlite',
];" >> web/sites/default/settings.php

echo "✅ Drupal installed in $CMS_DIR/"
