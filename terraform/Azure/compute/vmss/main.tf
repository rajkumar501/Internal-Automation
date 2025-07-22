resource "azurerm_linux_virtual_machine_scale_set" "this" {
  count                 = var.os_type == "linux" ? 1 : 0
  name                  = var.name
  resource_group_name   = var.resource_group_name
  location              = var.location
  sku                   = var.size
  instances             = var.instance_count
  admin_username        = var.admin_username
  admin_ssh_key {
    username   = var.admin_username
    public_key = var.admin_ssh_key
  }
  network_interface {
    name    = "${var.name}-nic"
    primary = true
    ip_configuration {
      name      = "${var.name}-ipconfig"
      subnet_id = var.subnet_id
      primary   = true
    }
  }
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = var.os_disk_type
  }
  source_image_reference {
    publisher = var.image_publisher
    offer     = var.image_offer
    sku       = var.image_sku
    version   = var.image_version
  }
  tags = var.tags
}

resource "azurerm_windows_virtual_machine_scale_set" "this" {
  count                 = var.os_type == "windows" ? 1 : 0
  name                  = var.name
  resource_group_name   = var.resource_group_name
  location              = var.location
  sku                   = var.size
  instances             = var.instance_count
  admin_username        = var.admin_username
  admin_password        = var.admin_password
  network_interface {
    name    = "${var.name}-nic"
    primary = true
    ip_configuration {
      name      = "${var.name}-ipconfig"
      subnet_id = var.subnet_id
      primary   = true
    }
  }
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = var.os_disk_type
  }
  source_image_reference {
    publisher = var.image_publisher
    offer     = var.image_offer
    sku       = var.image_sku
    version   = var.image_version
  }
  tags = var.tags
} 