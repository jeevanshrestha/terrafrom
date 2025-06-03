# S3 static websit bucket

resource "aws_s3_bucket" "my_static_website" {
  bucket = var.bucket_name

  tags          = var.tags
  force_destroy = true # This is used to delete the bucket even if it contains objects. Use with caution.
}

# Resource-2 aws_s3_bucket_website_configuration
resource "aws_s3_bucket_website_configuration" "my_static_website_config" {
  bucket = aws_s3_bucket.my_static_website.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

# Resource-3 aws_s3_bucket_versioning
resource "aws_s3_bucket_versioning" "my_static_website_versioning" {
  bucket = aws_s3_bucket.my_static_website.id

  versioning_configuration {
    status = "Enabled"
  }
}

# Resource-4 aws_s3_bucket_ownership_controls
resource "aws_s3_bucket_ownership_controls" "my_static_website_ownership_controls" {
  bucket = aws_s3_bucket.my_static_website.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

# Resource-5 aws_s3_bucket_ownership_controls
resource "aws_s3_bucket_public_access_block" "my_static_website_public_access_block" {
  bucket = aws_s3_bucket.my_static_website.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# Resource-6 aws_s3_bucket_acl
resource "aws_s3_bucket_acl" "my_static_website_acl" {
  depends_on = [aws_s3_bucket_ownership_controls.my_static_website_ownership_controls,
  aws_s3_bucket_public_access_block.my_static_website_public_access_block]
  bucket = aws_s3_bucket.my_static_website.id
  acl    = "public-read" # This allows public read access to the bucket
}

# Resource-7 aws_s3_bucket_policy
resource "aws_s3_bucket_policy" "my_static_website_policy" {
  bucket = aws_s3_bucket.my_static_website.id

  depends_on = [
    aws_s3_bucket_public_access_block.my_static_website_public_access_block
  ]

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "PublicReadGetObject",
      "Effect": "Allow",
      "Principal": "*",
      "Action": ["s3:GetObject"],
      "Resource": ["arn:aws:s3:::${var.bucket_name}/*"]
    }
  ]
}
EOF
}