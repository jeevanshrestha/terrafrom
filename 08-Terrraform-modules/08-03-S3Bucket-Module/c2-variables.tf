

variable "aws_region" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "ap-southeast-2" # Default region, can be overridden
}

variable "my_s3_bucket_name" {
  description = "S3 Bucket Name for Static Website"
  type        = string
}

variable "my_s3_bucket_tags" {
  description = "Tags to apply to the S3 bucket"
  type        = map(string)
  default     = {}
}

