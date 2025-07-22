module "test_vm" {
  source                = ".."
  name                  = "test-vm"
  resource_group_name   = "test-rg"
  location              = "eastus"
  admin_username        = "azureuser"
  admin_ssh_key         = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQD..."
  os_type               = "linux"
  size                  = "Standard_B2ms"
  network_interface_ids = ["/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/test-rg/providers/Microsoft.Network/networkInterfaces/test-nic"]
  image_publisher       = "Canonical"
  image_offer           = "UbuntuServer"
  image_sku             = "18.04-LTS"
  image_version         = "latest"
  os_disk_type          = "Standard_LRS"
  tags                  = { env = "test" }
} 