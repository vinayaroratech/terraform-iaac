resource "aws_sqs_queue" "sqs_queue" {
  name = "${var.queue_name}"
  delay_seconds             = 90
  max_message_size          = 2048
  message_retention_seconds = 86400
  receive_wait_time_seconds = 10

  tags = {
    Name = terraform.workspace
  }
  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Id": "sqspolicy",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": "*",
      "Action": "sqs:SendMessage",
      "Resource": "arn:aws:sqs:*:*:${var.queue_name}",
      "Condition": {
        "ArnEquals": { "aws:SourceArn": "${var.sqs_bucket_arn}" }
      }
    }
  ]
}
POLICY
}

resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = "${var.sqs_bucket_id}" 

  queue {
    queue_arn     = aws_sqs_queue.sqs_queue.arn
    events        = ["s3:ObjectCreated:*"]
  }
}
