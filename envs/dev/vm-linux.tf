###############################
########### VM DEBIAN #########
###############################
module "vm" {
  source = "git::https://github.com/Xaprun/tfmodules.git//modules/vm?ref=main"

  resource_group_name     = azurerm_resource_group.rg01.name
  resource_group_location = azurerm_resource_group.rg01.location
  environment             = var.environment
  network_name            = "${var.name}-${var.location}-${var.network_name}"

  admin_username          = "azureuser"
  public_subnet_name      = keys(var.subnets)[0]
  admin_ssh_key_path      = "ssh/admin_key.pub"
  custom_data_file        = "cloud-init/init.sh"
  # custom_data_file        = "${path.root}/cloud-init/init.sh"
  # custom_data_file        = "${path.module}/cloud-init/init.sh"
  # custom_data_b64 = filebase64("${path.module}/cloud-init/init.sh")
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
  firewall_rules = {
  }

}
###############################
######### SUBNET NSG ##########
###############################
# Allow SSH only from your IP/CIDR (replace!)
variable "admin_source_cidr" {
  type        = string
  description = "CIDR allowed to SSH (e.g., 1.2.3.4/32)"
  default = "*"
}

resource "azurerm_network_security_group" "ssh" {
  name                = "${var.name}-${var.location}-ssh-nsg"
  location            = azurerm_resource_group.rg01.location
  resource_group_name = azurerm_resource_group.rg01.name

  security_rule {
    name                       = "Allow-SSH"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = var.admin_source_cidr  # e.g. "1.2.3.4/32"
    destination_address_prefix = "*"
  }
}

# Attach NSG to the subnet your VM uses
resource "azurerm_subnet_network_security_group_association" "subnet06" {
  subnet_id                 = module.vnet-rg01-01.subnet_ids["subnet-06"]
  network_security_group_id = azurerm_network_security_group.ssh.id
}
