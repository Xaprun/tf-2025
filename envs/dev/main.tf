###############################
########### VNETS #############
###############################
resource "azurerm_resource_group" "rg01" {
  name     = "${var.name}-${var.location}-rg"
  location = var.location
}

module "vnet" {
  # source              = "../../modules/vnet/"
  source = "git::https://github.com/xaprun/tfmodules.git//modules/vnet?ref=vnet-v1.0.1"
  name                = ${var.name}-${var.location}-${var.network_name}
  location            = azurerm_resource_group.rg01.location
  address_space       = var.address_space
  resource_group_name = azurerm_resource_group.rrg.name
  subnets             = var.subnets
}

