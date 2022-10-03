/* -----------------------
   Output variables.
   -----------------------
*/

output "vnet_id" {
  value       = azurerm_virtual_network.vnet.id
  description = "The id of the newly created spoke vnet."
}

output "subnets_ids" {
  value       = tomap({ for k, subnet in azurerm_subnet.subnets : k => subnet.id })
  description = "The ids of the newly created spoke subnets in the spoke vnet."
}