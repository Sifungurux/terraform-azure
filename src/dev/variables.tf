variable "project_name" {
  type    = string
  default = "Developemnt of terraform skills"
}

variable "location" {
  type        = string
  description = "The location for the RG"
}

variable "resource_group_name" {
  type        = string
  description = "The name of the Resouce Group"
}

variable "env" {
  type = string
}

#variable "admin_username" {
#  description = "Administrator username"
#  type        = string
#  sensitive   = true
#
# validation {
#    condition     = var.admin_username != "admin"
#    error_message = "Admin username may not be admin. Change it to a more unique username"
#  }
#}

#variable "admin_password" {
#  description = "Administrator password"
#  type        = string
#  sensitive   = true
#}



variable "resource_tags" {
  description = "Tags to set for all resources"
  type        = map(string)
  default     = {}
}

locals {
  required_tags = {
    "project"     = var.project_name,
    "environment" = var.env,
    "created_at"  = formatdate("MMM DD, YYYY", timestamp())
  }
  tags = merge(var.resource_tags, local.required_tags)

  vm = {
    tftest : {
      vm_size                         = "Standard_B1ls"
      publisher                       = "Debian"
      offer                           = "debian-10"
      sku                             = 10
      os_version                      = "latest"
      disc_name                       = "osdisk"
      caching                         = "ReadWrite"
      create_option                   = "FromImage"
      managed_disk_type               = "Standard_LRS"
      hostname                        = "tftest"
      admin_username                  = "kirk"
      admin_password                  = "JKDF2fef3!!3"
      disable_password_authentication = false
    },
    tftest2 : {
      vm_size                         = "Standard_B1ls"
      publisher                       = "Debian"
      offer                           = "debian-10"
      sku                             = 10
      os_version                      = "latest"
      disc_name                       = "osdisk"
      caching                         = "ReadWrite"
      create_option                   = "FromImage"
      managed_disk_type               = "Standard_LRS"
      hostname                        = "tftest"
      admin_username                  = "kirk"
      admin_password                  = "JKDF2fef3!!3"
      disable_password_authentication = false
    }
  }
}
