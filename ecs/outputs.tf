## Outputs ##
output "ecs_cluster" {
  value = {
    id                = aws_ecs_cluster.main.id
    name              = aws_ecs_cluster.main.name
    security_group_id = aws_security_group.main.id
  }
}