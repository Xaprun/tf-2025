name  = "dev"
network_name     = "dev"
location = "westeurope"
environment = "dev"
address_space = ["10.0.0.0/16"]
backend_resource_group_name = "tf-backend-rg"
subnets = {
  "subnet-05" = {
    address_prefix = "10.0.5.0/24"
  }
}

# resource_group_location = "westeurope"
public_subnet_name      = "subnet-public"
