terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.91.0"
    }
  }
}
provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "terrastate-rg"
  location = "westeurope"
  tags = {
    created_on = "28102022"
    created_by = "Jonas Kirk Pedersen"
  }
  lifecycle {
    prevent_destroy = true
  }
}


resource "azurerm_storage_account" "storage" {
  name                     = "kirk0terrastate"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
	allow_blob_public_access = true
  min_tls_version          = "TLS1_2"

	tags = local.tags
}

resource "azurerm_storage_container" "container" {
  for_each = local.env_container


  name                  = each.key
  storage_account_name  = azurerm_storage_account.storage.name
  container_access_type = each.value.access_type
}