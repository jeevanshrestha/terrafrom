data "aws_ami" "latest_amazon_linux" {
  most_recent = true
  owners      = ["amazon"] # Use the official Amazon AMI

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-gp2"] # Filter for Amazon Linux 2 AMIs
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"] # Ensure the AMI uses EBS storage
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"] # Use HVM virtualization type
  }

  filter {
    name   = "architecture"
    values = ["x86_64"] # Use x86_64 architecture
  }

}

data "aws_availability_zones" "my_azones" {
  # Data source to get availability zones in the specified AWS region
  state = "available" # Get only available availability zones
  filter {
    name   = "region-name"
    values = [var.aws_region] # Filter by the specified AWS region
  }
}

