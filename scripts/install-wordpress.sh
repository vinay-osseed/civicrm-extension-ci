#!/bin/bash
set -e
echo "📥 Installing WordPress..."
curl -O https://wordpress.org/latest.tar.gz
tar xzf latest.tar.gz
mv wordpress wp
cd wp
cp wp-config-sample.php wp-config.php
sed -i "s/database_name_here/civicrm/" wp-config.php
sed -i "s/username_here/root/" wp-config.php
sed -i "s/password_here/root/" wp-config.php
sed -i "s/localhost/127.0.0.1/" wp-config.php
cd ..
# WordPress install via WP-CLI will happen after CiviCRM
