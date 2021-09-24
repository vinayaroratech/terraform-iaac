provider "random" {}

resource "random_id" "name" {
  byte_length = 8
}

resource "azurerm_resource_group" "psql-rg" {
  name     = "land-dev-psql-rg"
  location = var.psql-location
}

resource "azurerm_storage_account" "psql-sa" {
  name                     = "landsa${random_id.name.hex}"
  resource_group_name      = azurerm_resource_group.psql-rg.name
  location                 = azurerm_resource_group.psql-rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}


resource "azurerm_postgresql_server" "psql-server" {
  name                = "land-dev-psql-server"
  location            = azurerm_resource_group.psql-rg.location
  resource_group_name = azurerm_resource_group.psql-rg.name

  administrator_login          = var.psql-admin-login
  administrator_login_password = var.psql-admin-password

  sku_name = var.psql-sku-name
  version  = var.psql-version

  storage_mb        = var.psql-storage
  auto_grow_enabled = true

  # backup_retention_days            = 7
  geo_redundant_backup_enabled     = false
  public_network_access_enabled    = true
  ssl_enforcement_enabled          = true
  ssl_minimal_tls_version_enforced = "TLS1_2"
}


resource "azurerm_postgresql_database" "psql-db" {
  name                = var.db-name
  resource_group_name = azurerm_resource_group.psql-rg.name
  server_name         = azurerm_postgresql_server.psql-server.name
  charset             = "utf8"
  collation           = "English_United States.1252"
}


resource "azurerm_postgresql_firewall_rule" "psql-fw-rule" {
  name                = "psql-Home-Access"
  resource_group_name = azurerm_resource_group.psql-rg.name
  server_name         = azurerm_postgresql_server.psql-server.name
  start_ip_address    = "103.101.103.0"
  end_ip_address      = "103.101.103.160"
}

