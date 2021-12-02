resource "aws_s3_bucket" "s3_bucket" {
    bucket = "${var.bucket_name}" 
    acl = "${var.acl_value}"   
}

resource "aws_s3_bucket_public_access_block" "public_access_block" {
  bucket = aws_s3_bucket.s3_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket" "sqs_s3_bucket" {
   bucket = "${var.sqs_bucket_name}" 
    acl = "${var.sqs_acl_value}" 
}

resource "aws_s3_bucket_public_access_block" "sqs_public_access_block" {
  bucket = aws_s3_bucket.sqs_s3_bucket.id
  
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

