#!/bin/bash

set -e

CMS_ROOT="/var/www/html"
DRUPAL_VERSION="10.3.0"

# Download Drupal
cd /tmp
echo "⬇️ Downloading Drupal $DRUPAL_VERSION..."
curl -Lo drupal.tar.gz https://ftp.drupal.org/files/projects/drupal-${DRUPAL_VERSION}.tar.gz
tar -xzf drupal.tar.gz
sudo rm -rf ${CMS_ROOT}/*
sudo mv drupal-${DRUPAL_VERSION}/* ${CMS_ROOT}/
sudo chown -R www-data:www-data ${CMS_ROOT}

# Set basic file permissions
cd ${CMS_ROOT}
sudo mkdir -p sites/default/files
sudo cp sites/default/default.settings.php sites/default/settings.php
sudo chmod -R 755 sites/default/files
sudo chmod 644 sites/default/settings.php

# Print confirmation
echo "✅ Drupal installed at ${CMS_ROOT}"
