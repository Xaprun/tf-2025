terraform {
  backend "azurerm" {
    resource_group_name  = "rg-terraform-backend"
    storage_account_name = "tfstatebackendaj"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}
