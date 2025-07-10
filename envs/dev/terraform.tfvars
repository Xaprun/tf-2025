name     = "dev"
location = "westeurope"
environment = "dev"
address_space = ["10.0.0.0/16"]
backend_resource_group_name = "tf-backend-rg"
subnets = {
  "dev-subnet-priv" = {
    address_prefix = "10.0.1.0/24"
  }
  "dev-subnet-db" = {
    address_prefix = "10.0.2.0/24"
  }
  "dev-subnet-public" = {
    address_prefix = "10.0.3.0/24"
  }
}
