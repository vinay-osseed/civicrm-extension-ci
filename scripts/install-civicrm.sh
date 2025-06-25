#!/bin/bash
set -e

CMS="$1"
echo "🚀 Installing CiviCRM into $CMS"

if [ "$CMS" = "drupal" ]; then
  cd drupal
  composer require civicrm/civicrm-core civicrm/civicrm-drupal-8
  vendor/bin/drush en civicrm -y
  vendor/bin/drush civicrm-upgrade-db -y
  cd ..
elif [ "$CMS" = "wordpress" ]; then
  cd wp
  curl -L https://civicrm.org/downloads/civicrm-latest-wordpress.tar.gz | tar zx
  mkdir -p wp-content/plugins/civicrm
  mv civicrm/* wp-content/plugins/civicrm/
  wp core install --url="http://localhost" --title="WP Test" --admin_user=admin --admin_password=admin --admin_email=admin@example.com
  wp plugin activate civicrm
  wp civicrm upgrade-db --yes || true
  cd ..
else
  echo "❌ Unknown CMS: $CMS" && exit 1
fi
