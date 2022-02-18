output "vpc_id" {
  value = module.vpc.vpc_id
}

output "vpc_cidr_block" {
  value = module.vpc.vpc_cidr_block
}

output "gw_id" {
  value = module.vpc.gw_id
}

output "main_route_table_id" {
  value = module.vpc.main_route_table_id
}

output "vpc_dhcp_id" {
  value = module.vpc.vpc_dhcp_id
}

output "subnets" {
  value = module.subnets.subnets
}

output "route_id" {
  value = module.route.route_id
}

output "sec_grp_rds" {
  value = module.sec_group_rds.sec_grp_rds
}

output "db_subnet_group_id" {
  value = module.rds.db_subnet_group_id
}

output "db_subnet_group_arn" {
  value = module.rds.db_subnet_group_arn
}

output "db_instance_address" {
  value = module.rds.db_instance_address
}

output "db_instance_arn" {
  value = module.rds.db_instance_arn
}

output "db_instance_availability_zone" {
  value = module.rds.db_instance_availability_zone
}

output "db_instance_endpoint" {
  value = module.rds.db_instance_endpoint
}

output "db_instance_id" {
  value = module.rds.db_instance_id
}

output "db_instance_resource_id" {
  value = module.rds.db_instance_resource_id
}

output "db_instance_status" {
  value = module.rds.db_instance_status
}

output "db_instance_name" {
  value = module.rds.db_instance_name
}

output "db_instance_username" {
  value = module.rds.db_instance_username
}

output "db_instance_password" {
  value     = module.rds.db_instance_password
  sensitive = true
}

output "db_instance_port" {
  value = module.rds.db_instance_port
}

output "base_queue_url" {
  value = module.reports_queue.base_queue_url
}

output "report_app_ecr" {
  value = module.report_app_ecr.ecr
}

## Outputs ##
output "report_app_ecs" {
  value = module.report_app_ecs.ecs_cluster
}