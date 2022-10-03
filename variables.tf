/* -----------------------
   General variables (required).
   -----------------------
*/

variable "location" {
  type        = string
  description = "The location where the resources are going to be created."
}

variable "resource_group_name" {
  type        = string
  description = "The name of an existing resource group."
}

/* -----------------------
   Spoke vnet variables (required).
   -----------------------
*/

variable "name" {
  type        = string
  description = "The name of the vnet."
}

variable "address_space" {
  type        = list(string)
  description = "The address space of the vnet."
}

/* -----------------------
   Subnets variables (optional).
   -----------------------
*/

variable "subnets" {
  type = map(object({
    name             = string,
    address_prefixes = list(string)
  }))

  default     = {}
  description = "(Optional) The map of subnets to create in this spoke vnet."
}

/* -----------------------
   Tags (optional).
   -----------------------
*/

variable "tags" {
  type        = map(string)
  default     = {}
  description = "(Optional) The tags to apply to all resources."
}