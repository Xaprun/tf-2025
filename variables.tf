variable "vm_admin_password" {
  description = "Admin password for the VM"
  type        = string
  sensitive   = true
}

# commented as removed from provider settings in main.tf, values passind directly to runers's os vars
# variable "client_id" { type = string }
# variable "client_secret" { type = string sensitive = true }
# variable "tenant_id" { type = string }
# variable "subscription_id" { type = string }
