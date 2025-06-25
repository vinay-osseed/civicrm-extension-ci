#!/bin/bash
set -e
echo "🔧 Installing Drupal CMS..."

# Variables
CMS_DIR="drupal"
CMS_VERSION="10.5.0"  # or latest

# Install composer project
composer create-project drupal/recommended-project $CMS_DIR "^$CMS_VERSION"
composer config --no-plugins allow-plugins.cweagans/composer-patches true

# Adjust permissions
cd $CMS_DIR
mkdir -p web/sites/default/files
chmod -R 755 web/sites/default
cp web/sites/default/default.settings.php web/sites/default/settings.php

# Use SQLite for quick setup (or adjust for MySQL)
echo "\$databases['default']['default'] = [
  'driver' => 'sqlite',
  'database' => '/tmp/site.sqlite',
];" >> web/sites/default/settings.php

echo "✅ Drupal installed in $CMS_DIR/"
