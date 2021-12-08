variable "ssm_name" {
  default = "/LandCheck/postgresconnection"
}

variable "ssm_value" {}

variable "ssm_type" {
  default = "String"
}

variable "description" {
  default = "The parameter description"
}