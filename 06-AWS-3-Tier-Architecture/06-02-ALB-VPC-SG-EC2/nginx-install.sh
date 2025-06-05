#!/bin/bash

# Update package list and install nginx
sudo apt-get update -y
sudo apt-get install -y nginx

# Enable and start nginx service
sudo systemctl enable nginx
sudo systemctl start nginx

# Create a sample index.html file
cat <<EOF | sudo tee /var/www/html/index.html
<!DOCTYPE html>
<html>
<head>
    <title>Welcome to Nginx on Ubuntu!</title>
</head>
<body>
    <h1>Success! Nginx is installed and running.</h1>
    <p>This is a sample index.html page served by Nginx.</p>
     
</body>
</html>
EOF