
###############################
########### VM DEBIAN #########
###############################
module "vm-lin-01" {
  source = "git::https://github.com/Xaprun/tfmodules.git//modules/vm?ref=main"

  resource_group_name     = azurerm_resource_group.rg-01.name
  resource_group_location = var.location
  # environment           = var.environment
  network_name            = "${local.prefix}-vnet"

  admin_username          = "azureuser"
  public_subnet_name      = keys(var.subnets)[1]
  admin_ssh_key_path      = "ssh/admin_key.pub"
  # custom_data_file      = "${path.root}/cloud-init/init.sh"
  # custom_data_file      = "${path.module}/cloud-init/init.sh"
  custom_data_file         = filebase64("cloud-init/init.sh")
  subnet_id               = module.vnet-01.subnet_ids["subnet-lin"]
  depends_on              = [azurerm_resource_group.rg-01, module.vnet-01]

  vm_config = {
    "${local.prefix}-vm-li01" = {
      private_ip          = var.prv_ip_lin_prv
      public_ip_name      = "vm-li01-public-ip"
      machine_type        = "Standard_B1ms"
      machine_description = "Test VM 1"
    }
  }
  firewall_rules = {
  }

}
# Attach NSG to the subnet your VM uses
resource "azurerm_subnet_network_security_group_association" "subnet-lin" {
  subnet_id                 = module.vnet-01.subnet_ids["subnet-lin"]
  network_security_group_id = azurerm_network_security_group.ssh.id
}
#########################

module "vm-lin-02" {
  source = "git::https://github.com/Xaprun/tfmodules.git//modules/vm?ref=main"

  resource_group_name     = azurerm_resource_group.rg-01.name
  resource_group_location = var.location
  # environment           = var.environment
  network_name            = "${local.prefix}-vnet"

  admin_username          = "azureuser"
  public_subnet_name      = keys(var.subnets)[2]
  admin_ssh_key_path      = "ssh/admin_key.pub"
  # custom_data_file        = "cloud-init/init.sh"
  subnet_id               = module.vnet-01.subnet_ids["subnet-lin-prv"]
  depends_on              = [azurerm_resource_group.rg-01, module.vnet-01]

  vm_config = {
    "${local.prefix}-vm-li02" = {
      private_ip          = var.prv_ip_lin_prv
      public_ip_name      = "vm-li02-public-ip"
      machine_type        = "Standard_B1ms"
      machine_description = "Test VM 2"
    }
  }
  firewall_rules = {
  }
}

# Attach NSG to the subnet your VM uses
resource "azurerm_subnet_network_security_group_association" "subnet-lin-prv" {
  subnet_id                 = module.vnet-01.subnet_ids["subnet-lin-prv"]
  network_security_group_id = azurerm_network_security_group.ssh.id
}




