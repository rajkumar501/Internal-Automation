variable "name" {
  description = "VM name"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "location" {
  description = "Azure location"
  type        = string
}

variable "admin_username" {
  description = "Admin username"
  type        = string
}

variable "admin_password" {
  description = "Admin password (for Windows)"
  type        = string
  default     = null
}

variable "admin_ssh_key" {
  description = "SSH public key (for Linux)"
  type        = string
  default     = null
}

variable "os_type" {
  description = "OS type: linux or windows"
  type        = string
}

variable "size" {
  description = "VM size"
  type        = string
  default     = "Standard_B2ms"
}

variable "network_interface_ids" {
  description = "List of NIC IDs"
  type        = list(string)
}

variable "image_publisher" {
  description = "Image publisher"
  type        = string
}

variable "image_offer" {
  description = "Image offer"
  type        = string
}

variable "image_sku" {
  description = "Image SKU"
  type        = string
}

variable "image_version" {
  description = "Image version"
  type        = string
  default     = "latest"
}

variable "os_disk_type" {
  description = "OS disk type"
  type        = string
  default     = "Standard_LRS"
}

variable "tags" {
  description = "Tags"
  type        = map(string)
  default     = {}
} 