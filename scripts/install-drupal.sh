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

# ✅ Allow all required Composer plugins globally
composer config --no-plugins allow-plugins \
  "composer/installers" true \
  "civicrm/composer-compile-plugin" true \
  "civicrm/composer-downloads-plugin" true \
  "cweagans/composer-patches" true \
  "civicrm/civicrm-asset-plugin" true \
  "drupal/core-composer-scaffold" true \
  "drupal/core-project-message" true \
  "zaporylie/composer-drupal-optimizations" true

# 🛠️ Enable patching and Drupal scaffolding behavior
composer config extra.enable-patching true
composer config extra.drupal-scaffold-destination "web"
composer config extra.drupal-scaffold-allow-empty true
composer config extra.drupal-scaffold-allow-unsafe true


mkdir -p web/sites/default/files
chmod -R 755 web/sites/default
cp web/sites/default/default.settings.php web/sites/default/settings.php

# Use SQLite for quick setup (or adjust for MySQL)
echo "\$databases['default']['default'] = [
  'driver' => 'sqlite',
  'database' => '/tmp/site.sqlite',
];" >> web/sites/default/settings.php

echo "✅ Drupal installed in $CMS_DIR/"
