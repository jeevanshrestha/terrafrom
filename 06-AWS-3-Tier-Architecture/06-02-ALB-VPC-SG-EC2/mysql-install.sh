#!/bin/bash

# Update package index
sudo apt-get update

# Install MySQL Server without password prompt
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y mysql-server

# Set root password to empty (no password)
sudo mysql -u root <<EOF
ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '';
FLUSH PRIVILEGES;
EOF

# Allow remote root login with no password (optional, not recommended for production)
# sudo mysql -u root <<EOF
# ALTER USER 'root'@'%' IDENTIFIED WITH mysql_native_password BY '';
# FLUSH PRIVILEGES;
# EOF

# Enable and start MySQL service
sudo systemctl enable mysql
sudo systemctl start mysql