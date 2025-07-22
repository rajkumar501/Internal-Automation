package azure.compute.vmss

default allow = true

# Basic cost optimization: discourage use of expensive VMSS sizes
violation["Avoid using expensive VMSS sizes"] {
  input.resource_type == "azurerm_linux_virtual_machine_scale_set" || input.resource_type == "azurerm_windows_virtual_machine_scale_set"
  expensive_sizes := {"Standard_DS5_v2", "Standard_E64s_v3", "Standard_M128ms"}
  expensive_sizes[input.size]
}

# Basic security: require SSH key for Linux VMSS
violation["Linux VMSS must have SSH key authentication"] {
  input.resource_type == "azurerm_linux_virtual_machine_scale_set"
  not input.admin_ssh_key
}

# Basic security: require password complexity for Windows VMSS
violation["Windows VMSS must have complex admin password"] {
  input.resource_type == "azurerm_windows_virtual_machine_scale_set"
  not re_match("^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[!@#$%^&*]).{12,}$", input.admin_password)
} 