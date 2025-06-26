#!/bin/bash
set -e

echo "🔧 Installing Drupal CMS..."

# Variables
CMS_DIR="drupal"
CMS_VERSION="10.5.0"  # or latest
SITE_NAME="Test Drupal Site"
ADMIN_USER="admin"
ADMIN_PASS="admin"
ADMIN_EMAIL="admin@example.com"

# Install Drupal using Composer
composer create-project drupal/recommended-project "$CMS_DIR" "^$CMS_VERSION"

# Change into Drupal dir
cd "$CMS_DIR"

# Adjust file permissions
mkdir -p web/sites/default/files
chmod -R 755 web/sites/default
cp web/sites/default/default.settings.php web/sites/default/settings.php

# Configure SQLite DB
echo "\$databases['default']['default'] = [
  'driver' => 'sqlite',
  'database' => '/tmp/site.sqlite',
];" >> web/sites/default/settings.php

# Install Drush
composer require drush/drush drupal/admin_toolbar

# Run site install using Drush
./vendor/bin/drush site:install standard \
  --account-name="$ADMIN_USER" \
  --account-pass="$ADMIN_PASS" \
  --account-mail="$ADMIN_EMAIL" \
  --site-name="$SITE_NAME" \
  --yes

# Enable useful modules
./vendor/bin/drush en -y admin_toolbar

echo "✅ Drupal installed in $CMS_DIR/ using SQLite and configured."
