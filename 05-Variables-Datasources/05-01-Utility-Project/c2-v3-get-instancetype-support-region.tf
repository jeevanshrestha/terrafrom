

output "azones_t3_micro_all" {
  value = { for az, t in data.aws_ec2_instance_type_offerings.t3_micro_available_all : az => t.instance_types if length(t.instance_types) != 0 } # Output availability zone names
}

  