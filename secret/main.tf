resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "_%@"
}

resource "aws_secretsmanager_secret" "secret" {
  name        = var.secret_name
  description = var.description
  tags = {
    environment = terraform.workspace
  }
}

resource "aws_secretsmanager_secret_version" "sversion" {
  secret_id     = aws_secretsmanager_secret.secret.id
  secret_string = jsonencode(var.secrets)
}


resource "aws_iam_policy" "secrets_access" {
  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Id": "secretspolicy",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "secretsmanager:GetResourcePolicy",
        "secretsmanager:GetSecretValue",
        "secretsmanager:DescribeSecret",
        "secretsmanager:ListSecretVersionIds"
      ],
      "Resource": "arn:aws:secretsmanager:*:*:${var.secret_name}"
    }
  ]
}
POLICY
}

# resource "aws_iam_role_policy_attachment" "secret_access" {
#   role       = "get_secret_value_role"
#   policy_arn = aws_iam_policy.secrets_access.arn
# }