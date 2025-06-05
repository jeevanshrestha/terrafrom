# VPC Output Values

# VPC ID
output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.jeeves_vpc.vpc_id
}

# VPC CIDR blocks
output "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value       = module.jeeves_vpc.vpc_cidr_block
}

# VPC Private Subnets
output "private_subnets" {
  description = "List of IDs of private subnets"
  value       = module.jeeves_vpc.private_subnets
}

# VPC Public Subnets
output "public_subnets" {
  description = "List of IDs of public subnets"
  value       = module.jeeves_vpc.public_subnets
}

# VPC NAT gateway Public IP
output "nat_public_ips" {
  description = "List of public Elastic IPs created for AWS NAT Gateway"
  value       = module.jeeves_vpc.nat_public_ips
}

# VPC AZs
output "azs" {
  description = "A list of availability zones spefified as argument to this module"
  value       = module.jeeves_vpc.azs
}



# Output ALB DNS Name
output "alb_dns_name" {
  description = "Public DNS name of the ALB"
  value       = aws_lb.jeeves_alb.dns_name
}

output "jumpbox_public_ip" {
  value = aws_eip.jumpbox_eip.public_ip
}

# Output web server instances private IPs
output "web_server_private_ips" {
  description = "List of private IPs of web server instances" 
  value       = { for k, instance in module.web : k => instance.private_ip }
}

# Output DB server private IP
output "db_server_private_ip" {
  description = "Private IP of the database server instance"
  value       = module.db.private_ip
}