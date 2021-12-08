resource "aws_ssm_parameter" "secret" {
  name        = var.ssm_name
  description = var.description
  type        = var.ssm_type
  value       = var.ssm_value

  tags = {
    environment = terraform.workspace
  }
}