variables {
  name                  = "test-vmss"
  resource_group_name   = "test-rg"
  location              = "eastus"
  admin_username        = "azureuser"
  admin_ssh_key         = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQD..."
  os_type               = "linux"
  size                  = "Standard_B2ms"
  subnet_id             = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/test-rg/providers/Microsoft.Network/virtualNetworks/test-vnet/subnets/test-subnet"
  instance_count        = 2
  image_publisher       = "Canonical"
  image_offer           = "UbuntuServer"
  image_sku             = "18.04-LTS"
  image_version         = "latest"
  os_disk_type          = "Standard_LRS"
  tags                  = { env = "test" }
}

run "basic_linux_vmss" {
  command = apply
  assert {
    condition     = can(regex("^/", output.vmss_id))
    error_message = "vmss_id should be a string starting with /"
  }
} 