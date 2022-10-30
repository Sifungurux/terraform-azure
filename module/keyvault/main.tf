resource "azurerm_key_vault" "key-vault" {
  name     = local.name
  location = var.location
  resource_group_name = var.resource_group_name

  enabled_for_disk_encryption = var.enabled_for_disk_encryption
  enabled_for_deployment      = var.enabled_for_deployment
  enabled_for_template_deployment = var.enabled_for_template_deployment

  soft_delete_retention_days  = var.soft_delete_retention_days
  purge_protection_enabled    = var.purge_protection_enabled

  tenant_id                   = var.tenant_id
  sku_name = var.sku_name
  tags = var.tags

  network_acls {
    default_action = "Deny"
    bypass         = "AzureServices"
  }

  lifecycle {
    postcondition {
      condition = self.enabled_for_disk_encryption
      error_message = "Disk not encrypted"
    }
  }
}

# This policy must be kept for a proper run of the "destroy" process
resource "azurerm_key_vault_access_policy" "default_policy" {
  key_vault_id = azurerm_key_vault.key-vault.id
  tenant_id    = var.tenant_id
  object_id = var.obj_id

  lifecycle {
    create_before_destroy = true
  }

  key_permissions = var.kv-key-permissions-full
  secret_permissions = var.kv-secret-permissions-full
  certificate_permissions = var.kv-certificate-permissions-full
  storage_permissions = var.kv-storage-permissions-full
}