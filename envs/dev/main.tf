###############################
##### TFMAESTRO MODIFIED ######
###############################
resource "azurerm_resource_group" "rg" {
  name     = "${var.name}-rg"
  location = var.location
}

module "vnet" {
  # source              = "../../modules/vnet/"
  source = "git::https://github.com/xaprun/tfmodules.git//modules/vnet?ref=vnet-v1.0.0"
  name                = var.network_name
  location            = azurerm_resource_group.rg.location
  address_space       = var.address_space
  resource_group_name = azurerm_resource_group.rg.name
  subnets             = var.subnets
}
