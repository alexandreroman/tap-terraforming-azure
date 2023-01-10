# Generate a random password for the database.
resource "random_password" "tap_gui_db_password" {
  length           = 16
  special          = true
  override_special = "()-_=+[]{}<>"
}

# Create an Azure-managed PostgreSQL database which will be used by Backstage.
resource "azurerm_postgresql_server" "tap_gui_db" {
  name                = var.tap_gui_db_name
  location            = var.az_location
  resource_group_name = var.az_res_group

  administrator_login          = var.tap_gui_db_user
  administrator_login_password = random_password.tap_gui_db_password.result

  # Use a single core database for Backstage.
  sku_name = "B_Gen5_1"
  version  = "11"
  # Use strict minimum storage.
  storage_mb = 5120

  public_network_access_enabled    = true
  ssl_enforcement_enabled          = true
  ssl_minimal_tls_version_enforced = "TLS1_2"
}

# Allow access to the database from Azure resources (in this case: the AKS cluster).
resource "azurerm_postgresql_firewall_rule" "tap_gui_db_allow_access" {
  name                = "allow_access"
  resource_group_name = azurerm_postgresql_server.tap_gui_db.resource_group_name
  server_name         = azurerm_postgresql_server.tap_gui_db.name
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "0.0.0.0"
}
