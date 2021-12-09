variable "secret_name" {
  default = "landcheck-secrets"
}

variable "secrets" {
  type = map(string)
}

variable "description" {
  default = "Secret description"
}