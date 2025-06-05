# AWS EC2 Instance Module
module "ec2_cluster" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  version                = "~> 5.0"
 
# Module Upgrade from v2.x to v5.x 
## In v2.x module, Meta-argument count is used
## In v5.x module, Meta-argument for_each is used
  #instance_count         = 2
  for_each = toset(["one", "two", "three"])

  name                   = "my-modules-demo-${each.key}"
  availability_zone      = var.availability_zone
  ami                    = data.aws_ami.amzlinux.id 
  instance_type          =  var.instance_type
  key_name               = var.instance_keypair

  vpc_security_group_ids = ["sg-03bd0e64aecb8cd16"] # Get Default VPC Security Group ID and replace
  subnet_id              = "subnet-0924073ad254813a0" # Get one public subnet id from default vpc and replace
  user_data              = file("apache-install.sh") 
  monitoring             = true

  tags = {
    Name        = "Modules-Demo-${each.key}"
    Terraform   = "true"
    Environment = "dev"
  }
}