#!/bin/bash
# mysql-install.sh - Install MySQL Server on Amazon Linux 2

set -e

# Update package index
sudo yum update -y

# Install the MySQL 8.0 Community repository
sudo rpm -Uvh https://repo.mysql.com/mysql80-community-release-el7-5.noarch.rpm

# Enable MySQL 8.0 repository
sudo yum-config-manager --enable mysql80-community

# Install MySQL server
sudo yum install -y mysql-community-server

# Start MySQL service
sudo systemctl start mysqld

# Enable MySQL to start on boot
sudo systemctl enable mysqld

# Print temporary root password
echo "Temporary MySQL root password:"
sudo grep 'temporary password' /var/log/mysqld.log

# Get the temporary root password
TEMP_PASS=$(sudo grep 'temporary password' /var/log/mysqld.log | awk '{print $NF}')

# Create SQL script to allow root login without password
cat <<EOF > /tmp/mysql_secure_installation.sql
ALTER USER 'root'@'localhost' IDENTIFIED BY '';
FLUSH PRIVILEGES;
EOF

# Run the SQL script using the temporary password
sudo mysql --connect-expired-password -u root -p"$TEMP_PASS" < /tmp/mysql_secure_installation.sql

# Allow root login from any host without password (not recommended for production)
sudo mysql -u root --execute="ALTER USER 'root'@'%' IDENTIFIED BY ''; FLUSH PRIVILEGES;"

echo "MySQL installation completed."