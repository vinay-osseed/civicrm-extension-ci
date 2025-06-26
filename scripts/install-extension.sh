#!/bin/bash
set -e

CMS=$1
CMS_DIR="$CMS"

echo "🚀 Installing com.osseed.eventcalendar into CiviCRM($CMS)..."

# Make sure the Drupal directory exists
if [ ! -d "$CMS_DIR" ]; then
  echo "❌ Directory $CMS_DIR does not exist"
  exit 1
fi

# Change to the CMS directory
cd "$CMS_DIR"
EXT_DIR=$(./vendor/bin/cv ev 'echo \Civi::paths()->getPath("[civicrm.files]/ext", TRUE);')
echo "📂 CiviCRM extension dir is: $EXT_DIR"

# Create extension directory if it doesn't exist
mkdir -p "$EXT_DIR"
cd "$EXT_DIR"

# Clone the CiviCRM Event Calendar extension using PAT
# Make sure EXTENSION_REPO_PAT is set as a GitHub Actions secret
git clone https://x-access-token:${secrets.EXTENSION_REPO_PAT}@github.com/vinugawade/com.osseed.eventcalendar.git com.osseed.eventcalendar

./vendor/bin/cv ext:enable com.osseed.eventcalendar

echo "✅ Extension is installed."