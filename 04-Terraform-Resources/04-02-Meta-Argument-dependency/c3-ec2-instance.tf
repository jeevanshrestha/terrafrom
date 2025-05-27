resource "aws_instance" "my-ec2-vm" {
  ami                    = "ami-0f5d1713c9af4fe30" # Example AMI ID, replace with a valid one
  instance_type          = "t2.micro"
  availability_zone      = "ap-southeast-2a"                         # Specify the availability zone
  subnet_id              = aws_subnet.vpc-dev-public-subnet-1.id     # Associate the instance with the public subnet  
  vpc_security_group_ids = [aws_security_group.vpc-dev-public-sg.id] # Associate the security group
  #user_data = file("nginx-install.sh") # Optional: User data script for instance initialization
  key_name              = "Terraform-Key" # Replace with your key pair name for SSH access
  user_data = <<-EOF
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
    EOF
  tags = {
    Name               = "My-EC2-VM"
    "tag1"             = "Update-test-1"
    "AvailabilityZone" = "ap-southeast-2a"
    "VPC"              = aws_vpc.vpc-dev.id
    "Subnet"           = aws_subnet.vpc-dev-public-subnet-1.id
    "SecurityGroup"    = aws_security_group.vpc-dev-public-sg.id

  }

}