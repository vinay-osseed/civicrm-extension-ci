#!/bin/bash
set -e

EXT_PATH=$1
CMS_TYPE=${CMS_TYPE:-drupal}
CIVI_EXT_DIR=""

echo "📦 Linking extension from $EXT_PATH to CMS type: $CMS_TYPE"

case "$CMS_TYPE" in
  drupal)
    CIVI_EXT_DIR="/var/www/html/web/sites/default/files/civicrm/ext"
    ;;
  wordpress)
    CIVI_EXT_DIR="/var/www/html/wp-content/uploads/civicrm/ext"
    ;;
  *)
    echo "❌ Unknown CMS type: $CMS_TYPE"
    exit 1
    ;;
esac

mkdir -p "$CIVI_EXT_DIR"

EXT_BASENAME=$(basename "$EXT_PATH")
TARGET="$CIVI_EXT_DIR/$EXT_BASENAME"

if [ -L "$TARGET" ] || [ -d "$TARGET" ]; then
  echo "🔁 Removing existing extension at $TARGET"
  rm -rf "$TARGET"
fi

echo "🔗 Symlinking extension to $TARGET"
ln -s "$EXT_PATH" "$TARGET"
