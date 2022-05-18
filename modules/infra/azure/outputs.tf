output "rg_location" {
  description = "Resource group location"
  value       = azurerm_resource_group.rg.location
}

output "rg_name" {
  description = "Resource group id"
  value       = azurerm_resource_group.rg.name
}

output "vnet_id" {
  description = "vNet id"
  value       = module.vnet.vnet_id
}

output "subnet_ids" {
  description = "Subnet ids"
  value       = module.vnet.vnet_subnets
}

output "nsg_name" {
  description = "Network security group id"
  value       = azurerm_network_security_group.nsg.name
}

output "nprf_id" {
  description = "Network profile id" 
  value       = azurerm_network_profile.nprf.id 
}
