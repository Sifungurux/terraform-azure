output "target_id" {
  value = [
    for tg in azurerm_virtual_machine.main : tg.id
  ]
}