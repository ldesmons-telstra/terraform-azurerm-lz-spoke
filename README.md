# Azure Landing Zone Spoke

This module provisions a **spoke vnet** in an Azure Landing Zone.

It is intented to be used in conjonction with the **lz-hub module** which can be found here : https://registry.terraform.io/modules/ldesmons-telstra/lz-hub/azurerm/latest

![Telstra - Landing Zone](https://user-images.githubusercontent.com/108506349/190936360-905c5834-e92d-4465-96cc-d31954f0aa36.png)

## Features 

- creates a **spoke vnet** with optional subnets. The spoke vnet must be linked to a **hub vnet** (usually created by the lz-hub module).
- adds **vnet peerings** between the hub vnet and this spoke vnet (both ways).

## Usage

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
  address_space       = ["10.0.0.0/24"]
  subnets = [
    {
      address_prefixes = ["10.0.0.0/26"]
      name             = "subnet-01"
    },
    {
      address_prefixes = ["10.0.0.1/26"]
      name             = "subnet-02"
    }
  ]
  hub_vnet_id = "id of the hub vnet"
  hub_vnet_name = "name of the hub vnet"
  hub_vnet_resource_group_name = "name of the resource group of the hub vnet"
  tags = {
    "environment" : "dev"
  }
}
```

