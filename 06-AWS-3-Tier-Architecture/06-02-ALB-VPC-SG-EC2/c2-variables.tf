

variable "aws_region" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "ap-southeast-2" # Default region, can be overridden
}

#AWS EC2 Instance Variables
variable "instance_type" {
  description = "The type of EC2 instance to create"
  type        = string
  default     = "t3.micro" # Example AMI ID, replace with a valid one

}

variable "availability_zones" {
  description = "The availability zone for the EC2 instance"
  type        = list(string)
  default     = ["ap-southeast-2a", "ap-southeast-2b", "ap-southeast-2c"] # Specify the availability zone

}

variable "instance_keypair" {
  description = "The name of the AWS key pair for SSH access"
  type        = string
  default     = "Terraform-Key" # Replace with your key pair name for SSH access
}

 

#AWS EC2 Instance Type List
variable "instance_type_list" {
  description = "List of instance types to create"
  type        = list(string)
  default     = ["t3.micro", "t3.small", "t3.medium"] # Example list of instance types

}

#AWS EC2 Instance Type Map
variable "instance_type_map" {
  description = "Map of instance types with their descriptions"
  type        = map(string)
  default = {
    "dev"  = "t3.micro",
    "test" = "t3.small",
    "prod" = "t3.medium"
  } # Example map of instance types with descriptions

}

 