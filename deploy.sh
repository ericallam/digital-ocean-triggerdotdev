#!/bin/bash
npm run build

# The hostname or IP address of your DigitalOcean droplet
DROPLET_HOST="104.248.112.122"

# The username to use for SSH access to the droplet
DROPLET_USER="root"

# The local path to your Node.js service code
LOCAL_PATH="."

# The remote path to copy your code to on the droplet
REMOTE_PATH="~/services/digital-ocean-sample"

# Use rsync to copy the code to the droplet

# only rsync package.json, package-lock.json, and ./dist
rsync -avz -e "ssh -i ~/.ssh/id_rsa -o StrictHostKeyChecking=no" "$LOCAL_PATH/package.json" "$DROPLET_USER@$DROPLET_HOST:$REMOTE_PATH/package.json"
rsync -avz -e "ssh -i ~/.ssh/id_rsa -o StrictHostKeyChecking=no" "$LOCAL_PATH/package-lock.json" "$DROPLET_USER@$DROPLET_HOST:$REMOTE_PATH/package-lock.json"
rsync -avz -e "ssh -i ~/.ssh/id_rsa -o StrictHostKeyChecking=no" "$LOCAL_PATH/Makefile" "$DROPLET_USER@$DROPLET_HOST:$REMOTE_PATH/Makefile"
rsync -avz -e "ssh -i ~/.ssh/id_rsa -o StrictHostKeyChecking=no" "$LOCAL_PATH/dist" "$DROPLET_USER@$DROPLET_HOST:$REMOTE_PATH"


