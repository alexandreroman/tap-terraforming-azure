output "tap_kubeconfig" {
  sensitive = true
  value     = azurerm_kubernetes_cluster.tap.kube_config_raw
}

output "tap_gui_db_username" {
  value = var.enable_tap_gui_db ? module.tap_gui_db[0].db_username : null
}

output "tap_gui_db_password" {
  value     = var.enable_tap_gui_db ? module.tap_gui_db[0].db_password : null
  sensitive = true
}

output "tap_gui_db_hostname" {
  value = var.enable_tap_gui_db ? module.tap_gui_db[0].db_hostname : null
}
