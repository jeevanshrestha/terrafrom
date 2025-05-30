
#Datasource
data "aws_ec2_instance_type_offerings" "t3_micro_available" {

  # Filter for zones supporting `t3.micro` instance type (unsupported).
  # If filtering by specific location types is required, consider using other attributes or filters provided by AWS.
  for_each = toset(["us-east-1a", "us-east-1b", "us-east-1c", "us-east-1d", "us-east-1e"]) # Use for_each to iterate over availability zones
  filter {
    name   = "instance-type"
    values = ["t3.micro"] # Filter for availability zones that support `t3.micro` instance type
  }

  filter {
    name   = "location"
    values = [each.key] # Filter by AWS region `us-east-1`
  }

  # Removed unsupported filter for instance_type
  location_type = "availability-zone"

}

output "azones_list" {
  value = [for t in data.aws_ec2_instance_type_offerings.t3_micro_available : t.instance_types] # Output availability zone names
}

output "azones_t3_micro" {
  value = { for az, t in data.aws_ec2_instance_type_offerings.t3_micro_available : az => t.instance_types } # Output availability zone names
}

  