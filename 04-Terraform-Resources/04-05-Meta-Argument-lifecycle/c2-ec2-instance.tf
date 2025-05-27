resource "aws_instance" "my_web" {
  ami               = "ami-0f5d1713c9af4fe30" # Example AMI ID, replace with a valid one
  instance_type     = "t2.micro"
  availability_zone = "ap-southeast-2a" # Specify the availability zone
  # Create two instances 
  key_name = "Terraform-Key" # Replace with your key pair name for SSH access
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
    EOF
  tags = {
    Name   = "My-EC2-VM"
    "tag1" = "Update-test-1"
    "tag2" = "Update-test-2"
  }

  # lifecycle {
  #   create_before_destroy = true   # Ensure the new instance is created before the old one is destroyed 
  #   prevent_destroy       = true   # Prevent accidental destruction of the instance
  #   ignore_changes        = [tags] # Ignore changes to the AMI attribute, useful if you want to update the instance without changing the AMI
  # }


}