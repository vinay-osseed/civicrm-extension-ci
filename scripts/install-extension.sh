#!/bin/bash
set -e

CMS=$1
CMS_DIR="$CMS"

echo "🚀 Installing CiviCRM Extension into $CMS..."

# Go to extension directory
cd "$CMS_DIR"
EXT_DIR=$(./vendor/bin/cv ev 'echo \Civi::paths()->getPath("[civicrm.files]/ext", TRUE);')
echo "📂 CiviCRM extension dir is: $EXT_DIR"
cd "$EXT_DIR"

# Make sure EXTENSION_REPO_PAT is set
if [ -z "$EXTENSION_REPO_PAT" ]; then
  echo "❌ EXTENSION_REPO_PAT is not set!"
  exit 1
fi

# Clone using the token (HTTPS)
git clone "https://x-access-token:${EXTENSION_REPO_PAT}@github.com/vinugawade/com.osseed.eventcalendar.git" com.osseed.eventcalendar

echo "✅ Extension installed in: $EXT_DIR/com.osseed.eventcalendar"
