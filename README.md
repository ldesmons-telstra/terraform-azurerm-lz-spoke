# Azure Landing Zone Spoke

This module provisions a Spoke vnet in an Azure Landing Zone.

It is intented to be used in conjonction with the lz-hub module, which can be found here : [https://registry.terraform.io/modules/ldesmons-telstra/lz-hub/azurerm/latest]

## Features 
***

- creates a spoke vnet with optional subnets.
- adds vnet peerings between the hib vnet and this spoke vnet.

## Usage
***

```
resource "azurerm_resource_group" "rg-spoke" {
  name     = var.resource_groups.spoke_name
  location = var.location
  tags     = var.tags
}

module "vnet_spoke" {
  source              = "ldesmons-telstra/lz-spoke/azurerm"
  version             = "1.0.0"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg-spoke.name
  name                = var.vnet_spoke1.name
  address_space       = var.vnet_spoke1.address_space
  subnets             = var.vnet_spoke1.subnets

  vnet_hub = {
    id                  = module.vnet_hub.vnet_id
    name                = var.vnet_hub.name
    resource_group_name = var.resource_groups.hub_name
  }

  tags = var.tags
}
```

