#Resource Block
# VPC Resource Block
resource "aws_vpc" "vpc-dev" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "vpc-dev"
  }
}

#Resource-2 Create Subnets
resource "aws_subnet" "vpc-dev-public-subnet-1" {
  vpc_id            = aws_vpc.vpc-dev.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "ap-southeast-2a"
  #  depends_on = [ aws_vpc.vpc ] # Dependency on VPC creation
  map_public_ip_on_launch = true # Enable public IP assignment for instances in this subnet
  tags = {
    Name = "vpc-dev-public-subnet-1"
  }
}

#Resource-3 Create Internet Gateway
resource "aws_internet_gateway" "vpc-dev-igw" {
  vpc_id = aws_vpc.vpc-dev.id
  tags = {
    Name = "vpc-dev-igw"
  }
}

#Resource-4 Create Route Table
resource "aws_route_table" "vpc-dev-public-route-table" {
  vpc_id = aws_vpc.vpc-dev.id

  tags = {
    Name = "vpc-dev-public-route-table"
  }
}

#Resource-5 Create Route in Route Table for Internet Access 
resource "aws_route" "vpc-dev-public-route" {
  route_table_id         = aws_route_table.vpc-dev-public-route-table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.vpc-dev-igw.id
}

#Resource-6 Associate Route Table with Public Subnet
resource "aws_route_table_association" "vpc-dev-public-subnet-1-associate" {
  subnet_id      = aws_subnet.vpc-dev-public-subnet-1.id
  route_table_id = aws_route_table.vpc-dev-public-route-table.id
}

#Resource-7 Create Security Group
resource "aws_security_group" "vpc-dev-public-sg" {
  vpc_id      = aws_vpc.vpc-dev.id
  name        = "vpc-dev-public-sg"
  description = "Security group for public subnet in dev VPC"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow SSH from anywhere (not recommended for production)
    description = "Allow SSH access from anywhere"
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow HTTP from anywhere
    description = "Allow HTTP access from anywhere"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # Allow all outbound traffic
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound traffic"
  }
  tags = {
    Name = "vpc-dev-public-sg"
  }
}



