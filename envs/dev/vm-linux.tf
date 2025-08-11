
###############################
########### VM DEBIAN #########
###############################
module "vm_lin_01" {
  source                  = "git::https://github.com/Xaprun/tfmodules.git//modules/vm?ref=main"
  environment             = var.environment
  network_name            = "${local.prefix}-vnet"
  resource_group_name     = azurerm_resource_group.rg-01.name
  resource_group_location = var.location
  subnet_id               = module.vnet_01.subnet_ids["subnet-lin"]
  admin_username          = "azureuser"
  admin_ssh_key_path      = "ssh/admin_key.pub"
  custom_data_file        = "cloud-init/init.sh"

  enable_public_ip = false  # module default

  vm_config = {
    "${local.prefix}-vm-li01" = {
      machine_type        = "Standard_B1ms"
      machine_description = "public"
      assign_public_ip    = true   # per-VM override
    }
  }
  firewall_rules = {
  }
}

module "vm_lin_02" {
  source                  = "git::https://github.com/Xaprun/tfmodules.git//modules/vm?ref=main"
  environment             = var.environment
  network_name            = "${local.prefix}-vnet"
  resource_group_name     = azurerm_resource_group.rg-01.name
  resource_group_location = var.location
  subnet_id               = module.vnet_01.subnet_ids["subnet-lin-prv"]
  admin_username          = "azureuser"
  admin_ssh_key_path      = "ssh/admin_key.pub"
  # no custom_data, no public IP
  enable_public_ip = false

  vm_config = {
    "${local.prefix}-vm-li02" = {
      machine_type        = "Standard_B1ms"
      machine_description = "private"
      # assign_public_ip omitted -> false via module default
    }
  }
  firewall_rules = {
  }
}



