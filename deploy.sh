#!/bin/bash

# Stop the script if any command fails
set -e

# Update the system and install dependencies
sudo apt update
sudo apt install -y python3-pip python3-venv nodejs npm nginx git

# Define the repository directory
REPO_DIR="/home/ubuntu/fullstackreactapp"

# Remove the repository directory if it already exists
if [ -d "$REPO_DIR" ]; then
    sudo rm -rf "$REPO_DIR"
fi

# Clone the repository
git clone https://github.com/Rehman-AD/fullstackreactapp.git "$REPO_DIR"

# Navigate to the backend directory and set up the Django application
cd "$REPO_DIR/backend"
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt

# Create the staticfiles directory if it doesn't exist
mkdir -p /home/ubuntu/fullstackreactapp/backend/staticfiles

# Run migrations and collect static files
python manage.py migrate
python manage.py collectstatic --noinput

# Set up Gunicorn for Django
sudo cp "$REPO_DIR/backend/gunicorn.service" /etc/systemd/system/gunicorn.service
sudo systemctl daemon-reload
sudo systemctl enable gunicorn
sudo systemctl start gunicorn

# Set up Nginx for reverse proxy
sudo cp "$REPO_DIR/backend/nginx.conf" /etc/nginx/sites-available/default
sudo nginx -t
sudo systemctl restart nginx

# Navigate to the frontend directory and build the React application
cd "$REPO_DIR/new-frontend"
npm install
npm run build

# Copy the build files to the Nginx directory
sudo cp -r build/* /var/www/html/
