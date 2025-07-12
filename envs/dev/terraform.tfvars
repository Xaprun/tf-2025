name  = "dev"
network_name     = "dev"
location = "westeurope"
environment = "dev"
address_space = ["10.0.0.0/16"]
backend_resource_group_name = "tf-backend-rg"
subnets = {
  "subnet-priv" = {
    address_prefix = "10.0.1.0/24"
  }
  "subnet-db" = {
    address_prefix = "10.0.2.0/24"
  }
  "subnet-public" = {
    address_prefix = "10.0.3.0/24"
  }
}

# resource_group_location = "westeurope"
public_subnet_name      = "subnet-public"
