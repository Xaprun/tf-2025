#terraform {
#  backend "azurerm" {
#    resource_group_name  = "rg-terraform-backend"
#    storage_account_name = "tfstatebackendaj"
#    container_name       = "tfstate"
#    key                  = "terraform.tfstate"
#  }
#}

terraform {
    backend "azurerm" {
        resource_group_name = "var.backend_resource_group_name"
        storage_account_name = "tfstateenv${var.environment}"
        container_name = "tfstate"
        key = "terraform.tfstate"
    }
}
