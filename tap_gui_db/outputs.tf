output "db_username" {
  value = "${azurerm_postgresql_flexible_server.tap_gui_db.administrator_login}@${azurerm_postgresql_flexible_server.tap_gui_db.name}"
}

output "db_password" {
  value     = random_password.tap_gui_db_password.result
  sensitive = true
}

output "db_hostname" {
  value = azurerm_postgresql_flexible_server.tap_gui_db.fqdn
}
