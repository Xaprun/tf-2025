###############################
######## TFMAESTRO VRS ########
###############################
variable "prefix" {
description = "Used as prefix in resource naming convention"
type        = string
}
variable "network_name" {
  description = "Name of the virtual network"
  type        = string
}

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


