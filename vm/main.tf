
resource "random_password" "password" {
  count = length(var.vm_ip_addresses)
  length = 16
  special = true
  override_special = "_%@"
}

#########
# DISK
#########


# resource "azurerm_managed_disk" "data_disk" {
#     for_each = {for disk in local.data.disks : disk.id => disk }
#     name = format("disk-%s", each.key)
#     location = var.location
#     resource_group_name = var.resource_group
#     storage_account_type = "Premium_LRS"
#     create_option = "Empty"
#     disk_size_gb = each.value.size_gb
#     zones = each.value.zones
#     tags = local.resource_tags
# }

# resource "azurerm_virtual_machine_data_disk_attachment" "disk_attach" {
#   for_each = {for disk in local.data_disks:  disk.id => disk}
#   managed_disk_id = azurerm_managed_disk.data_disk[each.key].id 
#   virtual_machine_id =  azurerm_linux_virtual_machine.vm[each.value.vm].id 
#   lun = each.value.lun
#   caching = each.value.caching
# }


##########
# Network
##########

resource "azurerm_network_interface" "nic" {
  for_each = {for vm in local.virtual_machines :  vm.id => vm }
  name                = format("nic-%s", each.value.id)
  location            = each.value.location
  resource_group_name = each.value.resourcegroup

  ip_configuration {
    name                          = "Primary"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = true ? "Static" : "Dynamic"
    private_ip_address = each.value.ip_address 
    primary = true
  }
}

###########
# Compute
###########


resource "azurerm_windows_virtual_machine" "vm" {
  for_each = { for vm in local.virtual_machines: vm.id => vm }
  name                = format("vm%s", each.value.id)
  resource_group_name = each.value.resourcegroup
  location            = each.value.location
  size                = each.value.size
  admin_username      = each.value.username
  admin_password      = try(each.value.password, element(concat(random_password.password.*.result, [""]), index(local.virtual_machines, each.value)))
  network_interface_ids = [
       azurerm_network_interface.nic[each.key].id
  ]

  os_disk {
    name = format("osdisk-%s", each.value.id)
    caching              = try("ReadWrite")
    storage_account_type = try(each.value.vm_os_storagetype, "Standard_LRS")
  }

  source_image_reference {
    publisher = try(each.value.vm_image_publisher,"MicrosoftWindowsServer")
    offer     =  try(each.value.vm_image_offer,"WindowsServer")
    sku       =  try(each.value.vm_image_sku,"2016-Datacenter")
    version   =  try(each.value.vm_image_version,"latest")
  }
  boot_diagnostics {
    storage_account_uri = each.value.boot_diagnostics_sa
  }
  depends_on = [
    azurerm_network_interface.nic
  ]
}