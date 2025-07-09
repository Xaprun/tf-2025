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
        resource_group_name = "tf-backend-rg"
        storage_account_name = "tfstate"
        container_name = "tfstatedev"
        key = "terraform.tfstate"
    }
}
