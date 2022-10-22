##################################
# Azure Resource Group variables #
##################################

variable "resource_group_name" {
  type        = string
  description = "The name of an existing Resource Group"
}

variable "location" {
  type        = string
  description = "Define the region the Azure Key Vault should be created, you should use the Resource Group location"
}


#################################
#      Module varialbles        #
#################################

variable "env" {
    type = string
    default = "dev"

    validation {
      condition     = length(var.env) < 4 && lower(var.env) == var.env
      error_message = "Environment value should be in lowercase and as an akronym"
  }
}

variable "virtual_network_name" {
    type = string

    validation {
      condition = lower(var.virtual_network_name) == var.virtual_network_name
      error_message = "virtual_network_name needs to be in lowercase"    
    }
}

variable "subnet_name" {
  type = string
}

variable "tags" {
  type = map(any)
}

variable "vm" {
  type = any
}