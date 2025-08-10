###############################
########### BACKEND ###########
###############################

backend_resource_group_name = "tf-backend-rg"

###############################
########### TFVARS ############
###############################

# PROJECT/CLIENT SPECYFIC CONFIGURATION:
name          = "p01"
location      = "westeurope"
environment   = "dev"
prefix        = "${var.name}-${var.environment}-${var.location}"

# NETWORK CONFIG:
network_name  = "dev"
address_space = ["10.0.0.0/16"]
subnets = {
  "subnet-05" = {
    address_prefix = "10.0.5.0/24"
  }
  "subnet-06" = {
    address_prefix = "10.0.6.0/24"
  }
}

###############################
############# RGs #############
###############################

resource "azurerm_resource_group" "rg01" {
  name     = "${var.name}-${var.environment}-${var.location}-rg"
  location = var.location
}

###############################
########### VNETS #############
###############################

module "vnet-rg01-01" {
  # source              = "../../modules/vnet/"
  source                = "git::https://github.com/xaprun/tfmodules.git//modules/vnet?ref=vnet-v1.0.1"
  name                  = "${var.name}-${var.location}-${var.network_name}"
  location              = var.location
  address_space         = var.address_space
  resource_group_name   = azurerm_resource_group.rg01.name
  subnets               = var.subnets
}


