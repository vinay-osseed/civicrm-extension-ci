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

# Change to the CMS directory
cd "$CMS_DIR"
ls .
EXT_DIR=$(./vendor/bin/cv ev 'echo \Civi::paths()->getPath("[civicrm.files]/ext", TRUE);')
echo "📂 CiviCRM extension dir is: $EXT_DIR"
cd "$EXT_DIR"

# Clone the CiviCRM Event Calendar extension  
git clone git@github.com:vinugawade/com.osseed.eventcalendar.git com.osseed.eventcalendar