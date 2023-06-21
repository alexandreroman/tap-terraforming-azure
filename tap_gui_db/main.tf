# Generate a random password for the database.
resource "random_password" "tap_gui_db_password" {
  length           = 16
  special          = true
  override_special = "()-_=+[]{}<>"
}

data "azurerm_resource_group" "tap_gui_db" {
  name = var.az_res_group
}

# Create an Azure-managed PostgreSQL database which will be used by Backstage.
resource "azurerm_postgresql_flexible_server" "tap_gui_db" {
  name                = var.db_name
  location            = data.azurerm_resource_group.tap_gui_db.location
  resource_group_name = data.azurerm_resource_group.tap_gui_db.name

  administrator_login    = var.db_user
  administrator_password = random_password.tap_gui_db_password.result

  # Use a single core database for Backstage.
  sku_name = "B_Standard_B1ms"
  version  = "11"
  # Use strict minimum storage.
  storage_mb = 32768

  zone = 1

  tags = var.az_tags
}

# Allow access to the database from Azure resources (in this case: the AKS cluster).
resource "azurerm_postgresql_flexible_server_firewall_rule" "tap_gui_db_allow_access" {
  name             = "allow_access"
  server_id        = azurerm_postgresql_flexible_server.tap_gui_db.id
  start_ip_address = "0.0.0.0"
  end_ip_address   = "0.0.0.0"
}
