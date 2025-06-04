
resource "aws_instance" "web" {
  ami = data.aws_ami.amzlinux.id # Replace with a valid AMI ID for your region

  key_name                    = var.instance_keypair
  instance_type               = "t3.micro"
  subnet_id                   = module.jeeves_vpc.public_subnets[0]
  vpc_security_group_ids      = [module.jeeves_sg_web.security_group_id]
  user_data                   = file("apache-install.sh")
  monitoring                  = true
  associate_public_ip_address = true # 👈 This line is required
  tags = {
    Name = "web-instance"
  }
}


resource "aws_instance" "jumpbox" {
  ami = data.aws_ami.amzlinux.id # Replace with a valid AMI ID for your region

  key_name               = var.instance_keypair
  instance_type          = "t3.micro"
  subnet_id              = module.jeeves_vpc.private_subnets[0]
  vpc_security_group_ids = [module.jeeves_sg_jumpbox.security_group_id]
  monitoring = true
  associate_public_ip_address = false # No public IP – only accessible via Web SG or VPN

  tags = {
    Name = "jumpbox-instance"
  }
}

resource "aws_instance" "db" {
  ami = data.aws_ami.amzlinux.id # Replace with a valid AMI ID for your region

  key_name               = var.instance_keypair
  instance_type          = "t3.micro"
  subnet_id              = module.jeeves_vpc.database_subnets[0]
  vpc_security_group_ids = [module.jeeves_sg_db.security_group_id]
  associate_public_ip_address = false # No public IP – only accessible via Web SG or VPN
  # Ensure the instance is in a private subnet for database access
  user_data  = file("mysql-install.sh")
  monitoring = true

  tags = {
    Name = "db-instance"
  }
}

