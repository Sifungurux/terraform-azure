resource "azurerm_virtual_network" "main" {
  name = "vn-${var.virtual_network_name}-${var.env}"
  resource_group_name = var.resource_group_name
  location = var.location
  address_space = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "main-subnets" {
  name = var.subnet_name
  resource_group_name = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes = [ "10.0.1.0/24" ]
}

resource "azurerm_network_interface" "main" {
  for_each = var.vm

  location            = var.location
  resource_group_name = var.resource_group_name
  
  name                = each.key
  ip_configuration {
    name                          = "mainInterface"
    subnet_id                     = azurerm_subnet.main-subnets.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_virtual_machine" "main" {
  for_each = var.vm
  location              = var.location
  resource_group_name   = var.resource_group_name
  network_interface_ids = [azurerm_network_interface.main[each.key].id]

  name      = each.key
  vm_size   = each.value.vm_size
  storage_image_reference {
    publisher   = each.value.publisher
    offer       = each.value.offer
    sku         = each.value.sku
    version     = each.value.os_version
  }
  storage_os_disk {
    name   = "${each.key}-${each.value.disc_name}"
    caching   = each.value.caching
    create_option   = each.value.create_option
    managed_disk_type   = each.value.managed_disk_type
  }
  os_profile {
    computer_name    = each.value.hostname
    admin_username   = each.value.admin_username
    admin_password   = each.value.admin_password
  }
  os_profile_linux_config {
    disable_password_authentication = each.value.disable_password_authentication
  }


  tags = var.tags
  
  depends_on = [
    azurerm_network_interface.main
  ]
}


/* module "diagnostic_setting" {
  source = "../diagnostic_setting" 
  for_each = var.vm
  target_resource_id = data.azurerm_virtual_machine.name[each[key]]
  env = var.env  
} */