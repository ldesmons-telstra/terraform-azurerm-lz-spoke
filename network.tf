# Create the VNET
resource "azurerm_virtual_network" "vnet" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = var.address_space
  tags                = var.tags
}

# Create the subnets (optional)
resource "azurerm_subnet" "subnets" {
  count                = length(var.subnets)
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  name                 = var.subnets[count.index].name
  address_prefixes     = var.subnets[count.index].address_prefixes
}

# Create the peerings with the hub vnet (both ways)
resource "azurerm_virtual_network_peering" "hub-spoke-peering" {
  name                      = "${var.hub_vnet_name}-to-${azurerm_virtual_network.vnet.name}-peering"
  resource_group_name       = var.hub_vnet_resource_group_name
  virtual_network_name      = var.hub_vnet_name
  remote_virtual_network_id = azurerm_virtual_network.vnet.id
}

resource "azurerm_virtual_network_peering" "spoke-hub-peering" {
  name                      = "${azurerm_virtual_network.vnet.name}-to-${var.hub_vnet_name}-peering"
  resource_group_name       = var.resource_group_name
  virtual_network_name      = azurerm_virtual_network.vnet.name
  remote_virtual_network_id = var.hub_vnet_id
}