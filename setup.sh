#!/bin/bash
set -e  # exit if any command fails

APP_DIR="/var/www/myapp"
REPO="https://github.com/AnuragYadav404/github_actions_next_js_app.git"

echo "🚀 Starting deployment..."

export PATH=$HOME/.nvm/versions/node/v22.18.0/bin:$PATH

# Clone or pull repository
if [ ! -d "$APP_DIR/.git" ]; then
    echo "Repository not found. Cloning..."
    git clone $REPO $APP_DIR
else
    echo "Repository exists. Pulling latest changes..."
    cd $APP_DIR
    git reset --hard          # Discard any local changes
    git checkout main         # Ensure we're on main branch
    git pull origin main
fi

cd $APP_DIR

# Install only production dependencies
npm install --production

# Build the Next.js app
npm run build

# Restart the app with PM2 (or start if not running yet)
pm2 restart nextapp || pm2 start npm --name "nextapp" -- run start

echo "✅ Deployment complete!"