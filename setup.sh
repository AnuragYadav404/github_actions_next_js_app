#!/bin/bash
set -e  # exit if any command fails

APP_DIR="/var/www/myapp"

echo "🚀 Starting deployment..."

cd $APP_DIR

# Pull latest code
git pull origin main

# Install only production dependencies
npm install --production

# Build the Next.js app
npm run build

# Restart the app with PM2 (or start if not running yet)
pm2 restart nextapp || pm2 start npm --name "nextapp" -- run start

echo "✅ Deployment complete!"