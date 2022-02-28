# Specify the provider and access details
data "aws_caller_identity" "current" {}

provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  region     = var.aws_region
  profile    = "peritos"
}

## Network
# Create VPC
module "vpc" {
  source      = "./network/vpc"
  cidr_block  = var.cidr_block
  common_tags = local.common_tags
}

# Create Subnets
module "subnets" {
  source         = "./network/subnets"
  vpc_id         = module.vpc.vpc_id
  vpc_cidr_block = module.vpc.vpc_cidr_block
}

# Configure Routes
module "route" {
  source              = "./network/route"
  main_route_table_id = module.vpc.main_route_table_id
  gw_id               = module.vpc.gw_id

  subnets = module.subnets.subnets
}

module "sec_group_rds" {
  source         = "./network/sec_group"
  vpc_id         = module.vpc.vpc_id
  vpc_cidr_block = module.vpc.vpc_cidr_block
}

module "rds" {
  source = "./rds"

  subnets = module.subnets.subnets

  sec_grp_rds       = module.sec_group_rds.sec_grp_rds
  identifier        = var.identifier
  storage_type      = var.storage_type
  allocated_storage = var.allocated_storage
  db_engine         = var.db_engine
  engine_version    = var.engine_version
  instance_class    = var.instance_class
  db_name           = var.db_name
  db_username       = var.db_username
  db_password       = var.db_password
}

module "s3" {
  source = "./s3"
  #bucket name should be unique
  bucket_name     = var.bucket_name
  sqs_bucket_name = var.sqs_bucket_name
}

module "reports_queue" {
  source             = "./sqs"
  queue_name         = var.queue_name
  visibility_timeout = 901
  receive_count      = 1
  aws_region         = var.aws_region
}

module "report_lambda" {
  source     = "./lambda"
  aws_region = var.aws_region
  queue_arn  = module.reports_queue.base_queue_arn
}

module "app-secrets" {
  source  = "./secret"
  secrets = var.secrets
}


module "report_app_ecr" {
  source      = "./ecr"
  name        = "${local.owners}_report_app"
  common_tags = local.common_tags
}

module "report_app_ecs" {
  source      = "./ecs"
  account_id  = data.aws_caller_identity.current.account_id
  name        = "${local.name}_report_app"
  repo_name   = "${local.owners}_report_app"
  common_tags = local.common_tags
  aws_region  = var.aws_region
  vpc_id      = module.vpc.vpc_id
  subnets     = module.subnets.subnets
  application = local.owners
  environment = local.environment
}


module "report-id-parms" {
  source      = "./ssm"
  ssm_name    = "/ReportLambda/ReportId"
  description = "Paramter used to pass information from lambda to ecs service"
  ssm_type    = "String"
  ssm_value   = "10"
}
