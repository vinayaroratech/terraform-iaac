output "sqs_bucket_id" {
  value = aws_s3_bucket.sqs_s3_bucket.id
}

output "sqs_bucket_arn" {
  value = aws_s3_bucket.sqs_s3_bucket.arn
}