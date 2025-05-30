
variable "instance_type" {
  description = "The type of EC2 instance to create"
  type        = string
  default     = "t3.micro" # Example instance type, replace with a valid one

}

#Datasource
data "aws_ec2_instance_type_offerings" "t3_micro_available_1" {

  # Filter for zones supporting `t3.micro` instance type (unsupported).
  # If filtering by specific location types is required, consider using other attributes or filters provided by AWS.
  filter {
    name   = "instance-type"
    values = [var.instance_type] # Filter for availability zones that support `t3.micro` instance type
  }

  filter {
    name   = "location"
    values = ["us-east-1a"] # Filter by AWS region `us-east-1`
  }

  # Removed unsupported filter for instance_type
  location_type = "availability-zone"

}

output "azones" {
  value = data.aws_ec2_instance_type_offerings.t3_micro_available_1.instance_types # Output availability zone names
}

 