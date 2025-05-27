resource "aws_eip" "my-elastic-ip" {
  instance   = aws_instance.my-ec2-vm.id                         # Associate the Elastic IP with the EC2 instance 
  depends_on = [aws_internet_gateway.vpc-dev-igw , aws_instance.my-ec2-vm] # Ensure the EC2 instance is created before the Elastic IP
  tags = {
    Name               = "MyElasticIP"
    "tag1"             = "Update-test-1"
    "AvailabilityZone" = "ap-southeast-2a"
    "VPC"              = aws_vpc.vpc-dev.id
    "Subnet"           = aws_subnet.vpc-dev-public-subnet-1.id
    "SecurityGroup"    = aws_security_group.vpc-dev-public-sg.id
  }
}