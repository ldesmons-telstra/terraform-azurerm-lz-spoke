/* -----------------------
   Create the vnet.
   -----------------------
*/

resource "azurerm_virtual_network" "vnet" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = var.address_space
  tags                = var.tags
}

/* -----------------------
   Create the subnets (optional).
   -----------------------
*/

resource "azurerm_subnet" "subnets" {
  for_each             = var.subnets
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  name                 = each.value.name
  address_prefixes     = each.value.address_prefixes
}
