output "subnet_ids" {
  value = { for s in azurerm_subnet.subnet : s.name => s.id }
}
output "private_ips" {
  description = "Private IP addresses of the created virtual machines"
  value       = module.vm.private_ips
}
output "public_ips" {
  description = "Public IP addresses of the created virtual machines"
  value       = module.vm.public_ips
}


