# Azure Landing Zone Spoke

This module provisions a **spoke vnet** in an Azure Landing Zone.

It is intented to be used in conjonction with the **lz-hub module** which can be found here : https://registry.terraform.io/modules/ldesmons-telstra/lz-hub/azurerm/latest

## Features 

- creates a **spoke vnet** with optional subnets. The spoke vnet must be linked to a **hub vnet** (usually created by the lz-hub module).
- adds **vnet peerings** between the hub vnet and this spoke vnet (both ways).

## Usage

**Create a spoke vnet without subnets.**

```terraform
resource "azurerm_resource_group" "rg_spoke" {
  name     = "my-rg"
  location = "southeastasia"
  tags     = {
    "environment" : "dev"
  }
}

module "vnet_spoke" {
  source              = "ldesmons-telstra/lz-spoke/azurerm"
  version             = "1.0.0"
  location            = "southeastasia"
  resource_group_name = "my-rg"
  name                = "vnet-spoke"
  address_space       = ["10.10.31.0/24"]

  hub_vnet_id = "_id of the hub vnet_"
  hub_vnet_name = "name of the hub vnet"
  hub_vnet_resource_group_name = "name of the resource group of the hub vnet"

  tags = = {
    "environment" : "dev"
  }
}
```

