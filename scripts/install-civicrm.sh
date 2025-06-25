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

# Require CiviCRM packages (core, packages, drupal integration)
composer require civicrm/civicrm-core civicrm/civicrm-packages civicrm/civicrm-drupal-8

# Optional: install CLI tools for useful commands like `civix` or `cv`
composer require civicrm/cli-tools

echo "✅ CiviCRM packages installed into $CMS_DIR/"
