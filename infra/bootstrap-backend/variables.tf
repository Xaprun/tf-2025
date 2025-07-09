variable "environment" {
  type        = string
  description = "Environment name (e.g. dev, prod)"
}

variable "resource_group_name" {
  type        = string
  description = "Resource Group for the Terraform backend"
}

variable "location" {
  type        = string
  description = "Azure region"
}

variable "log_container_name" {
  type        = string
  description = "Name of the logging container"
}

variable "container_access_type" {
  type        = string
  default     = "private"
  description = "Access level for the container"
}
