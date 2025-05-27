#Create S3 buckets using for_each with maps


resource "aws_s3_bucket" "my_s3_buckets" {

  #for_each with maps 
  for_each = {
    dev  = "my-funny-bucket-name-1"
    test = "my-runny-bucket-name-2"
    prod = "my-creative-bucket-name-3"
  }

  bucket = "${each.key}-${each.value}"


  tags = {
    Name        = each.value
    Environment = each.key
    bucketname  = "${each.key}-${each.value}"
  }
}