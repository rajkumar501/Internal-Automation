output "vm_id" {
  value = var.os_type == "linux" ? azurerm_linux_virtual_machine.this[0].id : azurerm_windows_virtual_machine.this[0].id
}
output "vm_public_ip" {
  value = var.os_type == "linux" ? azurerm_linux_virtual_machine.this[0].public_ip_address : azurerm_windows_virtual_machine.this[0].public_ip_address
} 