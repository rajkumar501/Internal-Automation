# Azure VM Terraform Module

This module deploys an Azure Virtual Machine (Linux or Windows) with configurable parameters.

## Usage
```hcl
module "vm" {
  source                = "./vm"
  name                  = "example-vm"
  resource_group_name   = "my-rg"
  location              = "eastus"
  admin_username        = "azureuser"
  admin_ssh_key         = "ssh-rsa ..."
  os_type               = "linux"
  size                  = "Standard_B2ms"
  network_interface_ids = ["/subscriptions/.../networkInterfaces/example-nic"]
  image_publisher       = "Canonical"
  image_offer           = "UbuntuServer"
  image_sku             = "18.04-LTS"
  image_version         = "latest"
  os_disk_type          = "Standard_LRS"
  tags                  = { env = "dev" }
}
```

## Variables
- `name` (string): VM name
- `resource_group_name` (string): Resource group name
- `location` (string): Azure location
- `admin_username` (string): Admin username
- `admin_password` (string, optional): Admin password (for Windows)
- `admin_ssh_key` (string, optional): SSH public key (for Linux)
- `os_type` (string): OS type: `linux` or `windows`
- `size` (string): VM size (default: `Standard_B2ms`)
- `network_interface_ids` (list(string)): List of NIC IDs
- `image_publisher` (string): Image publisher
- `image_offer` (string): Image offer
- `image_sku` (string): Image SKU
- `image_version` (string): Image version (default: `latest`)
- `os_disk_type` (string): OS disk type (default: `Standard_LRS`)
- `tags` (map(string)): Tags (default: `{}`)

## Outputs
- `vm_id`: The ID of the created VM
- `vm_public_ip`: The public IP address of the VM

## Testing
Run automated tests with:
```sh
terraform test
```

## License
MIT 