#Resource Block
# VPC Resource Block
resource "aws_vpc" "vpc-dev" {
  cidr_block = "10.0.0/16"
  tags = {
    Name = "vpc-dev"
  }
}

#Resource-2 Create Subnets
resource "aws_subnet" "vpc-dev-public-subnet-1" {
  vpc_id                  = aws_vpc.vpc-dev.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "ap-southeast-2a"
#  depends_on = [ aws_vpc.vpc ] # Dependency on VPC creation
  map_public_ip_on_launch = true
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


