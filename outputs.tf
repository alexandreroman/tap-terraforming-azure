output "tap_kubeconfig" {
  sensitive = true
  value     = azurerm_kubernetes_cluster.tap.kube_config_raw
}

output "tap_gui_db_user" {
  value = var.enable_tap_gui_db ? module.tap_gui_db[0].tap_gui_db_user : null
}

output "tap_gui_db_password" {
  value     = var.enable_tap_gui_db ? module.tap_gui_db[0].tap_gui_db_password : null
  sensitive = true
}

output "tap_gui_db_host" {
  value = var.enable_tap_gui_db ? module.tap_gui_db[0].tap_gui_db_host : null
}
