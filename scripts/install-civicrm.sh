#!/bin/bash
set -e

CMS=$1
CMS_DIR="$CMS"

echo "🚀 Installing CiviCRM into $CMS..."

# Make sure the Drupal directory exists
if [ ! -d "$CMS_DIR" ]; then
  echo "❌ Directory $CMS_DIR does not exist"
  exit 1
fi

cd "$CMS_DIR"

# ✅ Allow required Composer plugins
composer config --no-plugins allow-plugins.composer/installers true
composer config --no-plugins allow-plugins.civicrm/composer-compile-plugin true
composer config --no-plugins allow-plugins.civicrm/composer-downloads-plugin true
composer config --no-plugins allow-plugins.cweagans/composer-patches true
composer config --no-plugins allow-plugins.civicrm/civicrm-asset-plugin true
composer config --no-plugins allow-plugins.drupal/core-composer-scaffold true
composer config --no-plugins allow-plugins.drupal/core-project-message true
composer config --no-plugins allow-plugins.zaporylie/composer-drupal-optimizations true

# 🛠️ Enable patching and scaffold settings
composer config extra.enable-patching true
composer config extra.drupal-scaffold-destination "web"
composer config extra.drupal-scaffold-allow-empty true
composer config extra.drupal-scaffold-allow-unsafe true

# Set compile plugin config to avoid prompts
composer config extra.compile-mode whitelist
composer config extra.compile-whitelist.0 civicrm/civicrm-core
composer config extra.compile-whitelist.1 civicrm/composer-compile-lib


# 📦 Install CiviCRM and CLI tools
export COMPOSER_COMPILE=0
composer require civicrm/civicrm-core civicrm/civicrm-packages civicrm/civicrm-drupal-8
composer require civicrm/cli-tools

echo "✅ CiviCRM installed successfully in $CMS_DIR/"
