terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.1.0"
    }
  }
}

provider "azurerm" {
  features {}
}

module "terraform_state_bucket" {
  source              = "git::https://github.com/xaprun/tfmodules.git//modules/terraform_state_bucket?ref=terraform_state_bucket-v1.1.0"

  environment         = "dev"
  resource_group_name = "tf-backend-rg"
  location            = "westeurope"
  log_container_name  = "tfstate-logs-dev"
  container_access_type = "private"
}
