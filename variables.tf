variable "az_tags" {
  type        = map(string)
  default     = {}
  description = "Tags to attach to Azure resources"
}

variable "az_res_group" {
  type        = string
  default     = "tap"
  description = "Azure resource group"
}

variable "az_aks_cluster" {
  type        = string
  default     = "tap"
  description = "AKS cluster name"
}

variable "tap_profile" {
  type        = string
  default     = "full"
  description = "TAP profile"
}

variable "az_aks_cluster_vm_size_per_profile" {
  type        = map(any)
  description = "Define the AKS VM size for cluster nodes depending on the TAP profile"
  default = {
    "full"    = "Standard_D8d_v5"
    "build"   = "Standard_D8d_v5"
    "iterate" = "Standard_D8d_v5"
    "run"     = "Standard_D4d_v5"
    "view"    = "Standard_D4d_v5"
  }
}

variable "az_aks_cluster_node_count_per_profile" {
  type        = map(any)
  description = "Define the node count for cluster nodes depending on the TAP profile"
  default = {
    "full"    = 6
    "build"   = 1
    "iterate" = 1
    "run"     = 2
    "view"    = 1
  }
}

variable "az_aks_cluster_max_nodes" {
  type        = number
  description = "Set the limit for the number of cluster nodes"
  default     = 12
}
