resource "aws_ecs_cluster" "main" {
  name = var.name
  setting {
    name  = "containerInsights"
    value = "enabled"
  }
  lifecycle {
    create_before_destroy = true
  }
  tags = var.common_tags
}