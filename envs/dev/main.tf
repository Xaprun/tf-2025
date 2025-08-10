###############################
########### BACKEND ###########
###############################

backend_resource_group_name = "tf-backend-rg"

###############################
########### TFVARS ############
###############################

# PROJECT/CLIENT SPECYFIC CONFIGURATION:
name           = "p01"
location       = "westeurope"
location_short = "we"
environment    = "dev"
prefix         = "${var.name}-${var.environment}-${var.location_short}"

# NETWORK CONFIG:
network_name  = "${var.prefix}-vnet"
address_space = ["10.0.0.0/16"]
subnets = {
  "subnet-win" = {
    address_prefix = "10.0.10.0/24"
  }
  "subnet-lin" = {
    address_prefix = "10.0.20.0/24"
  }
  "subnet-lin-prv" = {
    address_prefix = "10.0.21.0/24"
  }
}

###############################
############# RGs #############
###############################

resource "azurerm_resource_group" "rg-01" {
  name     = "${var.prefix}-rg"
  location = var.location
}

###############################
########### VNETS #############
###############################

module "vnet-01" {
  source                = "git::https://github.com/xaprun/tfmodules.git//modules/vnet?ref=vnet-v1.0.1"
  name                  = var.network_name
  location              = var.location
  address_space         = var.address_space
  resource_group_name   = azurerm_resource_group.rg-01.name
  subnets               = var.subnets
}


