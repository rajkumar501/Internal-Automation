module vm{
  source = "./vm/"
  location = var.location
  tags = var.tags
  app = var.app
  data_disks = var.data_disks
  resourcegroup = var.resourcegroup
  subnet_id = data.azurerm_subnet.snet.id
  size = var.size
  vm_ip_addresses = var.vm_ip_addresses
  username = var.username
  vm_image_publisher = var.vm_image_publisher
  vm_image_offer = var.vm_image_offer
  vm_image_sku = var.vm_image_sku
  vm_image_version = var.vm_image_version
  availability_zones = var.availability_zones
  vm_backup_enabled = var.vm_backup_enabled
  vm_os_storagetype = var.vm_os_storagetype
  boot_diagnostics = data.azurerm_storage_account.sa.primary_blob_endpoint

}   

data "azurerm_storage_account" "sa" {
  name                = "test"
  resource_group_name = "test"
}

data "azurerm_subnet" "snet"{
    name  = "internal"
    virtual_network_name = "test"
    resource_group_name = "test"
}

variable "location" {
  default = "East US"
  type = string
}

variable "tags" {
  default = ""
  type = string
}

variable "app" {
  default = "test"
  type = string
}

variable "resourcegroup" {
  default = "test"
  type = string
}


variable "size" {
    default = "Standard_F2"
  type = string
}


variable "username" {
  default = "admin"
  type = string
}


variable "vm_image_publisher" {
default = "MicrosoftWindowsServer"
type = string 
}

variable "vm_image_offer" {
    default = "WindowsServer"
type = string 
}

variable "vm_image_sku" {
    default = "2016-Datacenter"
type = string 
}

variable "vm_image_version" {
    default = "latest"
type = string 
}

variable "availability_zones" {
  type = list
  default = [
    {
      region = "canadacentral"
      zones = [1, 2, 3]
    }
  ]
}

variable "vm_backup_enabled" {
type = bool   
default = false
}

variable "vm_os_storagetype" {
  type = string 
  default = "Standard_LRS"
}

variable "vm_ip_addresses"{
    default = [
        "10.0.1.4"
    ]
}

variable "data_disks"{
    default = []
}

variable "boot_diagnostics" {
  default = ""
}