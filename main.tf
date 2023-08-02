terraform {
  required_version = ">= 1.3"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.29.1"
    }
  }
}

provider "azurerm" {
  features {}
}

# Get the main Azure resource group.
data "azurerm_resource_group" "tap" {
  name = var.az_res_group
}

# Create an AKS cluster.
resource "azurerm_kubernetes_cluster" "tap" {
  name                = var.az_aks_cluster
  location            = data.azurerm_resource_group.tap.location
  resource_group_name = data.azurerm_resource_group.tap.name
  dns_prefix          = var.az_aks_cluster

  kubernetes_version        = "1.25"
  automatic_channel_upgrade = "patch"

  identity {
    type = "SystemAssigned"
  }

  default_node_pool {
    name = "default"
    # Minimum node count.
    min_count = var.az_aks_cluster_node_count_per_profile[var.tap_profile]
    # Set a limit for max worker nodes.
    max_count = var.az_aks_cluster_max_nodes
    vm_size   = var.az_aks_cluster_vm_size_per_profile[var.tap_profile]
    # Autoscaling is enabled by default, so new nodes will be created / destroyed as needed.
    enable_auto_scaling = true

    # Set node image version: use the same value from the cluster.
    orchestrator_version = "1.25"

    temporary_name_for_rotation = "tmp"
  }

  auto_scaler_profile {
    expander = "least-waste"
  }

  tags = var.az_tags
}
