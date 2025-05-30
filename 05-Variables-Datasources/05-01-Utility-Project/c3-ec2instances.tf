
resource "aws_instance" "my-ec2-vm" {

  #  for_each = toset(keys(var.instance_type_map)) # Use for_each to create multiple instances for each environment

  for_each = toset(keys({ for az, t in data.aws_ec2_instance_type_offerings.t3_micro_available_all : 
  az => t.instance_types if length(t.instance_types) != 0 })) # Use for_each to create multiple instances in each availability zone
  # Removed unsupported instance_name attribute; use Name tag below to differentiate instances
  #count = 3       
  ami           = data.aws_ami.latest_amazon_linux.id # Example AMI ID, replace with a valid one
  instance_type = var.instance_type                   # Use the variable for instance type
  #instance_type          = var.instance_type_map["${each.value}"]                               # Use the variable for instance type
  availability_zone = each.value # Distribute instances across availability zones       

  key_name  = "Terra-Key" #Replace with your key pair name for SSH access
  user_data = <<-EOF
      #! /bin/bash
      sudo yum update -y
      sudo yum install -y httpd
      sudo systemctl start httpd
      sudo systemctl enable httpd
      echo "<html><body><h1>Apache is running! Created in Availability zone : ${each.value} </h1></body></html>" | sudo tee /var/www/html/index.html > /dev/null
      sudo systemctl restart httpd 
      sudo systemctl status httpd | grep "active (running)" > /dev/null
      if [ $? -eq 0 ]; then
          echo "Apache service is running."
      else
          echo "Apache service failed to start."
      fi
      IP_ADDRESS=$(hostname -I | awk '{print $1}')
      echo "You can access Apache at http://$IP_ADDRESS"
      EOF
  tags = {

    Name               = "my-ec2-vm-${each.value} " # Use each.value to differentiate instances 
    "tag1"             = "${each.value}-web"
    "AvailabilityZone" = each.value
  }

}