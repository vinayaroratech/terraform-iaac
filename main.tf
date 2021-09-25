# sPECIFy the provider and access details
provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  region     = var.aws_region
}

## Network
# Create VPC
module "vpc" {
  source     = "./network/vpc"
  cidr_block = var.cidr_block
}

# Create Subnets
module "subnets" {
  source         = "./network/subnets"
  vpc_id         = module.vpc.vpc_id
  vpc_cidr_block = module.vpc.vpc_cidr_block
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
  db_username       = var.db_username
  db_password       = var.db_password
}