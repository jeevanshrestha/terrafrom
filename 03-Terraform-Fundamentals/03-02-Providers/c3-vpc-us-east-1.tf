# AWS VPC configuration for the Asia Pacific (Sydney) region 
resource "aws_vpc" "my-vpc-us-east-1" {
  cidr_block           = "10.1.0.0/16"

  provider             = aws.us-east-1 # Use the us-east-1 provider alias
 /*
 Additional Note:
provider = <PROVIDER_NAME>.<ALIAS> # This is how you specify the provider alias in a resource block.
 */
  # Note-1:  AWS Credentials Profile (profile = "default") configured on your local desktop terminal
  tags = {
    Name = "my-vpc-us-east-1"
  }
  
}