resource "random_pet" "petname" {
  length    = 2
  separator = "-"
}

resource "aws_s3_bucket" "my_bucket" {
  bucket = "my-unique-bucket-name-${random_pet.petname.id}"
}

# Explicitly disable ACLs (recommended)
resource "aws_s3_bucket_ownership_controls" "ownership" {
  bucket = aws_s3_bucket.my_bucket.id
  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

# If you need public access (not recommended)
resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket = aws_s3_bucket.my_bucket.id
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# Use bucket policy instead of ACLs for access control
resource "aws_s3_bucket_policy" "public_read" {
  bucket = aws_s3_bucket.my_bucket.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.my_bucket.arn}/*"
      }
    ]
  })
}