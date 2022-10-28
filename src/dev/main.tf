terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.91.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "terrastate-rg"
    storage_account_name = "kirk0terrastate"
    container_name       = "dev"
    key                  = "terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}

data "azuread_client_config" "current" {}

resource "azurerm_resource_group" "rg" {
  name     = "test-rg"
  location = var.location
}


module "keyvault" {
  source = "../../module/keyvault"
  env    = var.env

  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  tenant_id           = data.azuread_client_config.current.tenant_id
  obj_id              = data.azuread_client_config.current.object_id

  sku_name                 = "standard"
  purge_protection_enabled = false
}

module "main-virtual-machine" {
  source = "../../module/virtual_machine"
  env    = var.env

  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location

  virtual_network_name = "main"
  subnet_name          = "vm-subnet"

  vm = local.vm

  tags = local.tags
}