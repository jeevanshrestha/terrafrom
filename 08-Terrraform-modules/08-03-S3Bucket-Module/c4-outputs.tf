 
output "s3_bucket_domain_name" {
  description = "The domain name of the S3 bucket created for static website hosting"
  value       = module.jeeves_s3_bucket.bucket_domain_name
}
output "s3_bucket_region" {
  description = "The region where the S3 bucket is located"
  value       = module.jeeves_s3_bucket.bucket_region
}

output "s3_bucket_regional_domain_name" {
  description = "The regional domain name of the S3 bucket created for static website hosting"
  value       = module.jeeves_s3_bucket.bucket_regional_domain_name
}

output "s3_website_endpoint" {
  description = "The endpoint for the static website hosted on the S3 bucket"
  value       = module.jeeves_s3_bucket.website_endpoint
}
output "s3_static_website_url" {
  description = "The URL for the static website hosted on the S3 bucket"
  value       = module.jeeves_s3_bucket.static_website_url
}

