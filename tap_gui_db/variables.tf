variable "az_location" {
  type        = string
  default     = "francecentral"
  description = "Azure location for resources"
}

variable "az_res_group" {
  type        = string
  default     = "tap-demo"
  description = "Azure resource group"
}

variable "az_tags" {
  type        = map(string)
  default     = {}
  description = "Tags to attach to Azure resources"
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
