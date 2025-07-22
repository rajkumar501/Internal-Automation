output "vmss_id" {
  value = var.os_type == "linux" ? azurerm_linux_virtual_machine_scale_set.this[0].id : azurerm_windows_virtual_machine_scale_set.this[0].id
} 