variable "company" {
  type        = string
  description = "Company Name"
}

variable "prefix" {
  type        = string
  description = "Prefix Name"
}

variable "environment" {
  type        = string
  description = "PostgreSQL Server Environment"
}

variable "db-name" {
  type        = string
  description = "PostgreSQL Database Name"
  default     = "landdb"
}

variable "psql-location" {
  type        = string
  description = "PostgreSQL DB Location"
}

variable "owner" {
  type        = string
  description = "Name of the Owner"
}

variable "azure-subscription-id" {
  type        = string
  description = "Azure Subscription Id"
}

variable "azure-client-id" {
  type        = string
  description = "AD Client Id"
}

variable "azure-client-secret" {
  type        = string
  description = "AD Client Secret"
}

variable "azure-tenant-id" {
  type        = string
  description = "Azure Tenant Id"
}

variable "psql-admin-login" {
  type        = string
  description = "Login to authenticate to PostgreSQL Server"
}
variable "psql-admin-password" {
  type        = string
  description = "Password to authenticate to PostgreSQL Server"
}
variable "psql-version" {
  type        = string
  description = "PostgreSQL Server version to deploy"
  default     = "11"
}
variable "psql-sku-name" {
  type        = string
  description = "PostgreSQL SKU Name"
  default     = "B_Gen5_1"
}
variable "psql-storage" {
  type        = string
  description = "PostgreSQL Storage in MB"
  default     = "5120"
}