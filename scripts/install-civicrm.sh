#!/bin/bash
set -e

CMS=$1
CMS_DIR="$CMS"

echo "🚀 Installing CiviCRM into $CMS..."

# 1. Ensure the Drupal project folder exists
if [ ! -d "$CMS_DIR" ]; then
  echo "❌ Directory $CMS_DIR does not exist"
  exit 1
fi

cd "$CMS_DIR"

# 2. Avoid interactive compile plugin prompts in CI
composer config extra.compile-mode whitelist
composer config extra.compile-whitelist.0 civicrm/civicrm-core
composer config extra.compile-whitelist.1 civicrm/composer-compile-lib
export COMPOSER_COMPILE='whitelist'

# 3. Enable required Composer plugins
composer config --no-plugins allow-plugins.composer/installers true
composer config --no-plugins allow-plugins.civicrm/composer-compile-plugin true
composer config --no-plugins allow-plugins.civicrm/composer-downloads-plugin true
composer config --no-plugins allow-plugins.cweagans/composer-patches true
composer config --no-plugins allow-plugins.civicrm/civicrm-asset-plugin true
composer config --no-plugins allow-plugins.drupal/core-composer-scaffold true
composer config --no-plugins allow-plugins.drupal/core-project-message true
composer config --no-plugins allow-plugins.zaporylie/composer-drupal-optimizations true

# 4. Optional: Enable patching and Drupal scaffold behavior
composer config extra.enable-patching true
composer config extra.drupal-scaffold-destination "web"
composer config extra.drupal-scaffold-allow-empty true
composer config extra.drupal-scaffold-allow-unsafe true

# 5. Install CiviCRM packages
composer require civicrm/civicrm-core civicrm/civicrm-packages civicrm/civicrm-drupal-8

# 6. Optional but useful: install CLI tools like `cv`
composer require civicrm/cli-tools

# 7. Enable CiviCRM module in Drupal (skip if already enabled)
./vendor/bin/drush en -y civicrm

# 8. Install CiviCRM using `cv` if available
if command -v ./vendor/bin/cv >/dev/null 2>&1; then
  ./vendor/bin/cv core:install -m loadGenerated -L
fi

echo "✅ CiviCRM installed and enabled into $CMS_DIR/"
