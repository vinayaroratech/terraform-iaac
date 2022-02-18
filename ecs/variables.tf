variable "aws_region" {
  description = "AWS region to launch servers."
}

variable "account_id" {}

variable "vpc_id" {
  description = "AWS vpc to launch."
}

variable "subnets" {
  type = list(string)
}

variable "name" {
  type = string
}

variable "repo_name" {
  type = string
}

variable "logs_retention_in_days" {
  type        = number
  default     = 90
  description = "Specifies the number of days you want to retain log events"
}

variable "common_tags" {
  type = any
}

variable "instance_type" {
  description = "The instance type to use, e.g t2.small"
  default     = "t2.micro"
}

variable "min_size" {
  description = "Minimum instance count"
  default     = 1
}

variable "max_size" {
  description = "Maxmimum instance count"
  default     = 1
}

variable "desired_capacity" {
  description = "Desired instance count"
  default     = 1
}

variable "key_name" {
  description = "SSH key name to use"
  default     = "landcheck-dev-management"
}

variable "instance_ebs_optimized" {
  description = "When set to true the instance will be launched with EBS optimized turned on"
  default     = false
}

variable "root_volume_size" {
  description = "Root volume size in GB"
  default     = 8
}

variable "docker_volume_size" {
  description = "Attached EBS volume size in GB"
  default     = 22
}

variable "image_tag" {
  default = "latest"
}

variable "application" {}

variable "environment" {}

variable "role" {
  default = "demo"
}