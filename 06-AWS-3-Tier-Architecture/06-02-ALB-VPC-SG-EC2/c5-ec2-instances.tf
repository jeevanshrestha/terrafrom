# Jumpbox Instance
module "jumpbox" {

  depends_on = [module.jeeves_vpc]
  source     = "terraform-aws-modules/ec2-instance/aws"
  version    = "~> 5.0"

  name = "jumpbox-instance"

  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  key_name               = var.instance_keypair
  monitoring             = true
  vpc_security_group_ids = [module.jeeves_sg_jumpbox.security_group_id]
  subnet_id              = module.jeeves_vpc.public_subnets[0]

  # Public IP configuration
  associate_public_ip_address = true

  tags = {
    Role = "jumpbox"
  }
}

# Web Server Instance
module "web" {
  depends_on = [module.jeeves_vpc]

  source   = "terraform-aws-modules/ec2-instance/aws"
  version  = "~> 5.0"
  for_each =  var.instance_type_map 
  name     = "web-instance-${each.key}"

  ami                    = data.aws_ami.ubuntu.id
  instance_type          = each.value
  key_name               = var.instance_keypair
  monitoring             = true
  vpc_security_group_ids = [module.jeeves_sg_web.security_group_id]
  subnet_id              = module.jeeves_vpc.private_subnets[0]

  # Private IP configuration
  associate_public_ip_address = false

  # User data for Nginx installation
  user_data                   = <<-EOF
      #! /bin/bash
      sudo apt-get update
      sudo apt-get install -y nginx
      sudo systemctl start nginx
      sudo systemctl enable nginx
      echo "Nginx installed and started successfully."
      # Create a simple HTML file to serve
      echo "<html><body><h1>Nginx is running! Environment : ${each.key} </h1><p>IP_ADDRESS=$(hostname -I | awk '{print $1}')</p></body></html>" | sudo tee /var/www/html/index.html > /dev/null
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
    EOF
  user_data_replace_on_change = true

  tags = {
    Name        = "web-instance-${each.key}"
    Type        = "web-server.${each.value}"
    Environment = each.key
    Role        = "web-server"
  }
}

# Database Instance
module "db" {

  depends_on = [module.jeeves_vpc]
  source     = "terraform-aws-modules/ec2-instance/aws"
  version    = "~> 5.0"

  name = "db-instance"

  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  key_name               = var.instance_keypair
  monitoring             = true
  vpc_security_group_ids = [module.jeeves_sg_db.security_group_id]
  subnet_id              = module.jeeves_vpc.database_subnets[0]

  # Private IP configuration
  associate_public_ip_address = false

  # User data for MySQL installation

  user_data                   = <<-EOF
      #!/bin/bash

# Update package index
sudo apt-get update

# Install MySQL Server without password prompt
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y mysql-server

# Set root password to empty (no password)
sudo mysql -u root  
ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '';
FLUSH PRIVILEGES;
 

# Allow remote root login with no password (optional, not recommended for production)
# sudo mysql -u root 
# ALTER USER 'root'@'%' IDENTIFIED WITH mysql_native_password BY '';
# FLUSH PRIVILEGES;
 
# Enable and start MySQL service
sudo systemctl enable mysql
sudo systemctl start mysql
      EOF
  user_data_replace_on_change = true

  tags = {
    Role = "database"
  }
}