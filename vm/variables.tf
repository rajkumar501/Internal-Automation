variable "location" {
  type = string
}

variable "tags" {
  type = string
}

variable "app" {
  type = string
}



variable "resourcegroup" {
  type = string
}


variable "subnet_id" {
  type = string
}

variable "size" {
  type = string
}


variable "username" {
  type = string
}


variable "vm_image_publisher" {
type = string 
}

variable "vm_image_offer" {
type = string 
}

variable "vm_image_sku" {
type = string 
}

variable "vm_image_version" {
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
}
variable "vm_os_storagetype" {
  type = string 
}

variable "vm_ip_addresses" {
  type = list
}

variable "data_disks"{
  type = list
}
variable "boot_diagnostics" {
  type = string 
}