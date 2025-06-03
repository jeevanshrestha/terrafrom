output "name" {
  description = "Name of the S3 bucket"
  value       = aws_s3_bucket.my_static_website.id
}

output "arn" {
  description = "ARN of the S3 bucket"
  value       = aws_s3_bucket.my_static_website.arn
}

output "bucket_domain_name" {
  description = "Domain name of the S3 bucket"
  value       = aws_s3_bucket.my_static_website.bucket_domain_name
}


output "bucket_region" {
  description = "Region where the S3 bucket is located"
  value       = aws_s3_bucket.my_static_website.region
}


output "bucket_regional_domain_name" {
  description = "Regional domain name of the S3 bucket"
  value       = aws_s3_bucket.my_static_website.bucket_regional_domain_name
}

output "website_endpoint" {
  description = "Endpoint for the static website"
  value       = aws_s3_bucket_website_configuration.my_static_website_config.website_endpoint
}

output "static_website_url" {
  description = "URL for the static website"
  value       = "http://${aws_s3_bucket.my_static_website.bucket_domain_name}"
}
