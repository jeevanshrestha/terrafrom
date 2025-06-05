module "jeeves_vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.21.0"

  # VPC Basic Details

  name = "jeeves-sydney-vpc"
  cidr = "10.0.0.0/16"

  azs = var.availability_zones

  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]

  # Database Subnets
  create_database_subnet_group       = true
  create_database_subnet_route_table = true
  database_subnets                   = ["10.0.151.0/24", "10.0.152.0/24"]

  #create_database_nat_gateway_route = true #(Do you want to enable internet communication via NAT Gateway for the database subnets?)
  #create_database_nat_gateway_route = false #(If you want to disable internet communication via NAT Gateway for the database subnets, set this to false)
  #create_database_internet_gateway_route = true #(Do you want to enable internet communication via Internet Gateway for the database subnets?)


  # NAT Gateways - Outbound Communication
  enable_nat_gateway = true # Enable NAT Gateway for outbound internet access for private subnets
  single_nat_gateway = true # Use a single NAT Gateway for all private subnets

  # VPC DNS Parameters
  enable_dns_hostnames = true
  enable_dns_support   = true


  # Add Ingress and Egress Rules for VPC modules

  public_subnet_tags = {
    Type = "public-subnets"
  }

  private_subnet_tags = {
    Type = "private-subnets"
  }

  database_subnet_tags = {
    Type = "database-subnets"
  }

  tags = {
    Owner       = "Jeeves"
    Environment = "dev"
  }

  vpc_tags = {
    Name = "vpc-dev"
  }

  # ✅ Create a security group in the VPC
  # Security group configuration has been removed because these attributes are not supported by the vpc module.
  # To define security groups, use the terraform-aws-modules/security-group/aws module or a separate aws_security_group resource.
}

module "jeeves_sg_alb" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.1.0"

  name        = "jeeves-alb-access"
  description = "Allow HTTP and HTTPS from internet"
  vpc_id      = module.jeeves_vpc.vpc_id

  ingress_rules       = ["http-80-tcp", "https-443-tcp"]
  ingress_cidr_blocks = ["0.0.0.0/0"]

  egress_rules = ["all-all"]

  tags = {
    Name        = "jeeves-sg-alb"
    Environment = "dev"
  }
}

module "jeeves_sg_jumpbox" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.1.0"

  name        = "jeeves-jumpbox-access"
  description = "Allow SSH from anywhere"
  vpc_id      = module.jeeves_vpc.vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["ssh-tcp"]
  egress_rules        = ["all-all"]

  tags = {
    Name        = "jeeves-sg-jumpbox"
    Environment = "dev"
  }
}


module "jeeves_sg_web" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.1.0"

  name        = "jeeves-web-access"
  description = "Allow HTTP from ALB and SSH from jumpbox"
  vpc_id      = module.jeeves_vpc.vpc_id

  ingress_with_source_security_group_id = [
    {
      from_port                = 80
      to_port                  = 80
      protocol                 = "tcp"
      description              = "HTTP from ALB"
      source_security_group_id = module.jeeves_sg_alb.security_group_id
    },
    {
      from_port                = 443
      to_port                  = 443
      protocol                 = "tcp"
      description              = "HTTPS from ALB"
      source_security_group_id = module.jeeves_sg_alb.security_group_id
    },
    {
      from_port                = 22
      to_port                  = 22
      protocol                 = "tcp"
      description              = "SSH from jumpbox"
      source_security_group_id = module.jeeves_sg_jumpbox.security_group_id
    }
  ]

  egress_rules = ["all-all"]

  tags = {
    Name        = "jeeves-sg-web"
    Environment = "dev"
  }
}

module "jeeves_sg_db" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.1.0"

  name        = "jeeves-db-access"
  description = "Allow MySQL and PostgreSQL access"
  vpc_id      = module.jeeves_vpc.vpc_id

  # Remove this line - it's causing the issue:
  # ingress_rules = ["mysql-tcp", "postgresql-tcp"]

  ingress_with_source_security_group_id = [
    {
      from_port                = 3306
      to_port                  = 3306
      protocol                 = "tcp"
      description              = "Allow MySQL from Web SG"
      source_security_group_id = module.jeeves_sg_web.security_group_id
    },
    {
      from_port                = 5432
      to_port                  = 5432
      protocol                 = "tcp"
      description              = "Allow PostgreSQL from Web SG"
      source_security_group_id = module.jeeves_sg_web.security_group_id
    },
    {
      from_port                = 22
      to_port                  = 22
      protocol                 = "tcp"
      description              = "SSH from Jumpbox"
      source_security_group_id = module.jeeves_sg_jumpbox.security_group_id
    }
  ]

  # Allow all outbound traffic
  egress_rules = ["all-all"]

  tags = {
    Name        = "jeeves-sg-db"
    Environment = "dev"
  }
}