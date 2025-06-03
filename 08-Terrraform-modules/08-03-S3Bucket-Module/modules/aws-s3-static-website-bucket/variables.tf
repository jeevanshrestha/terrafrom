
#Input variables for module

variable "bucket_name" {
  description = "S3 Bucket Name for Static Website"
  type        = string
}

variable "tags" {
  description = "Tags to apply to the S3 bucket"
  type        = map(string)
  default     = {}
}