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

# Enable patching via composer.json
composer config extra.enable-patching true

# Require CiviCRM packages (core, packages, drupal integration)
composer require civicrm/civicrm-core civicrm/civicrm-packages civicrm/civicrm-drupal-8

# Optional: install CLI tools for useful commands like `civix` or `cv`
composer require civicrm/cli-tools

echo "✅ CiviCRM packages installed into $CMS_DIR/"
