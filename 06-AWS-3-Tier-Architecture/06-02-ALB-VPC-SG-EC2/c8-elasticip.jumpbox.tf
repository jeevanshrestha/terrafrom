
resource "aws_eip" "jumpbox_eip" {
 
  depends_on = [ module.jeeves_vpc,  module.jeeves_sg_jumpbox, module.jumpbox ] # Ensure the VPC is created before the EIP
  instance = module.jumpbox.id # Associate the EIP with the jumpbox instance

  tags = {
    Name = "jumpbox-eip"
  }
}

# Associate the EIP with the jumpbox instance
resource "aws_eip_association" "jumpbox_assoc" {
  instance_id   = module.jumpbox.id
  allocation_id = aws_eip.jumpbox_eip.id
}