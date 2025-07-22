package azure.compute.vm

default allow = true

# Basic cost optimization: discourage use of expensive VM sizes
violation["Avoid using expensive VM sizes"] {
  input.resource_type == "azurerm_linux_virtual_machine" || input.resource_type == "azurerm_windows_virtual_machine"
  expensive_sizes := {"Standard_DS5_v2", "Standard_E64s_v3", "Standard_M128ms"}
  expensive_sizes[input.size]
}

# Basic security: require SSH key for Linux VMs
violation["Linux VM must have SSH key authentication"] {
  input.resource_type == "azurerm_linux_virtual_machine"
  not input.admin_ssh_key
}

# Basic security: require password complexity for Windows VMs
violation["Windows VM must have complex admin password"] {
  input.resource_type == "azurerm_windows_virtual_machine"
  not re_match("^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[!@#$%^&*]).{12,}$", input.admin_password)
} 