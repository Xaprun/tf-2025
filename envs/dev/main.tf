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

module "vm" {
  source = "git::https://github.com/Xaprun/tfmodules.git//modules/vm?ref=main"

  resource_group_name     = "${var.environment}-rg"
  resource_group_location = var.location
  environment             = var.environment
  network_name            = var.network_name
  subnet_id = module.vnet.subnet_ids["subnet-public"]
  admin_username          = "azureuser"
  public_subnet_name      = var.public_subnet_name
  admin_ssh_key_path      = "ssh/admin_key.pub"
  # custom_data_file        = "cloud-init/init.sh"

  vm_config = {
    "vm1" = {
      private_ip          = "10.0.1.10"
      public_ip_name      = "vm1-public-ip"
      machine_type        = "Standard_B1ms"
      machine_description = "Test VM 1"
    }
  }
  firewall_rules = {}
}
