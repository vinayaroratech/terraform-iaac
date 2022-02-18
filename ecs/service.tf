data "template_file" "task_definition" {
  template = file("${path.module}/task_definition.json")

  vars = {
    region       = var.aws_region
    name         = var.name
    image        = "${var.account_id}.dkr.ecr.${var.aws_region}.amazonaws.com/${var.repo_name}:${var.image_tag}"
    iam_role_arn = aws_iam_role.service.arn
    log_group    = aws_cloudwatch_log_group.log_group.name
  }
}

resource "aws_ecs_task_definition" "task_definition" {
  family                   = var.name
  requires_compatibilities = ["FARGATE"]
  container_definitions    = data.template_file.task_definition.rendered
  network_mode             = "awsvpc"
  memory                   = 512
  cpu                      = 256
  task_role_arn            = aws_iam_role.service.arn
  execution_role_arn       = aws_iam_role.service.arn
}

resource "aws_ecs_service" "service" {
  name            = var.name
  cluster         = aws_ecs_cluster.main.id
  launch_type     = "FARGATE"
  task_definition = aws_ecs_task_definition.task_definition.arn

  desired_count = 1

  network_configuration {
    subnets          = var.subnets
    security_groups  = [aws_security_group.main.id]
    assign_public_ip = true
  }
  tags = var.common_tags
}

resource "aws_cloudwatch_log_group" "log_group" {
  name              = "/fargate/service/${var.name}"
  retention_in_days = var.logs_retention_in_days
  tags              = var.common_tags
}