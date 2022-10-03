# Azure Landing Zone Spoke

This module provisions a **spoke vnet** in an Azure Landing Zone.

It is intented to be used in conjonction with the following modules :
 - **lz-hub module** which can be found here : https://registry.terraform.io/modules/ldesmons-telstra/lz-hub/azurerm/latest
 - **lz-association module** which can be found here : https://registry.terraform.io/modules/ldesmons-telstra/lz-association/azurerm/latest

![Telstra - Landing Zone (1)](https://user-images.githubusercontent.com/108506349/193437641-95b26822-e1c1-4df2-ab2c-740a511cb4bd.png)

## Features 

- creates a **spoke vnet** with optional subnets.

## Usage

**Create a hub vnet and a spoke vnet**

```terraform

# resource groups
resource "azurerm_resource_group" "rg_hub" {
  name     = "my-rg-hub"
  location = "southeastasia"
  tags     = {
    "environment" : "dev"
  }
}

resource "azurerm_resource_group" "rg_spoke" {
  name     = "my-rg-spoke"
  location = "southeastasia"
  tags     = {
    "environment" : "dev"
  }
}

# hub vnet
module "vnet_hub" {
  source  = "ldesmons-telstra/lz-hub/azurerm"
  version = "1.0.2"

  location            = "southeastasia"
  resource_group_name = "my-rg-hub"
  name                = "my-vnet-hub"
  address_space       = ["10.10.31.0/24"]

  vnet_gateway_name                   = "my-vnet-gateway"
  vnet_gateway_address_prefixes       = ["10.10.31.128/27"]
  vnet_gateway_public_ip_name         = "my-vnet-gateway-pip"
  local_network_gateway_name          = "my-local-network-gateway"
  local_network_gateway_address       = "203.134.151.51"
  local_network_gateway_address_space = ["192.1.1.0/24", "192.168.0.0/24", "192.168.1.0/24", "192.2.2.0/24"]
  gateway_connection_name             = "my-local-network-gateway-connection"
  gateway_connection_shared_key       = "shared-key"

  firewall_name                       = "my-firewall"
  firewall_public_ip_name             = "my-firewall-pip"
  firewall_subnet_address_prefixes    = ["10.10.31.0/26"]

  bastion_name                        = "my-bastion"
  bastion_public_ip_name              = "my-bastion-pip"
  bastion_subnet_address_prefixes     = ["10.10.31.64/26"]

  tags = {
    "environment" : "dev"
  }
}

# spoke vnet (can add multiple spoke modules like this)
module "vnet_spoke" {
  source              = "ldesmons-telstra/lz-spoke/azurerm"
  version             = "1.0.2"

  location            = "southeastasia"
  resource_group_name = "my-rg-spoke"
  name                = "vnet-spoke"
  address_space       = ["10.0.0.0/24"]

  subnets = {
    subnet-01 = {
      name             = "subnet-01"
      address_prefixes = ["10.0.0.0/26"]
    }
    subnet-02 = {
      name             = "subnet-02"
      address_prefixes = ["10.0.0.1/26"]
    }
  }

  tags = {
    "environment" : "dev"
  }
}
```

