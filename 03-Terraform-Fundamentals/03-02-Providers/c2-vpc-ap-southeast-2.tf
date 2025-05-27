# AWS VPC configuration for the Asia Pacific (Sydney) region 
resource "aws_vpc" "my-vpc-ap-southeast-2" {
  cidr_block           = "10.1.0.0/16"
  tags = {
    Name = "my-vpc-ap-southeast-2"
  }
  
}