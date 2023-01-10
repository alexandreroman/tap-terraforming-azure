variable "az_client_id" {
  type        = string
  description = "Azure Client ID"
}

variable "az_client_secret" {
  type        = string
  description = "Azure Client Secret"
}

variable "az_location" {
  type        = string
  default     = "francecentral"
  description = "Azure location for resources"
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
    "full"    = "Standard_D8_v4"
    "build"   = "Standard_D8_v4"
    "iterate" = "Standard_D4_v3"
    "run"     = "Standard_D4_v3"
    "view"    = "Standard_D4_v3"
  }
}

variable "az_aks_cluster_node_count_per_profile" {
  type        = map(any)
  description = "Define the node count for cluster nodes depending on the TAP profile"
  default = {
    "full"    = 6
    "build"   = 3
    "iterate" = 3
    "run"     = 3
    "view"    = 1
  }
}

variable "az_aks_cluster_max_nodes" {
  type        = number
  description = "Set the limit for the number of cluster nodes"
  default     = 12
}

variable "enable_tap_gui_db" {
  type        = bool
  default     = false
  description = "Set to true to create a database for TAP GUI"
}

variable "tap_gui_db_name" {
  type        = string
  description = "TAP GUI database name"
  default     = "tap-db"
}

variable "tap_gui_db_user" {
  type        = string
  description = "TAP GUI database user"
  default     = "psqladmin"
}
