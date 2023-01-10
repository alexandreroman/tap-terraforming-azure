output "tap_gui_db_user" {
  value = "${azurerm_postgresql_server.tap_gui_db.administrator_login}@${azurerm_postgresql_server.tap_gui_db.name}"
}

output "tap_gui_db_password" {
  value     = random_password.tap_gui_db_password.result
  sensitive = true
}

output "tap_gui_db_host" {
  value = azurerm_postgresql_server.tap_gui_db.fqdn
}
