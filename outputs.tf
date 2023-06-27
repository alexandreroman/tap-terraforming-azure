output "tap_kubeconfig" {
  sensitive = true
  value     = azurerm_kubernetes_cluster.tap.kube_config_raw
}
