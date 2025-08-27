#!/bin/bash
set -e  # exit if any command fails

APP_DIR="/var/www/myapp"

echo "🚀 Starting deployment..."

cd $APP_DIR


export PATH=$HOME/.nvm/versions/node/v22.18.0/bin:$PATH

# Pull latest code
git clone "https://github.com/AnuragYadav404/github_actions_next_js_app.git"

# Install only production dependencies
npm install --production

# Build the Next.js app
npm run build

# Restart the app with PM2 (or start if not running yet)
pm2 restart nextapp || pm2 start npm --name "nextapp" -- run start

echo "✅ Deployment complete!"