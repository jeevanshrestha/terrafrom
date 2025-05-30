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
    name   = "opt-in-status"
    values = ["opt-in-not-required"] # Filter for availability zones that do not require opt-in
  }
}


#Datasource
data "aws_ec2_instance_type_offerings" "t3_micro_available_all" {


  for_each = toset(data.aws_availability_zones.my_azones.names) # Use for_each to iterate over availability zones
  filter {
    name   = "instance-type"
    values = [var.instance_type] # Filter for availability zones that support `t3.micro` instance type
  }

  filter {
    name   = "location"
    values = [each.key] # Filter by AWS region `us-east-1`
  }

  # Removed unsupported filter for instance_type
  location_type = "availability-zone"

}

