output "base_queue_url" {
  value = aws_sqs_queue.base_queue.id
}

output "base_queue_arn" {
  value = aws_sqs_queue.base_queue.arn
}


output "deadletter_queue_url" {
  value = aws_sqs_queue.deadletter_queue.id
}


output "consumer_policy_arn" {
  value = aws_iam_policy.consumer_policy.arn
}


output "producer_policy_arn" {
  value = aws_iam_policy.producer_policy.arn
}