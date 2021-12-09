resource "aws_iam_role" "report_lambda" {
  name               = var.iam_name
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "report_lambda" {
  policy_arn = aws_iam_policy.report_lambda.arn
  role       = aws_iam_role.report_lambda.name
}

resource "aws_iam_policy" "report_lambda" {
  policy = data.aws_iam_policy_document.report_lambda.json
}

data "aws_iam_policy_document" "report_lambda" {
  statement {
    sid       = "AllowSQSPermissions"
    effect    = "Allow"
    resources = ["arn:aws:sqs:*"]

    actions = [
      "sqs:ChangeMessageVisibility",
      "sqs:DeleteMessage",
      "sqs:GetQueueAttributes",
      "sqs:ReceiveMessage",
      "ssm:GetParameter"
    ]
  }

  statement {
    sid       = "AllowInvokingLambdas"
    effect    = "Allow"
    resources = ["arn:aws:lambda:${var.aws_region}:*:function:*"]
    actions   = ["lambda:InvokeFunction"]
  }

  statement {
    sid       = "AllowCreatingLogGroups"
    effect    = "Allow"
    resources = ["arn:aws:logs:${var.aws_region}:*:*"]
    actions   = ["logs:CreateLogGroup"]
  }

  statement {
    sid       = "AllowWritingLogs"
    effect    = "Allow"
    resources = ["arn:aws:logs:${var.aws_region}:*:log-group:/aws/lambda/*:*"]

    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]
  }

  statement {
    sid       = "AllowSSMPermissions"
    effect    = "Allow"
    resources = ["arn:aws:ssm:*"]

    actions = [
      "ssm:GetParameter"
    ]
  }
}

resource "aws_sqs_queue" "report_lambda" {
  name                      = "${var.function_name}_queue"
  delay_seconds             = 90
  max_message_size          = 2048
  message_retention_seconds = 86400
  receive_wait_time_seconds = 10

  tags = {
    Name = terraform.workspace
  }
}

data "archive_file" "report_lambda_zip" {
  type        = "zip"
  source_dir  = "${path.module}/publish"
  output_path = "${path.module}/${var.file_name}"
}

resource "aws_lambda_function" "report_lambda" {
  filename         = data.archive_file.report_lambda_zip.output_path #var.file_name
  description      = "Landcheck report generation lambda trigger on SQS"
  function_name    = var.function_name
  role             = aws_iam_role.report_lambda.arn
  handler          = var.handler
  source_code_hash = data.archive_file.report_lambda_zip.output_base64sha256 #"${base64sha256(file(var.file_name))}"
  runtime          = "dotnetcore3.1"

  tags = {
    Name = terraform.workspace
  }

  timeout     = 900
  memory_size = 256
}

resource "aws_lambda_event_source_mapping" "event_source_mapping" {
  batch_size       = 1
  event_source_arn = aws_sqs_queue.report_lambda.arn
  enabled          = true
  function_name    = aws_lambda_function.report_lambda.arn
}