
resource "azurerm_monitor_diagnostic_setting" "resource" {
  name               = "Cental log for ${var.env} evenvironemnt "
  target_resource_id = var.target_resource_id

  eventhub_authorization_rule_id = var.eventhub ? var.eventhub : null
  log_analytics_workspace_id = var.log_analytics ? var.log_analytics : null
  storage_account_id = var.storage_account ? var.storage_account : null

  log {
    category = "AuditEvent"
    enabled  = false

    retention_policy {
      enabled = false
    }
  }
  metric {
    category = "AllMetrics"

    retention_policy {
      enabled = false
    }
  }
}