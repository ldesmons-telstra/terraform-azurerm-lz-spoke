variable "location" {
  type        = string
  description = "Location where the resources are going to be created."
}

variable "resource_group_name" {
  type        = string
  description = "Name of the Resource Group."
}

variable "name" {
  type        = string
  description = "Name of the VNET"
}

variable "address_space" {
  type        = list(string)
  description = "Address space of the VNET"
}

variable "vnet_hub" {
  type = object({
    name                = string,
    resource_group_name = string,
    id                  = string
  })
}

variable "subnets" {
  type = list(object({
    name             = string,
    address_prefixes = list(string)
  }))

  default = [] # optional
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags to apply to all resources"
}