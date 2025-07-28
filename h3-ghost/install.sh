#!/bin/bash

set -e

echo "=== Ghost Configuration on Infomaniak ==="

read -rp "Full URL (e.g. https://blog.monsite.com): " SITE_URL
read -rp "Site name (e.g. blog.monsite.com): " SITE_DIR

read -rp "Database host: " DB_HOST
read -rp "Database name: " DB_NAME
read -rp "Database user: " DB_USER
read -srp "Database password: " DB_PASS && echo

read -rp "Sender email address (from): " EMAIL_FROM
read -rp "SMTP username: " EMAIL_USER
read -srp "SMTP password: " EMAIL_PASS && echo

echo "=== Installation in progress, please wait... ==="

cd "/srv/customer/sites/$SITE_DIR" || { echo "❌ Failed to change directory to /srv/customer/sites/$SITE_DIR. Exiting."; exit 1; }
echo "⚠️ WARNING: This will delete all files in /srv/customer/sites/$SITE_DIR. Do you want to proceed? (yes/no)"
read -r CONFIRM
if [ "$CONFIRM" != "yes" ]; then
  echo "❌ Operation canceled by the user. Exiting."
  exit 1
fi

rm -rf ./*

cd ~/
npm install ghost-cli

CLI_PATH="./node_modules/ghost-cli/lib/tasks/yarn-install.js"
if grep -q "YARN_IGNORE_PATH" "$CLI_PATH"; then
  sed -i "s/env: {NODE_ENV: 'production', YARN_IGNORE_PATH: 'true'}/env: {NODE_ENV: 'production', YARN_IGNORE_PATH: 'true', NODE_OPTIONS: '--max-old-space-size=512'}/" "$CLI_PATH"
  echo "✅ ghost-cli locally patched with RAM limit"
fi

cd "/srv/customer/sites/$SITE_DIR"

~/node_modules/.bin/ghost install \
  --check-empty=false \
  --url "$SITE_URL" \
  --port "3000" \
  --ip "0.0.0.0" \
  --db mysql \
  --dbhost "$DB_HOST" \
  --dbuser "$DB_USER" \
  --dbpass "$DB_PASS" \
  --dbname "$DB_NAME" \
  --no-prompt \
  --no-setup-linux-user \
  --no-setup-systemd \
  --no-start


echo "🔧 Updating email configuration in config.production.json..."
CONFIG_FILE="/srv/customer/sites/$SITE_DIR/config.production.json"

jq --arg user "$EMAIL_USER" \
   --arg pass "$EMAIL_PASS" \
   --arg from "$EMAIL_FROM" \
   '.mail = {
      "transport": "SMTP",
      "options": {
        "service": "Infomaniak",
        "host": "mail.infomaniak.com",
        "port": 465,
        "auth": {
          "user": $user,
          "pass": $pass
        }
      },
      "from": $from
    }' "$CONFIG_FILE" > "$CONFIG_FILE.tmp" && mv "$CONFIG_FILE.tmp" "$CONFIG_FILE"

echo ""
echo "✅ Configuration completed"

echo ""
echo "🛠️ Go to your Infomaniak dashboard and configure:"
echo "   ➤ Node.js command: ~/node_modules/ghost-cli/bin/ghost run"
echo "   ➤ Click 'Start' to launch the application"
echo ""
echo "🌍 Access the admin: $SITE_URL/ghost"
echo "🎉 Ghost is installed and ready to use!"
