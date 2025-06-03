
# Call our custom S3 Bucket Module

module "jeeves_s3_bucket" {
  # This module creates an S3 bucket configured for static website hosting  
  source      = "./modules/aws-s3-static-website-bucket"
  bucket_name = var.my_s3_bucket_name
  tags        = var.my_s3_bucket_tags
}

