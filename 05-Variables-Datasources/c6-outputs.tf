# Terraform output values

# EC2 Instance Public IP

#For loop for list
# output "ec2_instance_public_ip" {
#   description = "The public IP address of the EC2 instance"
#   value       = [for instance in aws_instance.my-ec2-vm : instance.public_ip]
# }


#for loop for key value pair
output "ec2_instance_public_ip" {
  description = "The public IP address of the EC2 instance"
  value       = { for k, instance in aws_instance.my-ec2-vm : k => instance.public_ip }
}

# EC2 Instance public DNS Name
# output "ec2_instance_public_dns" {
#   value       = aws_instance.my-ec2-vm[each.key].public_dns
#   description = "The public DNS name of the EC2 instance"
# }   

output "ec2_instance_public_dns" {
  description = "The public DNS address of the EC2 instance"
  value       = { for k, instance in aws_instance.my-ec2-vm : k => instance.public_dns }
}
