module "vm" {
  source = "git::https://github.com/Xaprun/tfmodules.git//modules/vm?ref=main"

  resource_group_name     = "${var.environment}-rg"
  resource_group_location = azurerm_resource_group.main.location
  network_name            = var.location
  environment             = var.environment
  # network_name            = var.network_name
  admin_username          = "azureuser"
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


    
