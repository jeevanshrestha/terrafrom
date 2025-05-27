#! /bin/bash
sudo apt-get update
sudo apt-get install -y nginx
sudo systemctl start nginx
sudo systemctl enable nginx
echo "Nginx installed and started successfully."
# Create a simple HTML file to serve
echo "<html><body><h1>Nginx is running! Created in Availability zone :  ap-southeast-2a </h1></body></html>" | sudo tee /var/www/html/index.html > /dev/null
# Ensure the Nginx service is running
sudo systemctl restart nginx
# Check the status of the Nginx service
sudo systemctl status nginx | grep "active (running)" > /dev/null
if [ $? -eq 0 ]; then
    echo "Nginx service is running."
else
    echo "Nginx service failed to start."
fi
# Print the IP address of the server
IP_ADDRESS=$(hostname -I | awk '{print $1}')
echo "You can access Nginx at http://$IP_ADDRESS"
# Print the public IP address if available 