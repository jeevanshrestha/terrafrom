resource "aws_instance" "my_ec2_instance" {
  ami               = "ami-0f5d1713c9af4fe30" # Example AMI ID, replace with a valid one
  instance_type     = "t2.micro"
  availability_zone = "ap-southeast-2a" # Specify the availability zone
  
  #availability_zone = "ap-southeast-2b" # Specify the availability zone

  tags = {
    Name               = "MyEC2Instance"
    "tag1"             = "Update-test-1"
    "AvailabilityZone" = "ap-southeast-2a"
  }

}