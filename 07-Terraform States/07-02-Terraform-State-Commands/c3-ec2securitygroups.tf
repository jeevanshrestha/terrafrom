
resource "aws_security_group" "vpc_ssh_sg" {
  name        = "vpc-ssh-sg"
  description = "Dev VPC SSH"

  ingress {
    description = "Allow SSH access port 22 from anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow SSH access from anywhere (not recommended for production)
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"          # Allow all outbound traffic
    cidr_blocks = ["0.0.0.0/0"] # Allow all outbound traffic
  }
}


resource "aws_security_group" "vpc_web_sg" {
  name        = "vpc-web-sg"
  description = " VPC web Security Group"

  ingress {
    description = "Allow HTTP access port 80 from anywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow SSH access from anywhere (not recommended for production)
  }

  ingress {
    description = "Allow HTTPS access port 443 from anywhere"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow SSH access from anywhere (not recommended for production)
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"          # Allow all outbound traffic
    cidr_blocks = ["0.0.0.0/0"] # Allow all outbound traffic
  }
}