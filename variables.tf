# general
variable "location" {
  type        = string
  description = "The location where the resources are going to be created."
}

variable "resource_group_name" {
  type        = string
  description = "The name of an existing resource group."
}

# spoke vnet
variable "name" {
  type        = string
  description = "The name of the vnet."
}

variable "address_space" {
  type        = list(string)
  description = "The address space of the vnet."
}

# related hub vnet
variable "hub_vnet_name" {
  type        = string
  description = "The name of the existing hub vnet."
}

variable "hub_vnet_resource_group_name" {
  type        = string
  description = "The name of the resource group of the existing hub vnet."
}

variable "hub_vnet_id" {
  type        = string
  description = "The id of the existing hub vnet."
}

# subnets of this spoke vnet (optional)
variable "subnets" {
  type = list(object({
    name             = string,
    address_prefixes = list(string)
  }))

  default     = []
  description = <<-EOT
  (Optional) The array of subnets to create in this spoke vnet. For every subnet:

    name : the name of the subnet.
    address_prefixes : the list of address prefixes of the subnet. 
  EOT
}

# tags (optional)
variable "tags" {
  type        = map(string)
  default     = {}
  description = "(Optional) The tags to apply to all resources."
}