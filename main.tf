terraform {
  required_version = ">= 1.3"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.29.1"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.4.3"
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

# Create an Azure-managed PostgreSQL instance used by Backstage.
module "tap_gui_db" {
  count        = var.enable_tap_gui_db ? 1 : 0
  source       = "./tap_gui_db"
  az_res_group = data.azurerm_resource_group.tap.name
  az_tags      = var.az_tags
  db_name      = var.tap_gui_db_name
  db_user      = var.tap_gui_db_username
}

# Create an AKS cluster.
resource "azurerm_kubernetes_cluster" "tap" {
  name                = var.az_aks_cluster
  location            = data.azurerm_resource_group.tap.location
  resource_group_name = data.azurerm_resource_group.tap.name
  dns_prefix          = var.az_aks_cluster
  kubernetes_version  = "1.24"

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
  }

  auto_scaler_profile {
    expander = "least-waste"
  }

  tags = var.az_tags
}
