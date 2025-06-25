#!/bin/bash
set -e
git clone https://github.com/${EXT_REPO}.git ext
# Copy it to the CMS extension dir
if [ -d web ]; then
  cp -r ext /var/www/html/web/modules/contrib/eventcalendar
elif [ -d wp ]; then
  cp -r ext /var/www/html/wp/wp-content/plugins/eventcalendar
fi
# Run install commands: drush or WP-CLI to enable
