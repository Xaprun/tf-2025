###############################
########### BACKEND ###########
###############################

backend_resource_group_name = "tf-backend-rg"

###############################
########### TFVARS ############
###############################

# PROJECT/CLIENT SPECYFIC CONFIGURATION:
name           = "p01"
location       = "westeurope"
location_short = "we"
environment    = "dev"
prefix         = "${var.name}-${var.environment}-${var.location_short}"

# NETWORK CONFIG:
network_name  = "${var.prefix}-vnet"
address_space = ["10.0.0.0/16"]
subnets = {
  "subnet-win" = {
    address_prefix = "10.0.10.0/24"
  }
  "subnet-lin" = {
    address_prefix = "10.0.20.0/24"
  }
  "subnet-lin-prv" = {
    address_prefix = "10.0.21.0/24"
  }
}
