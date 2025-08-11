###############################
######## LOCAL VARS ###########
###############################
locals {
  prefix = "${var.name}-${var.environment}-${var.location_short}"
  public_ip_vms = {
    for k, v in var.vm_config :
    k => v
    if lookup(v, "assign_public_ip", var.enable_public_ip)
  }
}

###############################
############# RGs #############
###############################

resource "azurerm_resource_group" "rg-01" {
  name     = "${local.prefix}-rg"
  location = var.location
}

###############################
########### VNETS #############
###############################

module "vnet-01" {
  source                = "git::https://github.com/xaprun/tfmodules.git//modules/vnet?ref=vnet-v1.0.1"
  name                  = "${local.prefix}-vnet-01"
  location              = var.location
  address_space         = var.address_space
  resource_group_name   = azurerm_resource_group.rg-01.name
  subnets               = var.subnets
}

###############################
######### SUBNET NSG ##########
###############################

resource "azurerm_network_security_group" "ssh" {
  name                = "${local.prefix}-lin-ssh-nsg"
  location            = azurerm_resource_group.rg-01.location
  resource_group_name = azurerm_resource_group.rg-01.name

  security_rule {
    name                       = "Allow-SSH"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = var.admin_source_cidr  # e.g. "1.2.3.4/32"  (replace!)
    destination_address_prefix = "*"
  }
}

