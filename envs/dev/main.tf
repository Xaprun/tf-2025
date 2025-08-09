###############################
########### VNETS #############
###############################
resource "azurerm_resource_group" "rg01" {
  name     = "${var.name}-${var.location}-rg"
  location = var.location
}

module "vnet-rg01-01" {
  # source              = "../../modules/vnet/"
  source                = "git::https://github.com/xaprun/tfmodules.git//modules/vnet?ref=vnet-v1.0.1"
  name                  = "${var.name}-${var.location}-${var.network_name}"
  location              = azurerm_resource_group.rg01.location
  address_space         = var.address_space
  resource_group_name   = azurerm_resource_group.rg01.name
  subnets               = var.subnets
}

################################
module "vm" {
  source = "git::https://github.com/Xaprun/tfmodules.git//modules/vm?ref=main"

  resource_group_name     = azurerm_resource_group.rg01.name
  resource_group_location = azurerm_resource_group.rg01.location
  environment             = var.environment
  network_name            = "${var.name}-${var.location}-${var.network_name}"

  admin_username          = "azureuser"
  public_subnet_name      = keys(var.subnets)[0]
  admin_ssh_key_path      = "ssh/admin_key.pub"
  # custom_data_file      = "cloud-init/init.sh"
  subnet_id               = module.vnet-rg01-01.subnet_ids["subnet-06"]
  depends_on              = [azurerm_resource_group.rg01, module.vnet-rg01-01]

  vm_config = {
    "${var.name}-${var.location}-vm1" = {
      private_ip          = "10.0.6.10"
      public_ip_name      = "vm1-public-ip"
      machine_type        = "Standard_B1ms"
      machine_description = "Test VM 1"
    }
  }
  firewall_rules = {}
}
