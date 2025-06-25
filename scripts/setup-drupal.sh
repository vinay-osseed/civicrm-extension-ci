#!/bin/bash
set -e
echo "📥 Installing Drupal..."
curl -L https://www.drupal.org/download-latest/tar.gz | tar zx
mv drupal-* drupal
cd drupal
composer require drush/drush
vendor/bin/drush site:install standard --db-url=mysql://root:root@127.0.0.1/civicrm --yes --account-pass=admin
cd ..
