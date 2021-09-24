output "postgresql_server" {
  value     = azurerm_postgresql_server.psql-server
  sensitive = true
}

output "server_name" {
  description = "The name of the PostgreSQL server"
  value       = azurerm_postgresql_server.psql-server.name
}

output "server_fqdn" {
  description = "The fully qualified domain name (FQDN) of the PostgreSQL server"
  value       = azurerm_postgresql_server.psql-server.fqdn
}

output "administrator_login" {
  description = "Admin username"
  value       = var.psql-admin-login
}

output "administrator_password" {
  description = "Password for admin user"
  value       = var.psql-admin-password
  sensitive   = true
}