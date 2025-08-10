###############################
###### VARs DEFINITIONS #######
###############################


variable "name" {
  description = "Name of the setup or client"
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

variable "location_short" {
  description = "Shortcat of location"
  type        = string
  default     = "we"
}

variable "environment" {
  description = "Environment for the resources"
  type        = string
}

variable "backend_resource_group_name" {
  description = "Name of backend rg"
  type        = string
}

variable "subnets" {
  description = "Map of private subnets configuration"
  type        = map(object({
    address_prefix = string
  }))
}

# Allow SSH only from your IP/CIDR (replace!)
variable "admin_source_cidr" {
  type        = string
  description = "CIDR allowed to SSH (e.g., 1.2.3.4/32)"
  default = "*"
}

variable "prv_ip_lin" {
  description = "Private IP for VM"
  type        = string
}
variable "prv_ip_lin_prv" {
  description = "Private IP for VM"
  type        = string
}
