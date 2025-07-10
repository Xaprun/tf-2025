variable "vm_admin_password" {
  description = "Admin password for the VM"
  type        = string
  sensitive   = true
}
###############################
######## TFMAESTRO VRS ########
###############################
variable "name" {
  description = "Name of the virtual network"
  type        = string
}

variable "address_space" {
  description = "Address space for the virtual network"
  type        = list(string)
}

variable "location" {
  description = "Location for the resources"
  type        = string
  default     = "westeurope"
}

variable "environment" {
  description = "Environment for the resources"
  type        = string
}

variable "backend_resource_group_name" {
  description = "Name of backend rg"
  type        = string
}
